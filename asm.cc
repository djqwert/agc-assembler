#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <getopt.h>

#define  MAX_CODE_LINES	1000
#define  MAX_DATA_RECORS 300
#define  MAX_REG_RECORDS 50

#define  MAX_SYM_RECORDS 100
#define  MAX_JUMP_RECORS 250
#define  MAX_OPCODE_RECORDS 50

#define MAX_OPERAND_LEN	30
#define MAX_OPCODE_LEN 10
#define MAX_ADDR_LEN 16+1

#define START_ROM_COUNT 2100
#define START_RAM_COUNT 200

bool fsym = 0, fop = 0, fcode = 0, fdata = 0, fconst = 0, fvar = 0, fnotfound = 0;
char *token, opcode[MAX_OPCODE_LEN], operand[MAX_OPERAND_LEN];
int counter = START_ROM_COUNT;  //holds the address of the machine code instruction
int datacounter = START_RAM_COUNT;
FILE* list;

// A label is a symbol which mark a location in a program.
struct symbol_t{
	int location;
	char label[MAX_OPERAND_LEN];
};
struct symbol_t symtable[MAX_SYM_RECORDS]; //there can be 50 labels at most in our programs
int nsym = 0; //number of labels encountered during assembly.

struct reg_t{
	int location;
	char label[MAX_OPERAND_LEN];
};
struct reg_t regtable[MAX_REG_RECORDS]; 
int nreg = 0;

struct jmp_t{
	int id;
	int charset;
	char label[MAX_OPERAND_LEN];
	char address[MAX_ADDR_LEN];
};
struct jmp_t jmptable[MAX_JUMP_RECORS]; 
int njmp = 0;

struct opcode_t{
	char opcode[MAX_OPCODE_LEN];
	char translation[MAX_ADDR_LEN];
	int charset;
};
struct opcode_t optable[MAX_OPCODE_RECORDS]; 
int nopcode = 0;

struct data_t{
	int lc;
	char label[MAX_OPERAND_LEN];
	int value;
};
struct data_t data[MAX_DATA_RECORS];
int ndatalines = 0;

struct machine_t{
	int id;
	int lc;		// local counter
	char opcode[16];
	char symbol[MAX_OPERAND_LEN];
};
struct machine_t code[MAX_CODE_LINES];
int ncodelines = 0;

void insert_opcode(const char *op, const char *translation){
	if(nopcode >= MAX_OPCODE_RECORDS){
		printf("[Err] OPCODE table is full. Check list.lst files\n");
		fprintf(list, "\n\n[Err] OPCODE table is full\n");
		exit(1);
	}
	strcpy(optable[nopcode].opcode,op);
	strcpy(optable[nopcode].translation,translation);
	optable[nopcode++].charset = 16 - strlen(translation);
}

void optable_init(){
	insert_opcode("XXALQ","0000000000000000");
	insert_opcode("XLQ","0000000000000010");
	insert_opcode("RETURN","0000000000000100");
	insert_opcode("RELINT","0000000000000110");
	insert_opcode("INHINT","0000000000001000");
	insert_opcode("EXT","0000000000001100");
	insert_opcode("TC","000");
	insert_opcode("CCS","00100");
	insert_opcode("TCF","001");
	insert_opcode("DAS","01000");
	insert_opcode("LXCH","01001");
	insert_opcode("INCR","01010");
	insert_opcode("ADS","01011");
	insert_opcode("CA","011");
	insert_opcode("CS","100");
	insert_opcode("INDEX","10100");
	insert_opcode("RESUME","1010000000100010");
	insert_opcode("NOOP","0110000000000000");
	insert_opcode("DXCH","10101");
	insert_opcode("TS","10110");
	insert_opcode("XCH","10111");
	insert_opcode("AD","110");
	insert_opcode("MASK","111");
	insert_opcode("READ","000000");
	insert_opcode("WRITE","000001");
	insert_opcode("RAND","000010");
	insert_opcode("WAND","000011");
	insert_opcode("ROR","000100");
	insert_opcode("WOR","000101");
	insert_opcode("RXOR","000110");
	insert_opcode("ALT","0001110000000000");
	insert_opcode("DV","00101");
	insert_opcode("BZF","001");
	insert_opcode("MSU","010");
	insert_opcode("QXCH","01001");
	insert_opcode("AUG","01010");
	insert_opcode("DIM","01011");
	insert_opcode("DCA","011");
	insert_opcode("DCS","100");
	insert_opcode("SU","11000");
	insert_opcode("BZMF","110");
	insert_opcode("MP","111");
}

