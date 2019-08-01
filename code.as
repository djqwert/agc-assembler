.data
	
	.constant
	
	//costanti DSPTAB
	costantiDSPTAB: 0b1011000000000000;	// B000
	dsp1: 0b1010000000000000;			// A000
	dsp2: 0b1001000000000000;			// 9000
	dsp3: 0b1000000000000000;			// 8000
	dsp4: 0b0111000000000000;			// 7000
	dsp5: 0b0110000000000000;			// 6000
	dsp6: 0b0101000000000000;			// 5000
	dsp7: 0b0100000000000000;			// 4000
	dsp8: 0b0011000000000000;			// 3000
	dsp9: 0b0010000000000000;			// 2000
	dsp10: 0b0001000000000000;			// 1000
	
	timer: 0b1111111111101000; 			// costante (valore timer)
	cost32: 0b0000000001000000; 		// costante (64 << 1): 32
	cost11: 0b0000000000010110; 		// costante (22 << 1): 11
	par_attesa: 0b0000101110011110; 	// parametro di attesa: 1487 (125 ms.)
	cost_-0: 0b1000000000000000; 		// constant -0
	cost_0: 0b0000000000000000; 		// constant 0
	
	// Tebella valori DSKY
	dskyblank: 	0
	dsky0: 		42	// 21 << 1
	dsky1: 		6	//  3 << 1
	dsky2: 		50	// 25 << 1
	dsky3:		54	// 27 << 1
	dsky4:		30	// 15 << 1
	dsky5:		60	// 30 << 1
	dsky6:		56	// 28 << 1
	dsky7:		38	// 19 << 1
	dsky8: 		58 	// 29 << 1
	dsky9:		62	// 31 << 1
	dsky35:	0b1011011011111100; // combinazione DSKY programma 35
	
	// Tabella valori
	key_0: 32
	key_1: 2
	key_2: 4
	key_3: 6
	key_4: 8
	key_5: 10
	key_6: 12
	key_7: 14
	key_8: 16
	key_9: 18
	key_verb: 34
	key_rset: 36
	key_rel: 50
	key_add: 52
	key_sub: 54
	key_entr: 56
	key_clr: 60
	key_noun: 62
	key_press = 202
	key_release = 204
	
	maskA: 0b1111111111100000;		// Costante usata per fare AND con registro A
	cost1cmp2: 0b1111111111111100;	// Costante -1 in cmp1
	on_rset: 0b0000100000000000;	// Costante usata per accendere la lampadina di reboot

	// PARAM: Tabella lampadine
	tablamp1: 0b0000000000001000
	tablamp2: 0b1100000000010000
	tablamp3: 0b1100010000010000
	tablamp4: 0b0000000000101000
	tablamp5: 0b0000000010101000
	tablamp6: 0b0000000010111000
	tablamp7: 0b1100010011010000
	tablamp8: 0b1100011011010000
	tablamp9: 0b1100111011010000
	tablamp10: 0b1100111111010000
	tablamp11: 0b1100111111110000
	tablamp12: 0b1100111111111000
	
	tabprog: 0b0000000110111100 	// PROG DSP			9
	digit0_1: 0b1011011101111010	// digits 0,1		8
	tabvn: 0b0000000111111000		// VERB / NOUN		9
	digit2_3: 0b1010011101111010	// digits 2,3		8
	digit4_5: 0b1001011101111010	// digits 4,5		8
	digit7: 0b1000000000111010		// digits -,7		8
	digit8_9: 0b0111111101111010	// digits 8,9		8
	digit10_11: 0b0110011101111010	// digits 10,11		8
	digit13_14: 0b0101111101111010	// digits 13,14		8
	digit15_16: 0b0100011101111010	// digits 15,16		8
	digit17_19: 0b0011111101101010	// digits 17,19		8
	digit17_19on: 0b0011111101111010 // digits 17,19	8
	digit20_21: 0b0010111101111010	// digits 20,21		8
	digit22_23: 0b0001011101111010	// digits 22,23		8
	
	//OFF
	tablamp1off: 0b0000000111110000
	tablamp2off: 0b1100111101101000
	tablamp3off: 0b1100101101101000
	tablamp4off: 0b0000000111010000
	tablamp5off: 0b0000000101010000
	tablamp6off: 0b0000000101000000
	tablamp7off: 0b1100101100101000
	tablamp8off: 0b1100100100101000
	tablamp9off: 0b1100000100101000
	tablamp10off: 0b1100000000101000
	tablamp11off: 0b1100000000001000
	tablamp12off: 0b1100000000000000
	
	tabprogoff: 0b0000000001000000; 	// PROG DSP			9
	digit0_1off: 0b1011010101101010;	// digits 0,1		8
	tabvnoff: ROM: 0b0000000000000000;	// VERB / NOUN		9
	digit2_3off: 0b1010010101101010;	// digits 2,3		8
	digit4_5off: 0b1001010101101010;	// digits 4,5		8
	digit7off: 0b1000000000101010;		// digits -,7		8
	digit8_9off: 0b0111010101101010;	// digits 8,9		8
	digit10_11off: 0b0110010101101010;	// digits 10,11		8
	digit13_14off: 0b0101010101101010;	// digits 13,14		8
	digit15_16off: 0b0100010101101010;	// digits 15,16		8
	digit17_19off: 0b0011010101111010;	// digits 17,19		8
	digit17_19off2: 0b0011010101101010;	// digits 17,19		8
	digit20_21off: 0b0010010101101010;	// digits 20,21		8
	digit22_23off: 0b0001010101101010;	// digits 22,23	
	
	.variable
	buffer: 0
	
	counter_dsptab: 0		// contatore delle celle usate
	cellatab1: 0
	cellatab2: 0
	cellatab3: 0
	cellatab4: 0
	cellatab5: 0
	cellatab6: 0
	cellatab7: 0
	cellatab8: 0
	cellatab9: 0
	cellatab10: 0
	cellatab11: 0
	
	// arrayCifra1
	arrayCifra1_1: 0b1000000000000000; 	// -0 (blank)
	arrayCifra1_2: 0b1000000000000000; 	// -0 (blank)
	arrayCifra1_3: 0b1000000000000000; 	// -0 (blank)
	arrayCifra1_4: 32;					// 16 << 1
	arrayCifra1_5: 32;
	arrayCifra1_6: 32;
	arrayCifra1_7: 32;
	arrayCifra1_8: 32;
	arrayCifra1_9: 32;
	arrayCifra1_10: 32;
	arrayCifra1_11: 32;
	
	// arrayCifra2
	arrayCifra2_1: 0b1000000000000000; 	// -0 (blank)
	arrayCifra2_2: 0b1000000000000000; 	// -0 (blank)
	arrayCifra2_3: 0b1000000000000000;	// -0 (blank)
	arrayCifra2_4: 32;
	arrayCifra2_5: 32;
	arrayCifra2_6: 32;
	arrayCifra2_7: 32;
	arrayCifra2_8: 32;
	arrayCifra2_9: 32;
	arrayCifra2_10: 32;
	arrayCifra2_11: 32;
	
	//lamps1 and lamps2
	lamps1: 0b1100000000000000;			// C000
	lamps2: 0b0000000101000000;			// 0140
	
