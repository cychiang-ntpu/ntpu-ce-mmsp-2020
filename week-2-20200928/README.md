# ntpu-ce-mmsp-2020-Week-2-20200928

## 3. Digital Audio Representation
課程目標：
1. 了解音訊的非常租淺的物理特性
2. 快速回顧數位音訊的來源以及儲存方法
3. 音訊的量測以及人類對於音訊的感知
4. 時頻譜 (spectrogram)



---

### 3.1 音訊/聲音的來源
* 聲波是聲音的傳播形式。由物體（聲源）振動產生的機械波。在氣體和液體介質中傳播時是一種縱波(機械波的一種)，但在固體介質中傳播時可能混有橫波(機械波的一種)。
* 任何器官所接收的聲音頻率都有其範圍限制。人耳可以聽到的聲波的頻率一般在20Hz至2×{\displaystyle 10^{4}}10^{{4}}Hz之間。其他動物的聽覺頻率範圍有所不同，狗可以聽到50000Hz的超聲波，但無法聽到15Hz以下的聲音。
* 縱波(或疏密波)：因為物質的震動造成傳播介質中質點的振動，而這個振動方向與波的傳播方向平行，的縱波(或疏密波)
* 橫波，又稱為高低波，是介質振動方向和波行進方向垂直的一種波。若此波沿著x軸移動，則介質的振動方向為與x軸垂直的方向上。舉例來說繩波就是一種橫波。
* When air molecules are squeezed together, air pressure rises. When they move apart, air pressure falls
* 語音