void print_dec2bin(char* symbol, int bits);

void insert_label();
bool search_symbol(char*);
bool search_register(char*);
void insert_jmp(const char *, int);

int search_opcode(){
	for(int i = 0; i < nopcode; i++)
		if(!strcmp(token, optable[i].opcode))
			return i;
	return -1;
}

void islabel(){
	if(search_opcode() == -1){
		if(token[strlen(token)-1] == ':'){
			token[strlen(token)-1]='\0';
			insert_label();
			fprintf(list, "%15s:", token);
			fsym = 1;
			return;
		}else{
			printf("[Err] Label '%s' in row. %04x not valid. Check list.lst file\n", token, counter);
			fprintf(list, "\n\n[Err] Label '%s' in row. %04x not valid\n", token, counter);
			exit(1);
		}
	}
	fprintf(list, "%15c",' ');
}

int isopcode(){
	if(fsym){
		fprintf(list, "\t");
		token = strtok(NULL,"\n\t\r ");
	}
	strcpy(opcode,token);
	if(int i = search_opcode()){
		if(!fsym) 
			fprintf(list, "\t"); 
		fprintf(list, "%s", optable[i].translation);
		code[ncodelines].id = ncodelines;
		code[ncodelines].lc = counter;
		strcpy(code[ncodelines].opcode,optable[i].translation);
		
		if(optable[i].charset > 0)
			fop = true;
		else{
			code[ncodelines].symbol[0] = '\0';
			ncodelines++;
		}
		return optable[i].charset;
	}
	printf("[Err] OPCODE '%s' in row. %04x not valid. Check list.lst file\n", token, counter);
	fprintf(list, "\n\n[Err] OPCODE '%s' in row. %04x not valid\n", token, counter);
	exit(1);
}

void isoperand(int bits){
	if(!fop) return;
	token = strtok(NULL,"\n\t\r ");
	if(token == NULL){
		printf("[Err] Operand of OPCODE '%s' in row. %04x is missing. Check list.lst file\n", opcode, counter);
		fprintf(list, "\n\n[Err] Operand of OPCODE '%s' in row. %04x is missing\n", opcode, counter);
		exit(1);
	}
	strcpy(operand,token);
	if((token[0] >= 'A' && token[0] <= 'z') || ((token[0] >= '0' && token[0] <= '9'))){
		if(token[0] >= 'A' && token[0] <= 'z')
			if(!search_register(token))
				if(!search_symbol(token))
					insert_jmp(token, bits);
	}else{
		printf("[Err] Operand '%s' of OPCODE '%s' in row. %04x not valid. Check list.lst file\n", token, opcode, counter);
		fprintf(list, "\n\n[Err] Operand '%s' of OPCODE '%s' in row. %04x not valid\n", token, opcode, counter);
		exit(1);
	}
	print_dec2bin(token, bits);	
}

