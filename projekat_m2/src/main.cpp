
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "WAVheader.h"
#include "common.h"

// IO Buffers
static DSPfract sampleBuffer[MAX_NUM_CHANNEL][BLOCK_SIZE];

static DSPfract limiterThreshold = 0.999;

// Enable
static DSPint enabled = 1;

// Gains 
static DSPfract variablesGain[INPUT_NUM_CHANNELS] = { MINUS_4DB, MINUS_4DB };

// Output Mode
static mode outputMode = OUTPUT_MODE_3_2_1;

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

void signalProcessing(DSPfract pIn[][BLOCK_SIZE], DSPfract pOut[][BLOCK_SIZE])
{
	DSPint j;

	DSPfract* variablesGainPtrL = variablesGain + L_CH;
	DSPfract* variablesGainPtrR = variablesGain + R_CH;

	DSPfract* samplePtrInL = *(pIn + L_CH);
	DSPfract* samplePtrInR = *(pIn + R_CH);

	DSPfract* samplePtrOutL = *(pOut + L_CH);
	DSPfract* samplePtrOutR = *(pOut + R_CH);
	DSPfract* samplePtrOutLs = *(pOut + LS_CH);
	DSPfract* samplePtrOutRs = *(pOut + RS_CH);
	DSPfract* samplePtrOutC = *(pOut + C_CH);
	DSPfract* samplePtrOutLfe = *(pOut + LFE_CH);

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

/////////////////////////////////////////////////////////////////////////////////
// @Author	<student name>
// @Date		<date>  
//
// Function:
// main
//
// @param - argv[0] - Input file name
//        - argv[1] - Output file name
//			Optional arguments
//		  - argv[2] - Enable (0/1)
//		  - argv[3] - Left Input Gain (0 - -inf)
//		  - argv[4] - Right Input Gain (0 - -inf)
//		  - argv[5] - Output Mode (2_0_0/2_2_0/3_2_1)
// @return - nothing
// Comment: main routine of a program
//
// E-mail:	<email>
//
/////////////////////////////////////////////////////////////////////////////////
DSPint main(DSPint argc, char* argv[])
{
	FILE* wav_in = NULL;
	FILE* wav_out = NULL;
	char WavInputName[256];
	char WavOutputName[256];
	WAV_HEADER inputWAVhdr, outputWAVhdr;

	if (argc < 3 || argc > 7) 
	{
		printf("Wrong number of arguments!\n");
		printf("Usage: INPUT_FILE OUTPUT_FILE [Enable] [G1] [G2]  [MODE]\n");
		printf("Enable = [0|1]\nG1,G2 = (-inf, 0]\nMODE = [\"2_0_0\"|\"2_2_0\"|\"3_2_1\"]\n");
		return -1;
	}

	// Init channel buffers
	for (DSPint i = 0; i < MAX_NUM_CHANNEL; i++)
		for (DSPint j = 0; j < BLOCK_SIZE; j++)
			sampleBuffer[i][j] = FRACT_NUM(0.0);

	// Open input and output wav files
	//-------------------------------------------------
	strcpy(WavInputName, argv[1]);
	wav_in = OpenWavFileForRead(WavInputName, "rb");	
	strcpy(WavOutputName, argv[2]);
	wav_out = OpenWavFileForRead(WavOutputName, "wb");	
	//-------------------------------------------------

	// Get Control values from arguments
	//-------------------------------------------------
	// Get Output Mode
	if (argc > 6) {
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

	// Get Right Input Gain
	if (argc > 5)
	{
		double rGain = atof(argv[5]);
		if (rGain <= 0)
			variablesGain[R_CH] = FRACT_NUM(pow(10.0, ((rGain) / 20.0)));
		else
		{
			printf("Wrong Input Gain! (-int, 0]\n");
			return -1;
		}
	}

	// Get Left Input Gain
	if (argc > 4)
	{
		double lGain = atof(argv[4]);
		if (lGain <= 0)
			variablesGain[L_CH] = FRACT_NUM(pow(10.0, ((lGain) / 20.0)));
		else
		{
			printf("Wrong Input Gain! (-int, 0]\n");
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

	printf("Enabled: %d | OutputMode: %d\n", enabled, outputMode);
	//-------------------------------------------------

	// Read input wav header
	//-------------------------------------------------
	ReadWavHeader(wav_in, inputWAVhdr);
	//-------------------------------------------------

	// Set up output WAV header
	//-------------------------------------------------	
	outputWAVhdr = inputWAVhdr;
	if (enabled)
		outputWAVhdr.fmt.NumChannels = (outputMode + 1) * 2; // change number of channels
	else
		outputWAVhdr.fmt.NumChannels = 2;

	DSPint oneChannelSubChunk2Size = inputWAVhdr.data.SubChunk2Size / inputWAVhdr.fmt.NumChannels;
	DSPint oneChannelByteRate = inputWAVhdr.fmt.ByteRate / inputWAVhdr.fmt.NumChannels;
	DSPint oneChannelBlockAlign = inputWAVhdr.fmt.BlockAlign / inputWAVhdr.fmt.NumChannels;

	outputWAVhdr.data.SubChunk2Size = oneChannelSubChunk2Size * outputWAVhdr.fmt.NumChannels;
	outputWAVhdr.fmt.ByteRate = oneChannelByteRate * outputWAVhdr.fmt.NumChannels;
	outputWAVhdr.fmt.BlockAlign = oneChannelBlockAlign * outputWAVhdr.fmt.NumChannels;


	// Write output WAV header to file
	//-------------------------------------------------
	WriteWavHeader(wav_out, outputWAVhdr);

	// Processing loop
	//-------------------------------------------------	
	{
		DSPint sample;
		DSPint BytesPerSample = inputWAVhdr.fmt.BitsPerSample / 8;
		const double SAMPLE_SCALE = -(double)(1 << 31);		//2^31
		DSPint iNumSamples = inputWAVhdr.data.SubChunk2Size / (inputWAVhdr.fmt.NumChannels * inputWAVhdr.fmt.BitsPerSample / 8);

		// exact file length should be handled correctly...
		for (DSPint i = 0; i < iNumSamples / BLOCK_SIZE; i++)
		{
			for (DSPint j = 0; j < BLOCK_SIZE; j++)
			{
				for (DSPint k = 0; k < inputWAVhdr.fmt.NumChannels; k++)
				{
					sample = 0; //debug
					fread(&sample, BytesPerSample, 1, wav_in);
					sample = sample << (32 - inputWAVhdr.fmt.BitsPerSample); // force signextend
					sampleBuffer[k][j] = sample / SAMPLE_SCALE;				// scale sample to 1.0/-1.0 range		
				}
			}
			if(enabled)
				signalProcessing(sampleBuffer, sampleBuffer);

			for (DSPint j = 0; j < BLOCK_SIZE; j++)
			{
				for (DSPint k = 0; k < outputWAVhdr.fmt.NumChannels; k++)
				{
					sample = sampleBuffer[k][j].toLong();	// crude, non-rounding (changed when implemented m2) ??		
					sample = sample >> (32 - inputWAVhdr.fmt.BitsPerSample);
					fwrite(&sample, outputWAVhdr.fmt.BitsPerSample / 8, 1, wav_out);
				}
			}
			fflush(wav_out);	// (added when implemented m2) ??
		}
	}

	// Close files
	//-------------------------------------------------	
	fclose(wav_in);
	fclose(wav_out);
	//-------------------------------------------------	

	return 0;
}