![](https://i.imgur.com/A23GhrQ.png)
> Docio-Fernandez L., García Mateo C. (2015) Speech Production. In: Li S.Z., Jain A.K. (eds) Encyclopedia of Biometrics. Springer, Boston, MA. https://doi.org/10.1007/978-1-4899-7488-4_199


![](https://i.imgur.com/ka05oSY.png)
> Docio-Fernandez L., García Mateo C. (2015) Speech Production. In: Li S.Z., Jain A.K. (eds) Encyclopedia of Biometrics. Springer, Boston, MA. https://doi.org/10.1007/978-1-4899-7488-4_199


https://www.voicescienceworks.org/vocal-tract.html



Sean Parker Institute for the Voice: https://voice.weill.cornell.edu/voice-evaluation/normal-voice-function


Vibration of the Vocal Folds: https://www.youtube.com/watch?v=kfkFTw3sBXQ

* Digital Model for Speech Production
![](https://i.imgur.com/VNGmOQr.png)

* Source-Filter Model and Correponding Spectra
![](https://i.imgur.com/X8mzLRN.png)

https://highscope.ch.ntu.edu.tw/wordpress/?p=1008

---

樂器：
烏克麗麗：錄影彈空弦(G,C,E,A)、錄影彈和弦(C,F,G,C)

鋼琴：
鋼琴的「擊弦機制」
https://tw.yamaha.com/zh/products/contents/musical_instrument_guide/piano/mechanism/mechanism003.html

銅鈸:
麵包超人主題曲片頭：https://www.youtube.com/watch?v=XT53CXcsL3Y
銅鈸 1000 times
https://www.youtube.com/watch?v=kpoanOlb3-w

小鼓
https://www.youtube.com/watch?v=tM8WyhB6zYo


---
### 3.2 音訊的拾取及數位化
由機械波轉換成電壓，在由電壓再轉換成數位訊號。

* 由機械波轉換成電壓，記錄下來的振幅與時間的關係，就是 waveform (波形)

![](https://i.imgur.com/fVMDLkc.jpg)

* 由電壓再轉換成數位訊號，以0或1的序列表示，一種最常使用來表示waveform 0或1的資訊方法，稱為 pulse code modulation (PCM)

![](https://i.imgur.com/2H3Q5X3.png)

* Pulse Code Modulation
    * Invented in 1937 by Alec Reeves, who at that time worked for International Telephone and Telegraph.
    * PCM is based on the methods of sampling and quantization applied to sound. 
    * In that time, Reeves focused on ‘modulation’
    * each sample be quantized and encoded in binary, and the bits be transmitted as pulses representing 0s and 1s.
    * The term PCM is still used in digital audio to refer to the sampling and quantization process.
    * In fact, PCM files are files that are digitized but not compressed.
    * When you want to save your files in "raw" version, you can save them as PCM files.
    * When you create a new audio file in a digital audio processing program, you are asked to choose the **sampling rate** and **bit depth**.

* Sampling rates - measured in cycles per second, designated in units of Hertz. The most common choices: 
    * 8 kHz mono for telephone quality voice,
    * 44.1 kHz two-channel stereo with 16 bits per channel for CD-quality sound
    * Digital audio tape (DAT) format uses a sampling rate of 48 kHz. 
    * 96 or 192 kHz for two-channel stereo DVD with 24 bits per channel).


* Bit Depth - puts a limit on the precision with which you can represent each sample, determining the signal-to-quantization-noise ratio and dynamic range.
    * 16bit/smp is a very common setting.
        * range of amplitude: integers on [-2^15, 2^15 - 1] 
        * can be represented by data type of ‘short’ (2 bytes)
    * Sometimes 32-bit samples are used initially for greater accuracy during sound processing, after which the audio can be downsampled to 16 bits before compression.

* Considerations on Sampling Rate and Bit Depth
    * Sampling rate and bit depth should match that of other audio clips with which you might be mixing the current one.
    * They should also be appropriate for the type of sound you're recording, the storage capacity of the medium on which the audio will be stored, and the sensitivity of the equipment on which it will be played.
    * You may sometimes want to use a higher sampling rate than you will ultimately need so that less error is introduced if you add special effects. 


* An Example C Code Generating Sin Wave and Saved in PCM file
```
#include <stdio.h>
#include <math.h>
#include <memory.h>
#define PI 3.14159265359
/* This program generates a PCM file of 1 second 440Hz pure sin wave*/
int main(void)
{
    double fs = 16000;// sampling frequency 16kHz
    double T = 1/fs;// sampling period 1/16k
    double L = 1.0;// length of sin wave in an unit of second
    double f = 440;// frequency of sin wave (Hz)
    double A = 10000;// amplitude of sin wave
    short *x;// array of the sin wave (2 byte for each sample)
    double tmp;// temp variable
    size_t N = (size_t)(L * fs);// length of sin wave (sample)
    size_t n;// sample index
    FILE *fp;// a file pointet to save waveform
    char fn[1024] = {"sin440Hz.pcm"};
    x = (short *) malloc(sizeof(short) * N);
    for( n = 0; n < N; n ++ ) {
        tmp = A * sin(2 * PI * f * n * T); // generate sin wave for each sample
        x[n] = (short)floor(tmp + 0.5);// quantization
    }
    fp = fopen(fn, "wb");// open a file pointer to save a binary file
    if( !fp ) {// chech if the file is opened sucessfully
        fprintf(stderr, "Cannot save %s\n", fn);
        exit(1);// stop and exit this program if error
    }
    fwrite( x, sizeof(short), N, fp);// write the waveform to the file
    fclose(fp);
    return 0;
}
```

* Undersampling (aliasing)
    * 在 Chapter 2 提過

---

### 3.3 音訊的基礎量測
#### 3.3.1 Frequency
* Refers to the number of complete back-and-forth cycles of vibrational motion of the medium particles per unit of time
* Unit for frequency: Hz (Hertz)
* 1 Hz = 1 cycle/second
* A cycle (for sine wave)
![](https://i.imgur.com/Jwllnlq.png)

* A 2Hz-sine wave example
![](https://i.imgur.com/ZXMB3qM.png)

* A 4Hz-sine wave example
![](https://i.imgur.com/mh1XFQB.png)

* sine wave 的波形，我們通常稱為 (pure) tone
* Human ear can hear sound ranging from 20 Hz to 20,000 Hz


* 使用 [wavesurfer](https://sourceforge.net/projects/wavesurfer/) 軟體顯示的真實語音信號，語音內容為 "voice" 這個英文詞。 [voice.wav](voice.wav)
![](https://i.imgur.com/mZVIJIN.png)

* 觀察 "voice" 這個詞裡面穩定的 5 個週期所佔的時間，開始時間約為 0.1112 秒，結束時間約為 0.1352 秒，所以基本週期 (fundamental period) 大約是 (0.1352 - 0.1112)/5 = 0.0048 秒，基本頻率 (fundamental frequency) 大約是 5/(0.1352 - 0.1112) = 208.33 Hz
![](https://i.imgur.com/tiUbBKS.png)

* 可以發現到在剛剛的 0.1352 - 0.1112 的約 0.024秒以內，語音的 waveform 是穩定的，意思是說可以明顯地看到有 5 個相似的波形重複，但如果仔細檢查這段時間的語音信號，並不是完全符合嚴格的週期性訊號(periodic signal)定義，嚴格來說是準週期 (Quasiperiodicity)的訊號。
    * Periodic Signal：如果一個信號 $x[n]$ 是週期信號 (periodic signal)，則我們可以找到一個最小的數字 $N$ 使得 $x[n]=x[n+N]$
    * Quasiperiodic Signals：準週期信號是具有[概週期函數特性](https://zh.wikipedia.org/wiki/%E6%A6%82%E5%91%A8%E6%9C%9F%E5%87%BD%E6%95%B0)的信號，以四季變化為例 --> Climate oscillations that appear to follow a regular pattern but which do not have a fixed period are called quasiperiodic
* 一個不完全正確但是逼近的分析語音的方法，就是假設語音信號在某一個短時間內，通常稱為音框 (frame)，語音是穩定且假設是 periodic signal，所以我們可以用 Fourier Series (FS) 或是 Fourier Transform (FT) 來描述語音信號的頻率組成成分
    * 分析語音通常使用 20ms 到 40ms 之間的 frame，所以如果取樣率是 16000Hz，以 frame size = 20ms 為例，就是拿 $0.02\text{(sec)}\times16000\text{(points/second)}=320 \text{points}$ 的訊號去做 FT 或是 FS，每隔 5 ms 或 10ms 就再重複一樣做 FT/FS， 這裡的 5 ms 或 10ms 就稱為 frame interval。
    * 音訊以 mp3 為例，在取樣率為 44100 Hz 的情況下，frame 長度為 576 or 1152 個 samples，所以大約為 0.0065 seconds 或0.0131 seconds 為一個 frame，frame interval 為 576 or 1152 個 samples
    * 因為假設所要分析的訊號為 periodic，則可以把訊號拆解為
        * Fundamental frequency component: sine wave at $F_0$ Hz 
        * Harmonics: sine waves at $2F_0$Hz, $3F_0$Hz,...,and $(N-1)F_0$Hz.
            * 注意！ $N$ 代表 frame size


#### 3.3.2 Amplitude
Amplitude can be measured with a variety of units, including voltages, newtons/m^2, or the unitless measure called decibels.

* 機械波量測：Newtons/meter^2 (abbreviated Pa or N/m^2)
    * We described how a vibrating object pushes molecules closer together, creating changes in air pressure.
    * Since this movement is the basis of sound, it makes sense to measure the loudness of a sound in terms of air pressure changes.
    * The average atmospheric pres-sure at sea level is approximately 105 Pa.
    * For sound waves, air pressure amplitude is defined as the average deviation from normal background atmospheric air pressure. 
    * For example, the threshold of human hearing (for a 1000 Hz sound wave) varies from the normal background atmospheric air pressure by 2 * 10-5 Pa, so this is its pressure amplitude. 注意！這裏 air pressure 都是用 root mean sqaure ([RMS](https://en.wikipedia.org/wiki/Root_mean_square)) 來計算的
    * http://www.sengpielaudio.com/calculator-soundlevel.htm
    * Measuring sound in terms of pressure amplitude is intuitively easy to understand, but in practice decibels are a more common, and in many ways a more convenient, way to measure sound amplitude.
![](https://i.imgur.com/4WALRWe.png)

* 聽覺相對參考：decibels-sound-pressure-level (dB_SPL)
    * A decibel is always based upon some agreed-upon reference point, and the reference point varies ac-cording to the phenomenon being measured. 
    * For sound, the reference point is the air pressure ampli-tude for the threshold of hearing. A decibel in the context of sound pressure level is called decibels-sound-pressure-level (dB_SPL). 
    ![](https://i.imgur.com/8ep3AT3.png)
    * Experimentally, it has been determined that if you increase the amplitude of an audio recording by 10 dB, it will sound about twice as loud. (Of course, these perceived differences are subjective.)
    * For most humans, a 3 dB change in amplitude is the smallest perceptible change.
* 電腦儲存，請回顧 Signal-to-Quantization-Noise-Ratio (SQNR) and Dynamic Range in Terms of dB
    * Sample Values
        * Integers on [-2n, 2n - 1]; where n=16 is the bit depth of a digital file.
        ![](https://i.imgur.com/Xd1yIUv.png)
    * decibels-full-scale (dBFS)
        * If n=16, a sample value of ±32768 maps to 0 dBFS (the maximum amplitude possible for the system), and 10,000 maps to -10.3 dBFS; 1 maps to -90.3 dBFS.
![](https://i.imgur.com/ao5KtzP.png)
![](https://i.imgur.com/CKRl9vS.png)
    * Percentage
        * maximum --> 100%, minimum --> -100%
        ![](https://i.imgur.com/Ig1nMUh.png)
    * Normalized Value
        * amplitude is normalized in [-1,1]
        ![](https://i.imgur.com/ZZvZHsR.png)

---

### 3.4 音訊的人類感知
#### 3.4.1 Perception - Frequency vs. Pitch
* Online Tone Generator: https://www.szynalski.com/tone-generator/
* 一般來講 Higher frequency --> higher pitch
* 250Hz pure tone 和 260Hz pure tone的差異 vs. 1000Hz pure tone 和 1010Hz pure tone的差異
* 以音階為例，高八度是指 fundamental frequency 變為兩倍
* 音準 --> pitch 很準，這個說法是人的聽感感知
* Frequency 是客觀 (objective) 的量測，而 pitch 是主觀 (subjective) 的聽感感知


#### 3.4.2 Perception - Intensity/Energy vs. Loudness
* Sound intensity:
    * an objective measurement
    * can be measured with auditory devices
in decibels (dB)
* Loudness:
    * a subjective perception measured by human listeners
    * human ears have different sensitivity to different sound frequency
    * in general, higher sound intensity means louder sound


#### 3.4.3 Absolute threshold of hearing (ATH) and Equal-loudness contour
The threshold of hearing is generally reported as the RMS sound pressure of 20 micropascals, i.e. 0 dB SPL, corresponding to a sound intensity of 0.98 pW/m2 at 1 atmosphere and 25 °C.[3] It is approximately the quietest sound a young human with undamaged hearing can detect at 1,000 Hz.[4] The threshold of hearing is frequency-dependent and it has been shown that the ear's sensitivity is best at frequencies between 2 kHz and 5 kHz,[5] where the threshold reaches as low as −9 dB SPL.

![](https://i.imgur.com/Ab6TMfI.png)


#### 3.4.4 Mel Scale and Bark Scale
* Mel Scale
![](https://i.imgur.com/DIN4RFz.png)
* Bark Scale
![](https://i.imgur.com/omU3n8e.png)



---

### [3.5 Mini Project 2 - 音訊的時頻分析 - 使用 spectrogram](mini_project-2-spectrogram.docx)