.code

		// BIOS
		// SOTTOPROGRAMMA 1: Test RAM, registro A
		INCR A			// BIOS
		EXT
		SU A
		EXT
		BZF salta_alt1
		EXT
		ALT

		// SOTTOPROGRAMMA 2: Test RAM, registro L
		salta_alt1: INCR A
		INCR L
		EXT
		SU L
		EXT
		BZF main
		EXT
		ALT
		// FINE BIOS

		// INT16
		CA 600		// Cifra 1 VERB 	INT16: T4RUPT
		TS arrayCifra1_2
		CA 601		// Cifra 2 VERB 
		TS arrayCifra2_2
		CA 602		// Cifra 1 NOUN 
		TS arrayCifra1_3
		CA 603		// Cifra 2 NOUN
		TS arrayCifra2_3

		CA timer
		TS 27		// Timer counter
		CA Z
		TS counter_dsptab
		
ciclo:	INDEX counter_dsptab
		CA arrayCifra1_1
		TC toDSKYformat
		EXT
		MP cost32
		CA L				// A = L
		INDEX counter_dsptab
		TS cellatab1			// Memorizzo A
		INDEX counter_dsptab
		CA arrayCifra2_1
		TC toDSKYformat
		INDEX counter_dsptab
		ADS cellatab1			// Sommo cellatab1 = cellatab1 + A
		INDEX counter_dsptab
		CA costantiDSPTAB
		INDEX counter_dsptab
		ADS cellatab1			// Sommo il valore nella cellatab1 = DSP + cellatab1
		INDEX counter_dsptab
		TS cellatab1
		NOOP
		EXT
		WRITE 8
		
		INCR counter_dsptab		// Sottraggo A - const11, per vedere se è uguale a 0
		CA counter_dsptab
		TS L
		CA cost11
		EXT
		SU L
		EXT
		BZF salta
		TCF ciclo
		
