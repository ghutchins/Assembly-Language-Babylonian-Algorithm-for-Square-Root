
/*	CSC 211 Lab 4
	Approximate Square Root of X using Babylonian Algorithm
	Georgina Hutchins 
	03/23/15 
*/


.global _start

.extern babylonian

.text

_start:


/* display personal HEX logo */

	movia r8,mylogo
	ldw r8,0(r8)
	movia r9,0x10000020
	stwio r8,0(r9)
	

/* call square root function */


	movia r4,FTWO	/* pass in FP input X */
	ldw r4,0(r4)	/* grab value and place in r4 */
	

	call babylonian

	
stop:
		br stop


.data
/*	store test floating point number inputs as constants    */
FTWO:
	.float 29.7463

	/*
	.float 1.00
	.float 7.281
	*/

/* Personal logo ("GBH") in HEX */

mylogo:
	.word 0x7D7F7600


.end