void iscomment(){
	token = strtok(NULL,"\n\t\r ");
	if(token != NULL){
		if(!fop)
			fprintf(list, "\t"); 
		if(token[0] == '/' && token[1] == '/'){
			fprintf(list, "\t"); 
			do {
				fprintf(list, "%s ", token);
				token = strtok(NULL,"\n\t\r ");
			}while(token != NULL);
		}else if(fop){
			printf("[Warn] Comment in row. %d not valid\n", counter);
			fprintf(list, "\t[Warn] Comment in this row not valid");
		} else {
			printf("[Warn] Operand '%s' for OPCODE '%s' in row. %d not admitted\n", token, opcode, counter);
			fprintf(list, "\t[Warn] Operand '%s' for OPCODE '%s' not admitted", token, opcode);
		}
	}
	fprintf(list, "\n");
	
	fop = false;
	fsym = false;
	operand[0] = '\0';
}

void insert_label(){
	if(nsym >= MAX_SYM_RECORDS){
		printf("[Err] Symbol table is full. Check list.lst file\n");
		fprintf(list, "\n\n[Err] Symbol table is full\n");
		exit(1);
	}
	char str[255];
	strcpy(str,token);
	if(search_symbol(str)){
		printf("[Err] Symbol %s already in symbols table. Check list.lst file\n", token);
		fprintf(list, "\n\n[Err] Symbol %s already in symbols table\n", token);
		exit(1);
	}
	fnotfound = 0;
	strcpy(symtable[nsym].label, token);
	symtable[nsym++].location = counter;
	fsym = true;
}

void insert_reg(const char *reg, int addr){
	if(nreg >= MAX_REG_RECORDS){
		printf("[Err] Registers table is full. Check list.lst file\n");
		fprintf(list, "\n\n[Err] Registers table is full\n");
		exit(1);
	}
	strcpy(regtable[nreg].label, reg);
	regtable[nreg++].location = addr;
}

void regtable_init(){
	insert_reg("A",0);
	insert_reg("L",1);
	insert_reg("Z",7);
}

bool search_register(char* addr){
	for(int i = 0; i < nreg; i++){
		if(!strcmp(addr,regtable[i].label)){
			sprintf(addr, "%d", regtable[i].location);
			return true;
		}
	}
	return false;
}

bool search_data(char* addr){
	for(int i = 0; i < ndatalines; i++){
		if(!strcmp(addr,data[i].label)){
			sprintf(addr, "%d", data[i].lc);
			return true;
		}
	}
	return false;
}
	
bool search_symbol(char* addr){
	for(int i = 0; i < nsym; i++){
		if(!strcmp(addr,symtable[i].label)){
			sprintf(addr, "%d", symtable[i].location);
			return true;
		}
	}
	fnotfound = 1;
	return false;
}

void insert_jmp(const char *label, int charset){
	if(njmp >= MAX_JUMP_RECORS){
		printf("[Err] Jump table is full. Check list.lst file\n");
		fprintf(list, "\n\n[Err] Jump table is full\n");
		exit(1);
	}
	strcpy(jmptable[njmp].label, label);
	strcpy(jmptable[njmp].address, label);
	jmptable[njmp].charset = charset;
	jmptable[njmp++].id = ncodelines;
}

void print_symtable(){
	fprintf(list, "\n\nSYMBOLS TABLE (%d)\n",nsym);
	fprintf(list, "\t\tID\t LC\t\t   LABEL\n");
	for(int i = 0; i < nsym; i++)
		fprintf(list, "\t%3d.|\t%04d\t%20s\n",i,symtable[i].location,symtable[i].label);
}

void print_regtable(){
	fprintf(list, "\n\nREGISTERS TABLE (%d)\n",nreg);
	fprintf(list, "\t\tID\tREG\t ADDRESS\n");
	for(int i = 0; i < nreg; i++)
		fprintf(list, "\t%3d.|\t%s\t%2d\n",i,regtable[i].label,regtable[i].location);
}

void print_jmptable(){
	fprintf(list, "\n\nJUMPS TABLE (%d)\n",njmp);
	fprintf(list, "\t\tID\t LC\t\t   LABEL\t\tADDRESS\n");
	for(int i = 0; i < njmp; i++)
		fprintf(list, "\t%4d.|\t%04d\t%15s\t%4s\n",i,jmptable[i].id,jmptable[i].label,jmptable[i].address);
}