salta:	CA lamps1
		EXT
		WRITE 8
		CA lamps2
		EXT
		WRITE 9
		RESUME
		
toDSKYformat: XCH buffer 	// scambio i contenuti di A e buffer
		CA buffer		  	// scrivo il contenuto di buffer in A
		
		LXCH Z
		EXT
		SU L
		EXT
		BZF progk1
		CA buffer
		INCR L
		EXT
		SU L
		EXT
		BZF progk2
		CA buffer
		INCR L
		EXT
		SU L
		EXT
		BZF progk3
		CA buffer
		INCR L
		EXT
		SU L
		EXT
		BZF progk4
		CA buffer
		INCR L
		EXT
		SU L
		EXT
		BZF progk5
		CA buffer
		INCR L
		EXT
		SU L
		EXT
		BZF progk6
		CA buffer
		INCR L
		EXT
		SU L
		EXT
		BZF progk7
		CA buffer
		INCR L
		EXT
		SU L
		EXT
		BZF progk8
		CA buffer
		INCR L
		EXT
		SU L
		EXT
		BZF progk9
		CA buffer
		INCR L
		EXT
		SU L
		EXT
		BZF progk10
		CA key_0
		LXCH A
		CA buffer
		EXT
		SU L
		EXT
		BZF progk1
		TCF progk11	// altrimenti la cifra è blank
		
		// SOTTOPROGRAMMA 1 - KEY 0
progk1:	CA dsky0
		RETURN
		
		// SOTTOPROGRAMMA 2 - KEY 1
progk2:	CA dsky1
		RETURN	
		
		// SOTTOPROGRAMMA 3 - KEY 2
progk3:	CA dsky2
		RETURN

		// SOTTOPROGRAMMA 4 - KEY 3
progk4:	CA dsky3
		RETURN

		// SOTTOPROGRAMMA 5 - KEY 4
progk5:	CA dsky4
		RETURN

		// SOTTOPROGRAMMA 6 - KEY 5
progk6:	CA dsky5
		RETURN

		// SOTTOPROGRAMMA 7 - KEY 6
progk7:	CA dsky6
		RETURN

		// SOTTOPROGRAMMA 8 - KEY 7
progk8:	CA dsky7
		RETURN

		// SOTTOPROGRAMMA 9 - KEY 8
progk9:	CA dsky8
		RETURN

		// SOTTOPROGRAMMA 10 - KEY 9
progk10: CA dsky9
		RETURN

		// SOTTOPROGRAMMA 11 - KEY BLANK
progk11: CA dskyblank
		RETURN

// INT20
		
	EXT	// INT20: KEYRUPT1
	READ 12		// IO[12]
	XCH L
	XCH Z
	AD key_rset
	EXT
	SU L
	EXT
	BZF reset_proc
	TCF continua
	
reset_proc: AD key_rset
	XCH 17
	CA on_rset			// accendo lampadina
	ADS lamps1
	TC wait 			// attendo
	TCF stop_blink

continua: EXT
	READ 12
	XCH L
	XCH Z
	AD key_clr
	EXT
	SU L
	EXT
	BZF prog1

	CA 605				// RAM[605] con le informazioni di stato delle cifre
	XCH L
	XCH Z
	AD Z
	EXT
	SU L
	EXT
	BZF prog2

	CA 605
	XCH L
	XCH Z
	AD key_1
	EXT
	SU L
	EXT
	BZF prog3

	CA 605
	XCH L
	XCH Z
	AD key_2
	EXT
	SU L
	EXT
	BZF prog4

	CA 605
	XCH L
	XCH Z
	AD key_3
	EXT
	SU L
	EXT
	BZF prog5

	CA 605
	XCH L
	XCH Z
	AD key_4
	EXT
	SU L
	EXT
	BZF prog6

	CA 605
	XCH L
	XCH Z
	AD key_5
	EXT
	SU L
	EXT
	BZF prog7

	CA 605
	XCH L
	XCH Z
	AD key_6
	EXT
	SU L
	EXT
	BZF prog8
	RESUME

