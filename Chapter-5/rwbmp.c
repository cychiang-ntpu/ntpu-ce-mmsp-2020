#include <stdio.h>
#include <stdlib.h>
#include <math.h>
float PI = 3.14159265359;

/*construct a structure of BMP header*/
typedef struct Bmpheader {
	char identifier[2]; // 0x0000
	unsigned int filesize; // 0x0002
	unsigned short reserved; // 0x0006
	unsigned short reserved2;
	unsigned int bitmap_dataoffset; // 0x000A
	unsigned int bitmap_headersize; // 0x000E
	unsigned int width; // 0x0012
	unsigned int height; // 0x0016
	unsigned short planes; // 0x001A
	unsigned short bits_perpixel; // 0x001C
	unsigned int compression; // 0x001E
	unsigned int bitmap_datasize; // 0x0022
	unsigned int hresolution; // 0x0026
	unsigned int vresolution; // 0x002A
	unsigned int usedcolors; // 0x002E
	unsigned int importantcolors; // 0x0032
	unsigned int palette; // 0x0036
} Bitmap;

/*construct a structure of RGB*/
typedef struct RGB{
	unsigned char R;
	unsigned char G;
	unsigned char B;
} ImgRGB;


void readheader(FILE* fp, Bitmap *x);
ImgRGB** malloc_2D(int row, int col);
void InputData(FILE* fp, ImgRGB **array, int H, int W, int skip);

void output_bmp(ImgRGB **RGB, FILE* outfile, Bitmap bmpheader, int skip);


int main(int argc, char **argv)
{
	int i, j, x, y;
	FILE *fp_in;
	FILE *fp_out;
	
	

	char fn_in[] = "input.bmp";

	char fn_out[] = "output.bmp";

	fp_in = fopen(fn_in, "rb");
	if (fp_in) printf("Open %s as input file!\n", fn_in);
	else printf("Fail to open %s as input file!\n", fn_in);
	fp_out = fopen(fn_out, "wb");
	if (fp_out) printf("Open %s as output file!\n", fn_out);
	else printf("Fail to open %s as output file!\n", fn_out);

	//read header
	Bitmap bmpheader;
	readheader(fp_in, &bmpheader);
	//struct Bmpheader bmpheader

	// W:3024 x H:4032 for input.bmp
	int H = bmpheader.height;
	int W = bmpheader.width;

	// skip paddings at the end of each image line
	int skip = (4 - (bmpheader.width * 3) % 4);
	if (skip == 4) skip = 0;
	char skip_buf[3] = { 0, 0, 0 };

	// 8x8, if not multiples of 8, then bitmap padded, i.e. one more block
	int block_H = H / 8;
	if (H % 8 != 0) block_H++;
	int block_W = W / 8;
	if (W % 8 != 0) block_W++;

	printf("Image size: Width: %d x Height=%d pixels, total %d bytes\n", W, H, W*H * 3);
	printf("Image line skip=%d bytes\n", skip);
	printf("# of 8x8 blocks: W=%d x H=%d blocks, total %d blocks\n", block_W, block_H, block_W*block_H);

	printf("\nLoading BMP data: RRGGBB RRGGBB ... (BGR format in BMP file)\n");
	ImgRGB **Data_RGB = malloc_2D(bmpheader.height, bmpheader.width);
	InputData(fp_in, Data_RGB, bmpheader.height, bmpheader.width, skip);
	fclose(fp_in);

	printf("Data size loaded: %d bytes\n", H*W * 3);

	
	output_bmp(Data_RGB, fp_out, bmpheader, skip);
	printf("\n"); // DEBUG

	printf("Output decompressed image to: %s\n\n", fn_out);

	printf("Free memory and close files!\n");
	free(Data_RGB[0]);
	free(Data_RGB);

	
	fclose(fp_out);

	printf("Job done!\n");
	return 0;
}