void print_object(){
	
	FILE* file = fopen("binaryCode.cc", "w");
	if(file == NULL){
		printf("[Err] Impossible to create binaryCode.cc\n");
		fprintf(list, "\n\n[Err] Impossible to create binaryCode.cc\n");
		exit(1);
	}
	
	fprintf(file, "// AGC assembler v1.0 - File binaryCode.cc\n\n");
	fprintf(file,"#include \"agc.h\"\nvoid agc::loadINT16(){\n");
	//printf("DATA\n");
	for(int i = 0; i < ndatalines; i++){
		if(data[i].lc < START_ROM_COUNT)
			fprintf(file,"\tRAM[%d] = %d;\n",data[i].lc,data[i].value);
		else
			fprintf(file,"\tROM[%d] = %d;\n",data[i].lc,data[i].value);
	}
	
	//printf("CODE\n");
	for(int i = 0; i < ncodelines; i++)
		fprintf(file,"\tROM[%d] = 0b%s%s;\n",code[i].lc,code[i].opcode,code[i].symbol);

	fprintf(file,"}\nvoid agc::loadINT20(){}\nvoid agc::loadMAIN(){}\nvoid agc::loadPrograms(){}\nvoid agc::loadBIOS(){}\n");
	
	fclose(file);
	fprintf(list, "\n\nbinaryCode.cc created\n\nAssembly completed");

}

void data_assembly(){
	if(token[strlen(token)-1] == ':'){
		if(ndatalines >= MAX_DATA_RECORS){
			fprintf(list, "\n\n[Err] Data table is full\n");
			exit(1);
		}
		token[strlen(token)-1]='\0';
		data[ndatalines].lc = counter++;
		strcpy(data[ndatalines].label,token);
		token = strtok(NULL,",\n\t\r ");
		if((token[0]=='0')&&(token[1]=='x')) 
			data[ndatalines++].value = strtol(token+2,NULL,16);  
		else if((token[0]=='0')&&(token[1]=='b'))
			data[ndatalines++].value = strtol(token+2,NULL,2);
		else	// dec
			data[ndatalines++].value = strtol(token,NULL,0);
	}
}

void print_data(){
	fprintf(list, "\n\nDATA TABLE (%d)\n",ndatalines);
	fprintf(list, "\t\tID\t LC\t\t   SYMBOL\t\tVALUE\n");
	for(int i = 0; i < ndatalines; i++)
		fprintf(list, "\t%4d.|\t%04d\t%15s\t%04x\n",i,data[i].lc,data[i].label,data[i].value);
}

void assembly(){
	fprintf(list, "\t%6s", opcode);
	if(operand[0] != '\0'){
		fprintf(list, "\t%15s", operand);
		return;
	}
	fprintf(list, "\t\t\t%c", ' ');
}

void print_dec2bin(char* op, int bits){
	int n = strtol(op,NULL,0);
	int a[bits], i;
	for(i = 0; i < bits; i++)
		a[i] = 0;
	for(i = 0; n > 0; i++){    
		a[i] = n%2;    
		n = n/2;  
	}	
	for(int j = i; j > 0; j--)   
		a[j] = a[j-1];
	a[0] = 0;
	for(i = bits-1; i >= 0; i--){   
		fprintf(list, "%d",a[i]);
		code[ncodelines].symbol[bits-1-i] = a[i] + 48;
	}
	code[ncodelines].symbol[bits] = '\0';
	ncodelines++;
}