// SOTTOPROGRAMMA 1 - CLEAR
prog1:	CA key_0
	TS 600
	TS 601
	TS 602
	TS 603
	CA Z
	XCH 604		// Cella di busy
	CA Z
	XCH 605
	TC stop_blink
	
// SOTTOPROGRAMMA 2
prog2:	EXT
	READ 12
	XCH L
	XCH Z
	AD key_verb
	EXT
	SU L
	EXT
	BZF salta_resume
	RESUME
salta_resume:	INCR 605
	TC verb_on
	
// SOTTOPROGRAMMA 3
prog3:	EXT
	READ 12
	AD cost1cmp2
	MASK maskA
	EXT
	BZF salta_resume1
	RESUME
salta_resume1:	EXT
	READ 12
	XCH 600
	INCR 605
	RESUME
	
// SOTTOPROGRAMMA 4
prog4:	EXT
	READ 12
	AD cost1cmp2
	MASK maskA
	EXT
	BZF salta_resume3
	RESUME
salta_resume3:	EXT
	READ 12
	XCH 601
	INCR 605
	RESUME
	
// SOTTOPROGRAMMA 5
prog5: EXT
	READ 12
	XCH L
	XCH Z
	AD key_entr
	EXT
	SU L
	EXT
	BZF prog5_1
	EXT
	READ 12
	XCH L
	XCH Z
	AD key_noun
	EXT
	SU L
	EXT
	BZF prog5_2
	RESUME
	
// SOTTOPROGRAMMA 6
prog6: EXT
	READ 12
	AD cost1cmp2
	MASK maskA
	EXT
	BZF salta_resume4
	RESUME
salta_resume4: EXT
	READ 12
	XCH 602
	INCR 605
	RESUME
	
// SOTTOPROGRAMMA 7
prog7: EXT
	READ 12
	AD cost1cmp2
	MASK maskA
	EXT
	BZF salta_resume5
	RESUME
salta_resume5: EXT
	READ 12
	XCH 603
	INCR 605
	RESUME

// SOTTOPROGRAMMA 8
prog8:	EXT
	READ 12
	XCH L
	XCH Z
	AD key_entr
	EXT
	SU L
	EXT
	BZF salta_resume6
	RESUME
salta_resume6: CA key_1
	XCH 604
	CA Z
	XCH 605
	TC stop_blink
	
// SOTTOPROGRAMMA 5.1
prog5_1: CA key_1
	XCH 604
	CA Z
	XCH 605
	TC stop_blink
	
// SOTTOPROGRAMMA 5.2
prog5_2: INCR 605
	TC noun_on
	
// SOTTOPROGRAMMA .1 - Lampeggia VERB
verb_on: XCH Z
	AD key_1
	EXT
	WRITE 40
	RESUME
	
// SOTTOPROGRAMMA .2 - Lampeggia NOUN
noun_on: XCH Z
	AD key_2
	EXT
	WRITE 40
	RESUME

// SOTTOPROGRAMMA .3 - Stop blinking
stop_blink: XCH Z
	EXT
	WRITE 40
	RESUME

// MAIN
main: CA 604		// MAIN
	EXT
	BZF main		// in attesa dell'interruzione
	CA Z			//azzerare busy
	XCH 604
	
	//controllo num. programma
	CA key_3
	XCH L
	CA 600
	EXT
	SU L
	EXT
	BZF contr2	//salta a controllo successivo
	NOOP 		//esegui prog errore
	TCF main
	
	//controlla seconda cifra
contr2:	CA key_5
	XCH L
	CA 601
	EXT
	SU L
	EXT
	BZF contr3	//salta a controllo successivo
	NOOP		//esegui prog errore
	TCF main
	
	//controlla terza cifra
contr3:	CA key_1
	XCH L
	CA 602
	EXT
	SU L
	EXT
	BZF contr4 //salta a controllo successivo
	NOOP //esegui prog errore
	TCF main
	
	//controlla quarta cifra
contr4:	CA key_1
	XCH L
	CA 603
	EXT
	SU L
	EXT
	BZF prog35  // salta a "setta il numero di programma")
	NOOP 		//esegui prog errore
	TCF main
	
	//setta il numero di programma
prog35: CA dsky35
	EXT
	WRITE 8
	BZF jmp_prg //salta a programma
	
