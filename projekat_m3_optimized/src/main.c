#include <stdio.h>
#include <dsplib\wavefile.h>
#include <stdfix.h>
#include <string.h>
#include "common.h"
#include <dsplib\timers.h>	// for profiling

// IO Buffers
__memY DSPfract sampleBuffer[MAX_NUM_CHANNEL][BLOCK_SIZE];

DSPfract limiterThreshold = 0.999;

// Enable
static DSPint enabled = 1;

// Gains
DSPfract variablesGain[INPUT_NUM_CHANNELS] = { MINUS_4DB, MINUS_4DB };

// Output Mode
mode outputMode = OUTPUT_MODE_3_2_1;

DSPfract saturation(DSPfract in)
{
	DSPaccum inValue = in;
	// Simple limiter since we know that pre-Gain adds 6dB
	if (inValue > (DSPaccum) limiterThreshold)
	{
		return limiterThreshold;
	}
	else if (inValue < (DSPaccum) -limiterThreshold)
	{
		return -limiterThreshold;
	}
	return in;
}
#ifdef SIGNALPROC_ASM
extern void signalProcessing(__memY DSPfract pIn[][BLOCK_SIZE], __memY DSPfract pOut[][BLOCK_SIZE]);
#else
void signalProcessing(__memY DSPfract pIn[][BLOCK_SIZE], __memY DSPfract pOut[][BLOCK_SIZE])
{
	DSPint j;

	DSPfract* variablesGainPtrL = variablesGain + L_CH;
	DSPfract* variablesGainPtrR = variablesGain + R_CH;

	__memY DSPfract* samplePtrInL = *(pIn + L_CH);
	__memY DSPfract* samplePtrInR = *(pIn + R_CH);

	__memY DSPfract* samplePtrOutL = *(pOut + L_CH);
	__memY DSPfract* samplePtrOutR = *(pOut + R_CH);
	__memY DSPfract* samplePtrOutLs = *(pOut + LS_CH);
	__memY DSPfract* samplePtrOutRs = *(pOut + RS_CH);
	__memY DSPfract* samplePtrOutC = *(pOut + C_CH);
	__memY DSPfract* samplePtrOutLfe = *(pOut + LFE_CH);

	for (j = 0; j < BLOCK_SIZE; j++)
	{
		// first stage, apply variable gain	(L and R channel processing)
		*samplePtrOutL = *samplePtrInL * *variablesGainPtrL;
		*samplePtrOutR = *samplePtrInR * *variablesGainPtrR;
		if (outputMode > 0)	// outputMode == OUTPUT_MODE_2_2_0 || outputMode == OUTPUT_MODE_3_2_1
		{
			// second stage, full wave rectifier distortion (LS and RS channel processing)
			if (*samplePtrOutL < FRACT_NUM(0.0))
				*samplePtrOutLs = -*samplePtrOutL;
			else
				*samplePtrOutLs = *samplePtrOutL;

			if (*samplePtrOutR < FRACT_NUM(0.0))
				*samplePtrOutRs = -*samplePtrOutR;
			else
				*samplePtrOutRs = *samplePtrOutR;
		}
		if (outputMode > 1)	// outputMode == OUTPUT_MODE_3_2_1
		{
			// third stage, L+R=C (C channel processing)
			*samplePtrOutC = saturation(*samplePtrOutL + *samplePtrOutR);
			// fourth stage, LS+RS=LFE (LFE channel processing)
			*samplePtrOutLfe = saturation(*samplePtrOutLs + *samplePtrOutRs);
		}

		samplePtrInL++;
		samplePtrInR++;
		samplePtrOutL++;
		samplePtrOutR++;
		samplePtrOutLs++;
		samplePtrOutRs++;
		samplePtrOutC++;
		samplePtrOutLfe++;
	}
}
#endif


int main(int argc, char *argv[])
 {
    WAVREAD_HANDLE *wav_in;
    WAVWRITE_HANDLE *wav_out;

	char WavInputName[256];
	char WavOutputName[256];

    DSPint inChannels;
    DSPint outChannels;
    DSPint bitsPerSample;
    DSPint sampleRate;
    DSPint iNumSamples;
    DSPint i;
    DSPint j;

    unsigned long long count1, count2, spent_cycles;	// for profiling

    // Get Control values from arguments
	//-------------------------------------------------
	// Get Output Mode
	if (argc > 4) {
		if (strcmp(argv[6], "2_0_0") == 0)
			outputMode = OUTPUT_MODE_2_0_0;
		else if (strcmp(argv[6], "2_2_0") == 0)
			outputMode = OUTPUT_MODE_2_2_0;
		else if (strcmp(argv[6], "3_2_1") == 0)
			outputMode = OUTPUT_MODE_3_2_1;
		else
		{
			printf("Wrong mode!\n");
			return -1;
		}
	}

	// Get Enable control
	if (argc > 3) {
		if (strcmp(argv[3], "0") == 0)
			enabled = 0;
		else if (strcmp(argv[3], "1") != 0) {
			printf("Wrong Enable control!\n");
			return -1;
		}
	}

	//-------------------------------------------------

	// Init channel buffers
	for(i=0; i<MAX_NUM_CHANNEL; i++)
		for(j=0; j<BLOCK_SIZE; j++)
			sampleBuffer[i][j] = FRACT_NUM(0.0);

	// Open input wav file
	//-------------------------------------------------
	strcpy(WavInputName,argv[0]);
	wav_in = cl_wavread_open(WavInputName);
	if(wav_in == NULL)
    {
        printf("Error: Could not open wavefile.\n");
        return -1;
    }
	//-------------------------------------------------

	// Read input wav header
	//-------------------------------------------------
	inChannels = cl_wavread_getnchannels(wav_in);
    bitsPerSample = cl_wavread_bits_per_sample(wav_in);
    sampleRate = cl_wavread_frame_rate(wav_in);
    iNumSamples =  cl_wavread_number_of_frames(wav_in);
	//-------------------------------------------------

	// Open output wav file
	//-------------------------------------------------
	strcpy(WavOutputName,argv[1]);
	//outChannels = inChannels;
	outChannels = (outputMode + 1) * 2;	// change number of channels
	wav_out = cl_wavwrite_open(WavOutputName, bitsPerSample, outChannels, sampleRate);
	if(!wav_out)
    {
        printf("Error: Could not open wavefile.\n");
        return -1;
    }
	//-------------------------------------------------

	// Processing loop
	//-------------------------------------------------
    {
		int i;
		int j;
		int k;
		int sample;

		// exact file length should be handled correctly...
		for(i=0; i<iNumSamples/BLOCK_SIZE; i++)
		{
			for(j=0; j<BLOCK_SIZE; j++)
			{
				for(k=0; k<inChannels; k++)
				{
					sample = cl_wavread_recvsample(wav_in);
        			sampleBuffer[k][j] = rbits(sample);
				}
			}

			// pozvati processing funkciju ovde
			count1 = cl_get_cycle_count();

			if(enabled)
				signalProcessing(sampleBuffer, sampleBuffer);

			count2 = cl_get_cycle_count();
			spent_cycles = count2 - count1;
			printf("%llu\n", spent_cycles);
			// -----------------------------------

			for(j=0; j<BLOCK_SIZE; j++)
			{
				for(k=0; k<outChannels; k++)
				{
					sample = bitsr(sampleBuffer[k][j]);
					cl_wavwrite_sendsample(wav_out, sample);
				}
			}
		}
	}

	// Close files
	//-------------------------------------------------
    cl_wavread_close(wav_in);
    cl_wavwrite_close(wav_out);
	//-------------------------------------------------

    return 0;
 }