void dec2bin(jmp_t* jmp){
	
	char *label = &(*jmp->address);
	int bits = jmp->charset;
	if(!search_data(label))
		if(!search_symbol(label)){
			printf("[Err] Label '%s' in row. %04x not replaced. Check list.lst file\n", label, jmp->id);
			fprintf(list, "\n\n[Err] Label '%s' in row. %04x not replaced\n", label, jmp->id);
			exit(1);
		}
	
	int n = strtol(label,NULL,0);
	int a[bits], i;
	for(i = 0; i < bits; i++)
		a[i] = 0;
	for(i = 0; n > 0; i++){    
		a[i] = n%2;    
		n = n/2;  
	}
	for(int j = i; j > 0; j--)   
		a[j] = a[j-1];
	a[0] = 0;
	for(i = bits-1; i >= 0; i--)
		code[ncodelines].symbol[bits-1-i] = a[i] + 48;
	code[ncodelines].symbol[bits] = '\0';

}

int main(int argc, char* argv[]){
	
	FILE *fp;
    char line[MAX_CODE_LINES];
	char ch;
	int bits;
		
	while((ch = getopt(argc, argv, "il")) != -1) {
		switch(ch) {
			case 'i':
				printf("AGC assembler v1.0 - Created by Antonio Di Tecco\n");
				break;
			case 'l':
				printf("Last update: 30/07/2019\n");
				break;
			default:
				break;
		}
	}
	
	if((list = fopen("list.lst", "w")) == NULL){
		printf("[Err] Impossible to create list.lst");
		exit(1);
	}
	
	fprintf(list, "AGC assembler v1.0 - File list.lst\n\n");

    if ((fp = fopen("code.as","r")) == NULL){
		printf("[Err] Impossible to access to code.as");
		fprintf(list, "[Err] Impossible to access to code.as");
		exit(1);
	}
		
	while(fgets(line, sizeof(line), fp) != NULL){  //skip till .code section
		token = strtok(line,"\n\t\r ");
		if(token == NULL)
			continue;
		if(!strcmp(token,".code")){
			fcode = 1;
			break;
		}
	}
	if(!fcode){
		printf("\n[Err] .code not found\n");
		fprintf(list, "\n[Err] .code not found\n");
		exit(1);
	}
		
//========================================   FIRST PASS  ======================================================
	regtable_init();
	optable_init();
	fprintf(list, "\t  LC\t\t LABEL\t\t  MACHINE CODE\t\t\t\t  ASSEMBLY\n");
	
	while(fgets(line, sizeof(line), fp) != NULL){
		token = strtok(line,"\n\t\r ");  //get the instruction mnemonic or label
		if(token != NULL){
			if(token[0] == '/' && token[1] == '/')
				continue;
			fprintf(list, "\t%5d", counter);
			islabel();
			bits = isopcode();
			isoperand(bits);
			assembly();
			iscomment();
			counter++;
		}
	}	
//================================= SECOND PASS ==============================
	rewind(fp);
	while(fgets(line, sizeof(line), fp)!= NULL){  //skip till .data, if no .data, also ok.
		token = strtok(line,"\n\t\r ");
		if(token == NULL)
			continue;
		if(!strcmp(token,".code"))
			break;
		if((!strcmp(token,".data") || fdata)){
			if(!fdata)
				fdata = true;
			if(!strcmp(token,".constant") || fconst){	// is it costant?
				if(!fconst) 
					fconst = true;
				if(!strcmp(token,".variable"))
					fconst = false;
			}
			if(!strcmp(token,".variable") || fvar){		// is it variable?
				if(!fvar){
					fvar = true;
					counter = datacounter;
				}	
			}
			data_assembly();
			continue;
		}
	}
		
	// Fix jump and label addresses
	int oldlines = ncodelines;
	for(int i = 0; i < njmp; i++){
		ncodelines = jmptable[i].id;
		dec2bin(&jmptable[i]);
	}
	ncodelines = oldlines;
	
	print_symtable();
	print_jmptable();
	print_regtable();
	print_data();
	print_object();
	
	fclose(list);
	fclose(fp);
	printf("Assembly completed. Check list.lst file\n");
	
	return 0;
	
}