// SOTTOPROGRAMMA 3: Test IO, accensione lampadine
jmp_prg:	INHINT
	
	CA tablamp1
	EXT
	WRITE 9
	TC wait
	
	CA tablamp2
	EXT
	WRITE 8
	TC wait
	
	CA tablamp3
	EXT
	WRITE 8
	TC wait
	
	CA tablamp4
	EXT
	WRITE 9
	TC wait
	
	CA tablamp5
	EXT
	WRITE 9
	TC wait
	
	CA tablamp6
	EXT
	WRITE 9
	TC wait
	
	CA tablamp7
	EXT
	WRITE 8
	TC wait
	
	CA tablamp8
	EXT
	WRITE 8
	TC wait
	
	CA tablamp9
	EXT
	WRITE 8
	TC wait
	
	CA tablamp10
	EXT
	WRITE 8
	TC wait
	
	CA tablamp11
	EXT
	WRITE 8
	TC wait
	
	CA tablamp12
	EXT
	WRITE 8
	TC wait
	
	//Display
	CA tabprog
	EXT
	WRITE 9
	TC wait
	
	CA digit0_1
	EXT
	WRITE 8
	TC wait
	
	CA tabvn
	EXT
	WRITE 9
	TC wait
	
	CA digit2_3
	EXT
	WRITE 8
	TC wait
	
	CA digit4_5
	EXT
	WRITE 8
	TC wait
	
	CA digit7
	EXT
	WRITE 8
	
	CA digit8_9
	EXT
	WRITE 8
	
	CA digit10_11
	EXT
	WRITE 8
	TC wait
	
	CA digit13_14
	EXT
	WRITE 8
	
	CA digit15_16
	EXT
	WRITE 8
	
	CA digit17_19
	EXT
	WRITE 8
	TC wait

	CA digit15_16
	EXT
	WRITE 8
	
	CA digit17_19on
	EXT
	WRITE 8
	
	CA digit20_21
	EXT
	WRITE 8
	
	CA digit22_23
	EXT
	WRITE 8
	TC wait
	
	//Lamps off
	CA tablamp1off
	EXT
	WRITE 9
	TC wait
	
	CA tablamp2off
	EXT
	WRITE 8
	TC wait
	
	CA tablamp3off
	EXT
	WRITE 8
	TC wait
	
	CA tablamp4off
	EXT
	WRITE 9
	TC wait
	
	CA tablamp5off
	EXT
	WRITE 9
	TC wait
	
	CA tablamp6off
	EXT
	WRITE 9
	TC wait
	
	CA tablamp7off
	EXT
	WRITE 8
	TC wait
	
	CA tablamp8off
	EXT
	WRITE 8
	TC wait
	
	CA tablamp9off
	EXT
	WRITE 8
	TC wait
	
	CA tablamp10off
	EXT
	WRITE 8
	TC wait
	
	CA tablamp11off
	EXT
	WRITE 8
	TC wait
	
	CA tablamp12off
	EXT
	WRITE 8
	TC wait
	
	//Display off
	CA tabprogoff
	EXT
	WRITE 9
	TC wait
	
	CA digit0_1off
	EXT
	WRITE 8
	TC wait
	
	CA tabvnoff
	EXT
	WRITE 9
	TC wait
	
	CA digit2_3off
	EXT
	WRITE 8
	TC wait
	
	CA digit4_5off
	EXT
	WRITE 8
	TC wait
	
	CA digit7off
	EXT
	WRITE 8
	
	CA digit8_9off
	EXT
	WRITE 8
	
	CA digit10_11off
	EXT
	WRITE 8
	TC wait
	
	CA digit13_14off
	EXT
	WRITE 8
	
	CA digit15_16off
	EXT
	WRITE 8

	CA digit17_19off
	EXT
	WRITE 8
	
	CA digit17_19off2
	EXT
	WRITE 8
	
	CA digit20_21off
	EXT
	WRITE 8
	
	CA digit22_23off
	EXT
	WRITE 8
	TC wait

	// Torna al main
	RELINT
	CA cost_-0
	TS arrayCifra1_1
	TS arrayCifra2_1
	CA cost_0
	TS 600
	TS 601
	TS 602
	TS 603
	TCF main	
	
	//Attesa attiva
wait:	CA par_attesa
jmp_back:	EXT
	DIM A  // (dec A)
	EXT
	BZF jmp_ret
	TCF jmp_back
jmp_ret: RETURN	// (ret)