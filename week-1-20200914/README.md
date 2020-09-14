# ntpu-ce-mmsp-2020-Week-1-20200914

## 1. Introduction to Multimedia Signal Processing
* 使用者介面/人機介面 (User Interface/Human-Machine Interface)
    * 喇叭/麥克風 (Loud speaker/Microphone)
    * 螢幕/攝影機 (Monitor/Camera)
    * 滑鼠/鍵盤/手寫 (Mouse/keyboard/handwriting)
* 數位信號 (Digital Signals)
    * 文字 (Text)
        * 網頁 (WebPages)
        * 電子文件 (Electronic documents)
    * 影像 (Image)
        * 照片(Photograph)
        * 影片(Video frame)
    * 聲音 (Audio)
        * 聲音事件 (Audio event)
        * 音樂 (Music)
        * 語音 (Speech)
* 系統 (Systems)
    * 壓縮/解壓縮 (compression, related to transmission)
    * 搜尋引擎 (Search engine)
    * 資訊擷取 (Information retrieval)
    * 內容識別 (content recognition/identification)


![](https://i.imgur.com/HoaWsh7.png)


## 2. Digital Data (Signal) Representation and Communication
### 2.1 Analog to Digital Conversion in Brief

<p align="center">
<a title="Tjwikcom / Public domain" href="https://commons.wikimedia.org/wiki/File:ADC_Symbol.svg"><img width="256" alt="ADC Symbol" src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/ADC_Symbol.svg/256px-ADC_Symbol.svg.png"></a>
</p>


以聲音信號為例，非常粗淺的說明投影片
* pptx [SpeechA2D.pptx](SpeechA2D.pptx)
* pdf  [SpeechA2D.pdf](SpeechA2D.pdf)



### 2.2 Why Digital?
* 若單純只要做一個放大信號的動作(Amplifier)
    * Analog Transistor Amplifier Circuit
一組雙極型電晶體放大器電路實例
<a title="Twisp / Public domain" href="https://commons.wikimedia.org/wiki/File:Amplifier_Circuit_Small.svg"><img width="512" alt="Amplifier Circuit Small" src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Amplifier_Circuit_Small.svg/512px-Amplifier_Circuit_Small.svg.png"></a>

    * Discrete-Time Signal Processing (DSP)
![](https://i.imgur.com/vBjpyuE.png)
        * 還需要C/D或是ADC(Analog to Digital Converter)把連續信號轉成離散信號或是數位信號
        * 在 discrete-time system 處理好之後，還要用 D/C 或是 DAC (Digital to Analog Converter) 把離散訊號轉回類比信號
        * DSP? What does D stand for? Discrete or Digital?
        * C/D: Continuous to Discrete Conversion
            * Simple Analog to Digital Converter
        ![](https://i.imgur.com/GUYvJKO.png)
                > http://zpostbox.ru/simple_adc.html
    
            ![](https://i.imgur.com/p5K0mXs.png)
> https://www.allaboutcircuits.com/worksheets/analog-to-digital-conversion/
            
也可參考[成大資工Wiki](http://wiki.csie.ncku.edu.tw/embedded/ADC)詳細看ADC (Analog-to-Digital Converter)

* Digital 優點 (Pros)
* Digital 缺點 (Cons)

### 2.3 Ideal Periodic Sampling
Sampling: A process of converting a signal (e.g., a function of continuous time or space) into a numeric sequence (a function of discrete time or space)
* For images the sample points are evenly separated in space
* For sound the sample points are evenly separated in time

![](https://i.imgur.com/qH60D5D.png)

![](https://i.imgur.com/lIfl9pF.png)


<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=x[n]=x_c(nT)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x[n]=x_c(nT)" title="x[n]=x_c(nT)" /></a>
</p>

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=x_s(n)=x_c(t)s(t)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x_s(n)=x_c(t)s(t)" title="x_s(n)=x_c(t)s(t)" /></a>
</p>

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=s(t)=\sum_{k}\delta(t-kT)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?s(t)=\sum_{k}\delta(t-kT)" title="s(t)=\sum_{k}\delta(t-kT)" /></a>
</p>


<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;T" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;T" title="T" /></a> 我們稱為 sampling period，<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;f_s=1/T" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;f_s=1/T" title="f_s=1/T" /></a> 稱為 sampling frequency (或 sampling rate、resolution)，<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\delta(t)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;\delta(t)" title="\delta(t)" /></a> 稱為 the unit impulse function 或稱 Dirac delta function。<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_s(n)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;x_s(n)" title="x_s(n)" /></a> 仍視為 continuous signal，因為 [<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\delta(t)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;\delta(t)" title="\delta(t)" /></a>](https://en.wikipedia.org/wiki/Dirac_delta_function) 的特性，<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_s(n)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;x_s(n)" title="x_s(n)" /></a> 可以寫成：

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=x_s(t)=\sum_{n}x_c(nT)\delta(t-nT)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x_s(t)=\sum_{n}x_c(nT)\delta(t-nT)" title="x_s(t)=\sum_{n}x_c(nT)\delta(t-nT)" /></a>
</p>

由 signals and systems 課程知道，在時間軸上是 impulse，頻率軸上也是 impulse:

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=s(t)=\sum_{k}\delta(t-kT)&space;\longleftrightarrow&space;S(j\Omega)=\frac{2\pi}{T}\sum_{k}\delta(\Omega-k\Omega_s)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?s(t)=\sum_{k}\delta(t-kT)&space;\longleftrightarrow&space;S(j\Omega)=\frac{2\pi}{T}\sum_{k}\delta(\Omega-k\Omega_s)" title="s(t)=\sum_{k}\delta(t-kT) \longleftrightarrow S(j\Omega)=\frac{2\pi}{T}\sum_{k}\delta(\Omega-k\Omega_s)" /></a>
</p>

其中 <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\Omega_s=2\pi/T" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;\Omega_s=2\pi/T" title="\Omega_s=2\pi/T" /></a> 是以 radians/s 為單位的取樣頻率

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=x_s(n)=x_c(t)s(t)&space;\longleftrightarrow&space;\frac{1}{2\pi}X_c(j\Omega)*S(j\Omega)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x_s(n)=x_c(t)s(t)&space;\longleftrightarrow&space;\frac{1}{2\pi}X_c(j\Omega)*S(j\Omega)" title="x_s(n)=x_c(t)s(t) \longleftrightarrow \frac{1}{2\pi}X_c(j\Omega)*S(j\Omega)" /></a>
</p>

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=X_s(j\Omega)=\frac{1}{T}\sum_{k}X_c(j(\Omega-k\Omega_s)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?X_s(j\Omega)=\frac{1}{T}\sum_{k}X_c(j(\Omega-k\Omega_s)" title="X_s(j\Omega)=\frac{1}{T}\sum_{k}X_c(j(\Omega-k\Omega_s)" /></a>
</p>




--- 

#### C/D
![](https://i.imgur.com/p9L0Ftn.png)

---

#### D/C
![](https://i.imgur.com/XPRJlUP.png)

---

* Nyquist Theorem:
取樣頻率(<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\Omega_s" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;\Omega_s" title="\Omega_s" /></a>) <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\geq" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;\geq" title="\geq" /></a> 兩倍信號的最高頻率成分(<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;2\Omega_N" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;2\Omega_N" title="2\Omega_N" /></a>)，才有機會藉由 low pass filter 由 <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;X_s(j\Omega)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;X_s(j\Omega)" title="X_s(j\Omega)" /></a> 擷取其低頻成分恢復成原信號 <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;X_c(j\Omega)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;X_c(j\Omega)" title="X_c(j\Omega)" /></a>
* Aliasing: 若 <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\Omega_s<2\Omega_N" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;\Omega_s<2\Omega_N" title="\Omega_s<2\Omega_N" /></a>，則原本信號的部分頻率成分遭到污染的現象。

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=x[n]=x_c(nT)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x[n]=x_c(nT)" title="x[n]=x_c(nT)" /></a>
</p>

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=x_c(t)=sin(2\pi&space;ft)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x_c(t)=sin(2\pi&space;ft)" title="x_c(t)=sin(2\pi ft)" /></a>
</p>

* Nyquist Rate vs. Nyquist Frequency
    * 兩者不要搞混
    * Nyquist Rate = <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;f_s" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;f_s" title="f_s" /></a>
    * Nyquist Frequency = <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;f_s/2" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;f_s/2" title="f_s/2" /></a>

* Case 1: No aliasing
<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=T=1/f_s=1/8000&space;\text{&space;and&space;}&space;f=3000" target="_blank"><img src="https://latex.codecogs.com/svg.latex?T=1/f_s=1/8000&space;\text{&space;and&space;}&space;f=3000" title="T=1/8000 \text{ and } f=3000" /></a>
</p>

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=x[n]=x_c(nT)=sin(2\pi&space;\times&space;3000&space;\times&space;\frac{n}{8000})" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x_1[n]=x_c(nT)=sin(2\pi&space;\times&space;3000&space;\times&space;\frac{n}{8000})" title="x[n]=x_c(nT)=sin(2\pi \times 3000 \times \frac{n}{8000})" /></a>
</p>

* Case 2: Aliasing (undersampling)
<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=T=1/f_s=1/8000&space;\text{&space;and&space;}&space;f=5000" target="_blank"><img src="https://latex.codecogs.com/svg.latex?T=1/f_s=1/8000&space;\text{&space;and&space;}&space;f=5000" title="T=1/8000 \text{ and } f=5000" /></a>
</p>

<a href="https://www.codecogs.com/eqnedit.php?latex=x[n]=x_c(nT)=sin(2\pi&space;\times&space;5000&space;\times&space;\frac{n}{8000})&space;=&space;sin(2\pi&space;\times&space;3000&space;\times&space;\frac{n}{8000})" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x_2[n]=x_c(nT)=sin(2\pi&space;\times&space;5000&space;\times&space;\frac{n}{8000})&space;=&space;sin(2\pi&space;\times&space;3000&space;\times&space;\frac{n}{8000})" title="x[n]=x_c(nT)=sin(2\pi \times 5000 \times \frac{n}{8000}) = sin(2\pi \times 3000 \times \frac{n}{8000})" /></a>

* Undersampling means the sampling rate did not keep up with the rate of change of pattern in the image or sound
* In digital image arises from undersampling and results in an image that does not match the original source, it may be blurred or have a false pattern similarly for audio wave



### 2.4 Quantization
* Requires that each sample be represented in a fixed number of bits, called the ***sample size*** or equivalently the ***bit depth***.
* Bit depth is for limiting ***precision*** with which each sample can be represented.
* For digital images, each sample represents a color at a discrete point in a two dimensional image.
* Number of colors possible is determined by the sample size or bit depth (color depth for images)
* Linear (uniform) Quantization
<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=Q(x[n])=\Delta&space;\cdot&space;\lfloor&space;\frac{x[n]}{\Delta}&plus;\frac{1}{2}\rfloor=\Delta&space;\cdot&space;floor(\frac{x[n]}{\Delta}&plus;\frac{1}{2})" target="_blank"><img src="https://latex.codecogs.com/svg.latex?Q(x[n])=\Delta&space;\cdot&space;\lfloor&space;\frac{x[n]}{\Delta}&plus;\frac{1}{2}\rfloor=\Delta&space;\cdot&space;floor(\frac{x[n]}{\Delta}&plus;\frac{1}{2})" title="Q(x[n])=\Delta \cdot \lfloor \frac{x[n]}{\Delta}+\frac{1}{2}\rfloor=\Delta \cdot floor(\frac{x[n]}{\Delta}+\frac{1}{2})" /></a>
</p>

* 我們稱 <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\Delta" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;\Delta" title="\Delta" /></a> 為 quantization step size 
* In general, if <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;m" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;m" title="m" /></a> is the number of bits used to quantize a digital sample, then the maximum number of different values (***quantization levels***) that can be represented, <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;L=2^m" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;L=2^m" title="L=2^m" /></a>.
* 影像儲存方面，一般使用R、G、B三元素儲存，則每個 pixel (picture element) 顏色可以使用8個 bits 表示，也就是量化為 256 個 quantization level
* 音訊方面常使用的的 sample size 是 16bits (65,532 levels) 或 32bits (4,294,967,296 levels)

![](https://i.imgur.com/BX2N2Gv.png)

![](https://i.imgur.com/oY2uyVZ.png)

![](https://i.imgur.com/kZCwCnb.png)
Example of quantization noise. (a) Unquantized samples of the signal x[n] = 0.99 cos(n/10). (b) Quantized samples of the cosine waveform in part (a) with a 3-bit quantizer. (c) Quantization error sequence for 3-bit quantization of the signal in (a). (d) Quantization error sequence for 8-bit quantization of the signal in (a).

![](https://i.imgur.com/4L7Uxeq.png)
> https://www.beis.de/Elektronik/DeltaSigma/DeltaSigma.html

![](https://i.imgur.com/gmDNYjm.png)
> https://www.beis.de/Elektronik/DeltaSigma/DeltaSigma.html

* Non-linear quantization
    * [A-law](https://en.wikipedia.org/wiki/A-law_algorithm)
    * [mu-law](https://en.wikipedia.org/wiki/%CE%9C-law_algorithm)

* Quantization Error/Noise
<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=e[n]=Q(x[n])-x[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?e[n]=Q(x[n])-x[n]" title="e[n]=Q(x[n])-x[n]" /></a>
</p>

* **Signal-to-Noise Ratio (SNR)**: 所指為有用訊號功率（Power of Signal）與雜訊功率（Power of Noise）的比：

<a href="https://www.codecogs.com/eqnedit.php?latex=SNR=\frac{P_{signal}}{P_{noise}}" target="_blank"><img src="https://latex.codecogs.com/svg.latex?SNR=\frac{P_{signal}}{P_{noise}}" title="SNR=\frac{P_{signal}}{P_{noise}}" /></a>

其中 <a href="https://www.codecogs.com/eqnedit.php?latex=P_{signal}" target="_blank"><img src="https://latex.codecogs.com/svg.latex?P_{signal}" title="P_{signal}" /></a> 為訊號的 power (或稱 intensity)，<a href="https://www.codecogs.com/eqnedit.php?latex=P_{noise}" target="_blank"><img src="https://latex.codecogs.com/svg.latex?P_{noise}" title="P_{noise}" /></a>為噪音的 power，因為知道 <a href="https://www.codecogs.com/eqnedit.php?latex=P=V^2/R" target="_blank"><img src="https://latex.codecogs.com/svg.latex?P=V^2/R" title="P=V^2/R" /></a>，所以 SNR 也可以定義為：

<a href="https://www.codecogs.com/eqnedit.php?latex=SNR=\frac{A_{signal}^2}{A_{noise}^2}" target="_blank"><img src="https://latex.codecogs.com/svg.latex?SNR=\frac{A_{signal}^2}{A_{noise}^2}" title="SNR=\frac{A_{signal}^2}{A_{noise}^2}" /></a>

其中 <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;A_{signal}" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;A_{signal}" title="A_{signal}" /></a> 為訊號振幅 (amplitude of signal)，通常是定義為訊號的最大振幅，而 <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;A_{noise}" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;A_{noise}" title="A_{noise}" /></a> 為噪音振幅 (amplitude of noise)，通常是定義為噪音的最大振幅。

為了方便SNR的數字以及對應人所能對應的感知大小，SNR習慣上使用分貝(dB)作為單為，其值為十倍對數訊號與雜訊功率比：

<a href="https://www.codecogs.com/eqnedit.php?latex=SNR(dB)=10&space;log10(\frac{P_{signal}}{P_{noise}})" target="_blank"><img src="https://latex.codecogs.com/svg.latex?SNR(dB)=10&space;log10(\frac{P_{signal}}{P_{noise}})" title="SNR(dB)=10 log10(\frac{P_{signal}}{P_{noise}})" /></a>

或

<a href="https://www.codecogs.com/eqnedit.php?latex=SNR(dB)=20&space;log10(\frac{A_{signal}}{A_{noise}})" target="_blank"><img src="https://latex.codecogs.com/svg.latex?SNR(dB)=20&space;log10(\frac{A_{signal}}{A_{noise}})" title="SNR(dB)=20 log10(\frac{A_{signal}}{A_{noise}})" /></a>

* Signal-to-quantization-noise ratio (SQNR)

### 2.5 Mini Project 1 - Generating Sine Waves










