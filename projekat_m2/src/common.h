#ifndef COMMON_H
#define COMMON_H

#include "stdfix_emu.h"

/* Basic constants */
/* TO DO: Move defined constants here */
/////////////////////////////////////////////////////////////////////////////////
// Constant definitions
/////////////////////////////////////////////////////////////////////////////////
#define BLOCK_SIZE 16
#define MAX_NUM_CHANNEL 8

// Number of input channels
#define INPUT_NUM_CHANNELS 2

// Output Mode
// 2_0_0 (L i R) | 2_2_0 (L, R, Ls i Rs) | [DEFAULT] 3_2_1 (L, R, C, Ls, Rs, LFE)
enum mode { OUTPUT_MODE_2_0_0, OUTPUT_MODE_2_2_0, OUTPUT_MODE_3_2_1 };

// Channel IDs.	 
// values of L_CH and R_CH must be 0 and 1 due to the relationship with the input channels
// other values are set relative to the output modes
#define L_CH 0	
#define R_CH 1	
#define LS_CH 2
#define RS_CH 3
#define C_CH 4
#define LFE_CH 5

// Gain linear values. 
#define MINUS_4DB FRACT_NUM(0.630957) 
/////////////////////////////////////////////////////////////////////////////////

/* DSP type definitions */
typedef short DSPshort;				/* DSP integer */
typedef unsigned short DSPushort;	/* DSP unsigned integer */
typedef int DSPint;					/* native integer */
typedef fract DSPfract;				/* DSP fixed-point fractional, data reg, memory word format s.31 */
typedef long_accum DSPaccum;		/* DSP fixed-point fractional, accum reg format s8.63 */

#endif
