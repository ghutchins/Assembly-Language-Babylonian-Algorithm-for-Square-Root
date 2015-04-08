/* 
	CSC211 Lab 4
	NOIS II Approximate Square Root (Babylonian Algorithm) Program
	Georgina Hutchins 
	03/23/15 
*/


/*  add macros to support the use of custom R instructions  */

.macro fadds rgC,rgB,rgA
		custom 253,\rgC,\rgB,\rgA			#fadds
.endm

.macro fsubs rgC,rgB,rgA
		custom 254,\rgC,\rgB,\rgA			#fsubs
.endm

.macro fmuls rgC,rgB,rgA
		custom 252,\rgC,\rgB,\rgA			#fmuls
.endm

.macro fdivs rgC,rgB,rgA
		custom 255,\rgC,\rgB,\rgA			#fdivs
.endm


.global babylonian
.text

babylonian:


	movia r6,FTW		/* get FP 2.0 for calculations */
	ldw r6,0(r6)		/* grab value and place in r6 */

	fdivs r2,r4,r6		/*  newX = X/2.0  */
	
loop:
	
	mov r5,r2		/* oldX = newX (need for comparison) */	

	fdivs r2,r4,r5		/*  X/oldX  */
	
	fadds r2,r5,r2		/*  oldX + X/oldX  */
	fdivs r2,r2,r6		/*  (oldX + X/oldX) / (2.0)  */

	
	/* need absolute value of (oldX-newX) / (oldX) */

	fsubs r3,r5,r2		/*  oldX - newX  */
	fdivs r3,r3,r5		/*  (oldX-newX)/oldX  */

	mov r7,r3		/* place value in r7 for comparison */


	/* check relative error between two successive iterates */

	srli r7,r7,23		/* isolate exponent bits */
					/* logical rightshift by 23 */

	andi r7,r7,0xFF		/* get rid of signed bit */
					/* using logical and */

	cmplti r7,r7,0x69	/* compare exponent to -22 */
					/* using biased notation (7F-16=69) */
					/* if r7 < 69, store 1 in r7 */ 

	bne r7,r0,done		/* r7 != 0 (r7 = 1), done-- branch out of algorithm loop */
	beq r7,r0,loop		/* r7 = 0, loop back */




/* branch when relative error is small enough */ 
done:	
	ret


.data
/* floating point value (2.0) needed for calcuations */
FTW:
	 .float 2.0

.end