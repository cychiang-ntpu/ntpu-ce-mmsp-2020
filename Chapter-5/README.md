# 5. Digital Image Representation

###### tags: `Multimedia Signal Processing (U3329, Fall, 2020)`
###### 通訊系 江振宇 副教授


課程目標：
1. 了解 bitmap 的定義、來源、大小、解析度、顏色。
2. 影像的 spatial domain 以及 frequency domain
3. Two-dimensional discrete cosine transform (2D-DCT)
4. Color


---

## 5.1 數位影像的來源

### 5.1.1. Bitmapping
bitmap images 是由定義每一個像素 (pixel, picture element) 的顏色產生的數位資料，又稱為 pixmaps 或 raster graphics。可由以下方法產生：
1. digital cameras: 手機、專業數位相機、Webcam
2. scanners:
    ![](https://i.imgur.com/wbdshk2.jpg)
3. paint programs: 小畫家、CorelDRAW、Adobe Fresco、Adobe Photoshop、平板觸控筆(如Apple pencil)+筆記程式、[GNU Paint](https://www.gnu.org/software/gpaint/)、[GIMP](https://www.gimp.org/)

### 5.1.2. Vector graphics
使用數學式來描述圖形的參數，比如以圓心位置以及半徑來描述圓、以多項式描述曲線、以開始點以及結束點表示一條直線等等。可以使用以下方法產生：
1. CorelDRAW
2. 小畫家
![](https://i.imgur.com/jPFemgy.png)
3. MS Office: Word, Power point...
![](https://i.imgur.com/4ZtzhNz.png)
4. Adobe Illustrator

### 5.1.3. Procedural modeling
A number of techniques in computer graphics to create 3D models and textures from sets of rules.工具軟體有：Houdini、Blender、Grome等等。

https://youtu.be/Ahd70h9ZN2o
https://www.youtube.com/watch?v=gmYvA05orbs

---

## 5.2. Bitmaps
### 5.2.1 Definition
* A bitmap is two-dimensional array of pixels describing a digital image
* Each pixel $f(r,c)$, short for picture element, is a number representing the color at position (r,c) in the bitmap, where “r” is the row and “c” is the column

### 5.2.2 Bitmap Digitization 
*針對數位檔案的表示和儲存而言*

* Digital camera uses the same digitization process discussed in Chapter 2 (sampling and quantization)

* Sampling rate for digital camera (**Pixel Dimension**)
    * How many points of color are sampled and recorded in each dimension of the image
    * For example: 1600 x 1200, 1280 x 960, 1024 x 768 and 640 x 480. Some cameras do offer no choice
![](https://i.imgur.com/6D0Ksyr.png)

* Quantization in digital camera (**Bit Depth**)
    * Is a matter of the color model used and the corresponding bit depth (color models will be dealt in more details later in this chapter)
    * For now the digital cameras generally use RGB color, which saves each pixel in three bytes one for each of the color channels: red(R), green(G) and blue(B)
    * A higher bit depth is possible in RGB, but three bytes per pixel is common. 3 bytes = 24bits, therefore, $2^{24}$ = 16,777,216 colors to be represented

* Both sampling and qantization can introduce error
    * proper sampling rate (usaully related to **dimension**)
    ![](https://i.imgur.com/pbz8BLh.png)
source: https://www.cloudynights.com/uploads/monthly_02_2019/post-234657-0-50706300-1549928065.jpg
    * undersampled
    ![](https://i.imgur.com/sENjuML.png)
source: https://www.cloudynights.com/uploads/monthly_02_2019/post-234657-0-67539100-1549928245.jpg

    * Quantization (usually related to **bit depth**)
    ![](https://i.imgur.com/oz7yznN.png)
    ![](https://i.imgur.com/CY3Kz9M.png)
source: https://www.cambridge.org/core/books/handbook-of-medical-image-perception-and-techniques/image-quality-and-its-clinical-relevance/FA12ADE4513608F65A5F12CA816A9247
![](https://i.imgur.com/bRbRzgq.jpg)
source: https://kornelix.net/fotoxx_topics/color_depth.html

### 5.2.3 Pixel Dimension, Resolution and Image Size 
*針對顯示介面，如螢幕 (monitor/computer display) 以及印刷品 (print) 而言*
* Pixel Dimension
    * a pixel: a physical object a point of light on the screen
    * logical pixel vs. physical pixel: 在撰寫有關圖像處理或是 GUI 相關的程式會遇到，當你把 bitmap 檔案在一個螢幕上顯示，就要弄清楚。
    * The logical pixel i.e., the number representing a color and stored for a given position in the image file is mapped to a physical pixel on the computer screen
    * pixel dimension: a number of pixels horizontally (i.e., width, “w”) and vertically (i.e., height, “h”) denoted $w \times h$. The standards are HD, full HD, 4K, 8K...
* Resolution: the number of pixels in an image file per unit of spatial measure, i.e., pixel per inch, ppi
    * The same number of pixels are used in the horizontal and vertical directions
    * Resolution of a printer is a matter of how many dots of color it can print over an area, i.e., dots per inch (DPI)
    * The printer and its software map the pixels in an images file to the dots of color printed
    * There maybe more or fewer pixels per inch than dots printed
* Image Size
    * On Print
        * Is a physical dimensions of an image when it is printed our or displayed on a computer, e.g., in inches or centimeters
        * By this definition image size is a function of the pixel dimension and resolution, as follows:
            * For an image with resolution “r” and pixel dimensions “w x h” where “w” is the width and “h” is the height, the printed image size “a x b” is given by:
            $$a=w/r$$
            $$b=h/r$$
            * Example: If you have an image that is 1600 x 1200, and you choose to print it out at 200ppi, it will be 8” x 6”
    * On Computer Screen
        * For an image with pixel dimensions “w x h” and resolution “r”,  the displayed image size is, as before: $(w/r) \times (h/r)$
            * In this case “r” is the display screen’s resolution. Example: If your computer display screen has pixel dimensions of 1400 x 1050 and it is 12” x 9”, then the display has a resolution of about 117ppi
            * Therefore, an image with pixel dimension “w x h” where “w” is the width and “h” is the height displayed on a computer display with resolution “r” at 100% magnification, the displayed image size “a x b” is given by:
            $$a=w/r$$
            $$b=h/r$$
    * Terms Related to Image Size
        * Image Cropping is simply cutting off part of the picture, discarding the unwanted pixels
        * Resampling is changing the number of pixels in an image
            * Upsampling: increasing the pixel dimensions
            * Downsampling: decreasing the pixel dimensions
            * Resampling always involves some kind of interpolation, averaging or estimation and thus it cannot improve the quality of an image



---

## 5.3 讀寫 Bitmap Image File (\*.bmp)

以下是一個非常不正是但是可以執行的程式，讀了一張 input.bmp 檔，然後把圖像的左下角 300 x 400 的 pixel 強制變成黑色，然後再輸出成 output.bmp

[rwbmp.c](rwbmp.c)

```
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
			if (y < 100 && x<100) { // let pixels at x<100 and y<100 be zeros
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

```

[input](input.bmp)



[output](output.bmp)


---

## 5.4 Frequency in Digital Images

---

## 5.5 Two-Dimensional Discrete Cosine Transform (2D-DCT)

---

## 5.6 Color