/*read header*/
void readheader(FILE* fp, Bitmap *x) {
	fread(&x->identifier, sizeof(x->identifier), 1, fp);
	fread(&x->filesize, sizeof(x->filesize), 1, fp);
	fread(&x->reserved, sizeof(x->reserved), 1, fp);
	fread(&x->reserved2, sizeof(x->reserved2), 1, fp);
	fread(&x->bitmap_dataoffset, sizeof(x->bitmap_dataoffset), 1, fp);
	fread(&x->bitmap_headersize, sizeof(x->bitmap_headersize), 1, fp);
	fread(&x->width, sizeof(x->width), 1, fp);
	fread(&x->height, sizeof(x->height), 1, fp);
	fread(&x->planes, sizeof(x->planes), 1, fp);
	fread(&x->bits_perpixel, sizeof(x->bits_perpixel), 1, fp);
	fread(&x->compression, sizeof(x->compression), 1, fp);
	fread(&x->bitmap_datasize, sizeof(x->bitmap_datasize), 1, fp);
	fread(&x->hresolution, sizeof(x->hresolution), 1, fp);
	fread(&x->vresolution, sizeof(x->vresolution), 1, fp);
	fread(&x->usedcolors, sizeof(x->usedcolors), 1, fp);
	fread(&x->importantcolors, sizeof(x->importantcolors), 1, fp);

}

/* A function of making two dimensions memory locate array*/
ImgRGB** malloc_2D(int row, int col){
	ImgRGB **Array, *Data;
	int i;
	Array = (ImgRGB**)malloc(row*sizeof(ImgRGB *));
	Data = (ImgRGB*)malloc(row*col*sizeof(ImgRGB));
	for (i = 0; i<row; i++, Data += col){
		Array[i] = Data;
	}
	return Array;
}

/*input data without header into RGB structure*/
void InputData(FILE* fp, ImgRGB **array, int H, int W, int skip){
	int temp;
	char skip_buf[3];
	int i, j;
	for (i = 0; i<H; i++){
		for (j = 0; j<W; j++){
			temp = fgetc(fp);
			array[i][j].B = temp;
			temp = fgetc(fp);
			array[i][j].G = temp;
			temp = fgetc(fp);
			array[i][j].R = temp;
			if (i<9 && j<8) printf("%02x%02x%02x ", array[i][j].R, array[i][j].G, array[i][j].B); // DEBUG
		}
		if (skip != 0) fread(skip_buf, skip, 1, fp);
		if (i<9) printf("\n"); // DEBUG
	}
	printf("\n"); // DEBUG
}


/*output header and data*/
void output_bmp(ImgRGB **RGB, FILE* outfile, Bitmap bmpheader, int skip){
	char skip_buf[3] = { 0, 0, 0 };
	int x, y;
	fwrite(&bmpheader.identifier, sizeof(short), 1, outfile);
	fwrite(&bmpheader.filesize, sizeof(int), 1, outfile);
	fwrite(&bmpheader.reserved, sizeof(short), 1, outfile);
	fwrite(&bmpheader.reserved2, sizeof(short), 1, outfile);
	fwrite(&bmpheader.bitmap_dataoffset, sizeof(int), 1, outfile);
	fwrite(&bmpheader.bitmap_headersize, sizeof(int), 1, outfile);
	fwrite(&bmpheader.width, sizeof(int), 1, outfile);
	fwrite(&bmpheader.height, sizeof(int), 1, outfile);
	fwrite(&bmpheader.planes, sizeof(short), 1, outfile);
	fwrite(&bmpheader.bits_perpixel, sizeof(short), 1, outfile);
	fwrite(&bmpheader.compression, sizeof(int), 1, outfile);
	fwrite(&bmpheader.bitmap_datasize, sizeof(int), 1, outfile);
	fwrite(&bmpheader.hresolution, sizeof(int), 1, outfile);
	fwrite(&bmpheader.vresolution, sizeof(int), 1, outfile);
	fwrite(&bmpheader.usedcolors, sizeof(int), 1, outfile);
	fwrite(&bmpheader.importantcolors, sizeof(int), 1, outfile);

	for (x = 0; x<bmpheader.height; x++){
		for (y = 0; y<bmpheader.width; y++){
			if (y < 300 && x<400) { // let pixels at x<300 and y<400 be zeros
				RGB[x][y].B = 0;
				RGB[x][y].G = 0;
				RGB[x][y].R = 0;
			}
			fwrite(&RGB[x][y].B, sizeof(char), 1, outfile);
			fwrite(&RGB[x][y].G, sizeof(char), 1, outfile);
			fwrite(&RGB[x][y].R, sizeof(char), 1, outfile);
			if (x<9 && y<8) printf("%02x%02x%02x ", RGB[x][y].R, RGB[x][y].G, RGB[x][y].B); // DEBUG
		}
		if (skip != 0) { fwrite(skip_buf, skip, 1, outfile); }
		if (x<9) printf("\n"); // DEBUG
	}
}
