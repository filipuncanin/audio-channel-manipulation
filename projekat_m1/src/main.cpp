
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "WAVheader.h"

#define BLOCK_SIZE 16
#define MAX_NUM_CHANNEL 8

// Number of channels
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
#define MINUS_4DB 0.630957 

// IO Buffers
static double sampleBuffer[MAX_NUM_CHANNEL][BLOCK_SIZE];

static double limiterThreshold = 0.999;

// Enable
static int enabled = 1;

// Gains
static double variablesGain[INPUT_NUM_CHANNELS] = { MINUS_4DB, MINUS_4DB };

// Output Mode
static mode outputMode = OUTPUT_MODE_3_2_1;

double saturation(double in)
{
	// Simple limiter since we know that pre-Gain adds 6dB
	if (in > limiterThreshold)
	{
		return fmin(in, limiterThreshold);
	}
	else if (in < -limiterThreshold)
	{
		return fmax(in, -limiterThreshold);
	}
	return in;
}

void signalProcessing(double pIn[][BLOCK_SIZE], double pOut[][BLOCK_SIZE])
{
	double* variablesGainPtrL = variablesGain + L_CH;
	double* variablesGainPtrR = variablesGain + R_CH;

	double* samplePtrInL = *(pIn + L_CH);
	double* samplePtrInR = *(pIn + R_CH);

	double* samplePtrOutL = *(pOut + L_CH);
	double* samplePtrOutR = *(pOut + R_CH);
	double* samplePtrOutLs = *(pOut + LS_CH);
	double* samplePtrOutRs = *(pOut + RS_CH);
	double* samplePtrOutC = *(pOut + C_CH);
	double* samplePtrOutLfe = *(pOut + LFE_CH);

	for (int j = 0; j < BLOCK_SIZE; j++)
	{
		// first stage, apply variable gain	(L and R channel processing)
		*samplePtrOutL = *samplePtrInL * *variablesGainPtrL;
		*samplePtrOutR = *samplePtrInR * *variablesGainPtrR;
		if (outputMode > 0)	// outputMode == OUTPUT_MODE_2_2_0 || outputMode == OUTPUT_MODE_3_2_1
		{
			// second stage, full wave rectifier distortion (LS and RS channel processing)
			*samplePtrOutLs = fabs(*samplePtrOutL);
			*samplePtrOutRs = fabs(*samplePtrOutR);
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
int main(int argc, char* argv[])
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
	for (int i = 0; i < MAX_NUM_CHANNEL; i++)
		memset(&sampleBuffer[i], 0, BLOCK_SIZE);

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
			variablesGain[R_CH] = pow(10.0, ((rGain) / 20.0));
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
			variablesGain[L_CH] = pow(10.0, ((lGain) / 20.0));
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

	printf("Enabled: %d | GainL: %f | GainR: %f | OutputMode: %d\n", enabled, variablesGain[0], variablesGain[1], outputMode);
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

	int oneChannelSubChunk2Size = inputWAVhdr.data.SubChunk2Size / inputWAVhdr.fmt.NumChannels;
	int oneChannelByteRate = inputWAVhdr.fmt.ByteRate / inputWAVhdr.fmt.NumChannels;
	int oneChannelBlockAlign = inputWAVhdr.fmt.BlockAlign / inputWAVhdr.fmt.NumChannels;

	outputWAVhdr.data.SubChunk2Size = oneChannelSubChunk2Size * outputWAVhdr.fmt.NumChannels;
	outputWAVhdr.fmt.ByteRate = oneChannelByteRate * outputWAVhdr.fmt.NumChannels;
	outputWAVhdr.fmt.BlockAlign = oneChannelBlockAlign * outputWAVhdr.fmt.NumChannels;


	// Write output WAV header to file
	//-------------------------------------------------
	WriteWavHeader(wav_out, outputWAVhdr);

	// Processing loop
	//-------------------------------------------------	
	{
		int sample;
		int BytesPerSample = inputWAVhdr.fmt.BitsPerSample / 8;
		const double SAMPLE_SCALE = -(double)(1 << 31);		//2^31
		int iNumSamples = inputWAVhdr.data.SubChunk2Size / (inputWAVhdr.fmt.NumChannels * inputWAVhdr.fmt.BitsPerSample / 8);

		// exact file length should be handled correctly...
		for (int i = 0; i < iNumSamples / BLOCK_SIZE; i++)
		{
			for (int j = 0; j < BLOCK_SIZE; j++)
			{
				for (int k = 0; k < inputWAVhdr.fmt.NumChannels; k++)
				{
					sample = 0; //debug
					fread(&sample, BytesPerSample, 1, wav_in);
					sample = sample << (32 - inputWAVhdr.fmt.BitsPerSample); // force signextend
					sampleBuffer[k][j] = sample / SAMPLE_SCALE;				// scale sample to 1.0/-1.0 range		
				}
			}
			if(enabled)
				signalProcessing(sampleBuffer, sampleBuffer);

			for (int j = 0; j < BLOCK_SIZE; j++)
			{
				for (int k = 0; k < outputWAVhdr.fmt.NumChannels; k++)
				{
					sample = sampleBuffer[k][j] * SAMPLE_SCALE;	// crude, non-rounding 			
					sample = sample >> (32 - inputWAVhdr.fmt.BitsPerSample);
					fwrite(&sample, outputWAVhdr.fmt.BitsPerSample / 8, 1, wav_out);
				}
			}
		}
	}

	// Close files
	//-------------------------------------------------	
	fclose(wav_in);
	fclose(wav_out);
	//-------------------------------------------------	

	return 0;
}