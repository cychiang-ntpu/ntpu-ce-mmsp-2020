# 2. Digital Data (Signal) Representation
## 2.1 Analog to Digital Conversion in Brief

###### tags: `Multimedia Signal Processing (U3329, Fall, 2020)`
###### 通訊系 江振宇 副教授

上課影片：https://youtu.be/6WapSyQvxZU

<p align="center">
<a title="Tjwikcom / Public domain" href="https://commons.wikimedia.org/wiki/File:ADC_Symbol.svg"><img width="256" alt="ADC Symbol" src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/ADC_Symbol.svg/256px-ADC_Symbol.svg.png"></a>
</p>


以聲音信號為例，非常粗淺的說明投影片
* pptx [SpeechA2D.pptx](SpeechA2D.pptx)
* pdf  [SpeechA2D.pdf](SpeechA2D.pdf)

---

## 2.2 Why Digital?

上課影片 2.2/2.3/2.4： https://youtu.be/5LWGdMSu-yk

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

## 2.3 Ideal Periodic Sampling
Sampling: A process of converting a signal (e.g., a function of continuous time or space) into a numeric sequence (a function of discrete time or space)
* For images the sample points are evenly separated in space
* For sound the sample points are evenly separated in time

![](https://i.imgur.com/qH60D5D.png)

![](https://i.imgur.com/lIfl9pF.png)


<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=x[n]=x_c(nT)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x[n]=x_c(nT)" title="x[n]=x_c(nT)" /></a>
</p>

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=x_s(t)=x_c(t)s(t)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x_s(t)=x_c(t)s(t)" title="x_s(t)=x_c(t)s(t)" /></a>
</p>

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=s(t)=\sum_{k}\delta(t-kT)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?s(t)=\sum_{k}\delta(t-kT)" title="s(t)=\sum_{k}\delta(t-kT)" /></a>
</p>


<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;T" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;T" title="T" /></a> 我們稱為 sampling period，<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;f_s=1/T" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;f_s=1/T" title="f_s=1/T" /></a> 稱為 sampling frequency (或 sampling rate、resolution)，<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\delta(t)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;\delta(t)" title="\delta(t)" /></a> 稱為 the unit impulse function 或稱 Dirac delta function。<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_s(n)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;x_s(t)" title="x_s(t)" /></a> 仍視為 continuous signal，因為 [<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\delta(t)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;\delta(t)" title="\delta(t)" /></a>](https://en.wikipedia.org/wiki/Dirac_delta_function) 的特性，<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;x_s(n)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;x_s(t)" title="x_s(t)" /></a> 可以寫成：

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=x_s(t)=\sum_{n}x_c(nT)\delta(t-nT)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x_s(t)=\sum_{n}x_c(nT)\delta(t-nT)" title="x_s(t)=\sum_{n}x_c(nT)\delta(t-nT)" /></a>
</p>

由 signals and systems 課程知道，在時間軸上是 impulse，頻率軸上也是 impulse:

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=s(t)=\sum_{k}\delta(t-kT)&space;\longleftrightarrow&space;S(j\Omega)=\frac{2\pi}{T}\sum_{k}\delta(\Omega-k\Omega_s)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?s(t)=\sum_{k}\delta(t-kT)&space;\longleftrightarrow&space;S(j\Omega)=\frac{2\pi}{T}\sum_{k}\delta(\Omega-k\Omega_s)" title="s(t)=\sum_{k}\delta(t-kT) \longleftrightarrow S(j\Omega)=\frac{2\pi}{T}\sum_{k}\delta(\Omega-k\Omega_s)" /></a>
</p>

其中 <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;\Omega_s=2\pi/T" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;\Omega_s=2\pi/T" title="\Omega_s=2\pi/T" /></a> 是以 radians/s 為單位的取樣頻率

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=x_s(t)=x_c(t)s(t)&space;\longleftrightarrow&space;\frac{1}{2\pi}X_c(j\Omega)*S(j\Omega)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?x_s(t)=x_c(t)s(t)&space;\longleftrightarrow&space;\frac{1}{2\pi}X_c(j\Omega)*S(j\Omega)" title="x_s(t)=x_c(t)s(t) \longleftrightarrow \frac{1}{2\pi}X_c(j\Omega)*S(j\Omega)" /></a>
</p>

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=X_s(j\Omega)=\frac{1}{T}\sum_{k}X_c(j(\Omega-k\Omega_s)" target="_blank"><img src="https://latex.codecogs.com/svg.latex?X_s(j\Omega)=\frac{1}{T}\sum_{k}X_c(j(\Omega-k\Omega_s)" title="X_s(j\Omega)=\frac{1}{T}\sum_{k}X_c(j(\Omega-k\Omega_s)" /></a>
</p>




--- 

### C/D
![](https://i.imgur.com/p9L0Ftn.png)

---

### D/C
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



## 2.4 Quantization
上課影片 2.4：https://youtu.be/nKVdRY2g6Xg
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
<a href="https://www.codecogs.com/eqnedit.php?latex=e[n]=x[n]-Q(x[n])" target="_blank"><img src="https://latex.codecogs.com/svg.latex?e[n]=x[n]-Q(x[n])" title="e[n]=x[n]-Q(x[n])" /></a>
</p>

* **Signal-to-Noise Ratio (SNR)**: 所指為有用訊號功率（Power of Signal）與雜訊功率（Power of Noise）的比：

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=SNR=\frac{P_{signal}}{P_{noise}}" target="_blank"><img src="https://latex.codecogs.com/svg.latex?SNR=\frac{P_{signal}}{P_{noise}}" title="SNR=\frac{P_{signal}}{P_{noise}}" /></a>
</p>

其中 <a href="https://www.codecogs.com/eqnedit.php?latex=P_{signal}" target="_blank"><img src="https://latex.codecogs.com/svg.latex?P_{signal}" title="P_{signal}" /></a> 為訊號的 power (或稱 intensity)，<a href="https://www.codecogs.com/eqnedit.php?latex=P_{noise}" target="_blank"><img src="https://latex.codecogs.com/svg.latex?P_{noise}" title="P_{noise}" /></a>為噪音的 power，因為知道 <a href="https://www.codecogs.com/eqnedit.php?latex=P=V^2/R" target="_blank"><img src="https://latex.codecogs.com/svg.latex?P=V^2/R" title="P=V^2/R" /></a>，所以 SNR 也可以定義為：

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=SNR=\frac{A_{signal}^2}{A_{noise}^2}" target="_blank"><img src="https://latex.codecogs.com/svg.latex?SNR=\frac{A_{signal}^2}{A_{noise}^2}" title="SNR=\frac{A_{signal}^2}{A_{noise}^2}" /></a>
</p>

其中 <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;A_{signal}" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;A_{signal}" title="A_{signal}" /></a> 為訊號振幅 (amplitude of signal)，通常是定義為訊號的最大振幅，而 <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;A_{noise}" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;A_{noise}" title="A_{noise}" /></a> 為噪音振幅 (amplitude of noise)，通常是定義為噪音的最大振幅。

為了方便SNR的數字以及對應人所能對應的感知大小，SNR習慣上使用分貝(dB)作為單為，其值為十倍對數訊號與雜訊功率比：

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=SNR(dB)=10&space;log10(\frac{P_{signal}}{P_{noise}})" target="_blank"><img src="https://latex.codecogs.com/svg.latex?SNR(dB)=10&space;log10(\frac{P_{signal}}{P_{noise}})" title="SNR(dB)=10 log10(\frac{P_{signal}}{P_{noise}})" /></a>
</p>

或

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=SNR(dB)=20&space;log10(\frac{A_{signal}}{A_{noise}})" target="_blank"><img src="https://latex.codecogs.com/svg.latex?SNR(dB)=20&space;log10(\frac{A_{signal}}{A_{noise}})" title="SNR(dB)=20 log10(\frac{A_{signal}}{A_{noise}})" /></a>
</p>

* Signal-to-quantization-noise ratio (SQNR)

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;SQNR(dB)=10log10(\frac{P}{P_0})" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;SQNR(dB)=10log10(\frac{P}{P_0})" title="SQNR(dB)=10log10(\frac{P}{P_0})" /></a>
</p>

其中 <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;P" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;P" title="P" /></a> 代表原本信號的 power，<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;P_0" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;P_0" title="P_0" /></a> 為 quantization noise 的 power，我們可以用以下的數學是來計算 signal power 以及 quantiztion noise 的 power：

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=P=E[x^2[n]]=\frac{1}{N}\sum_{n=0}^{N-1}x^2[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?P=E[x^2[n]]=\frac{1}{N}\sum_{n=0}^{N-1}x^2[n]" title="P=E[x^2[n]]=\frac{1}{N}\sum_{n=0}^{N-1}x^2[n]" /></a>
</p>

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=P_0=E[e^2[n]]=\frac{1}{N}\sum_{n=0}^{N-1}e^2[n]" target="_blank"><img src="https://latex.codecogs.com/svg.latex?P_0=E[e^2[n]]=\frac{1}{N}\sum_{n=0}^{N-1}e^2[n]" title="P_0=E[e^2[n]]=\frac{1}{N}\sum_{n=0}^{N-1}e^2[n]" /></a>
</p>

* **Dynamic range**: SQNR is directly related to Dynamic range. 動態範圍是描述量化後的信號能夠如何細緻描述信號振幅變化的量，並不是用來信號值域 (domain) 的範圍，我們也可以使用 SQNR 來敘述數位信號的 dynamic range，動態範圍越大則 SQNR 越大，通常我們直接用原信號的最大振幅和 quantization error 最大振幅的比值來作為數位訊號的 dynamic range (或直接代表 SQNR)，假如數位訊號的 quantization levels 為 <a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;L=2^m" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;L=2^m" title="L=2^m" /></a>，則此數位訊號的 dynamic range 為：

<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;SQNR(dB)=10log10(\frac{(2^{m-1}\Delta)^2}{(0.5\Delta)^2})=20log10(2^m)\approx&space;6.02m" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\inline&space;SQNR(dB)=10log10(\frac{(2^{m-1}\Delta)^2}{(0.5\Delta)^2})=20log10(2^m)\approx&space;6.02m" title="SQNR(dB)=10log10(\frac{(2^{m-1}\Delta)^2}{(0.5\Delta)^2})=20log10(2^m)\approx 6.02m" /></a>
</p>


## 2.5 Mini Project 1 - Generating Sine Waves
撰寫一支 C 語言程式 sinegen_xxxxxxxxx.c，其中 xxxxxxxxx 代表你的學號，在 compile 和 link 後的執行檔，可以使用以下方法產生弦波的 wav file 和計算 SQNR：

`sinegen_xxxxxxxxx fs m f A T  1> fn.wav 2> sqnr.txt`

參數說明如下：

| 參數 | 意義 | 單位 | applicable values |
| -------- | -------- | -------- | -------|
| fs     | 取樣率    | Hz | 8000/16000/22050/44100     |
| m      | sample size | bit | 8/16/32 |
| f      | 訊號頻率  | Hz | 取決於 fs     |
| A      | 振幅     | Hz | 取決於 m     |
| T      | 產生的弦波長度 | second | possible real value |

輸出：
1. fn.wav 為 WAV 檔的檔名，格式為 [WAV](https://zh.wikipedia.org/wiki/WAV) 
2. sqnr.txt 為 txt 的檔名，請將 SQNR 以 [ASCII](https://zh.wikipedia.org/wiki/ASCII) 的 [plain text](https://zh.wikipedia.org/wiki/%E6%96%87%E6%9C%AC%E6%96%87%E4%BB%B6) 表示 (四捨五入) 到小數點 15 位的










