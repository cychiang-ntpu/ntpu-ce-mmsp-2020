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

![](https://i.imgur.com/qH60D5D.png)

$$x[n]=x_c(nT)$$
$$x_s(n)=x_c(t)s(t)$$
$$s(t)=\sum_{k}\delta(t-kT)$$

$T$ 我們稱為 sampling period，$f_s=1/T$ 稱為 sampling frequency，$\delta(t)$ 稱為 the unit impulse function 或稱 Dirac delta function。$x_s(n)$ 仍視為 continuous signal，因為 [$\delta(t)$](https://en.wikipedia.org/wiki/Dirac_delta_function) 的特性，$x_s(n)$ 可以寫成：

$$x_s(t)=\sum_{n}x_c(nT)\delta(t-nT)$$

由 signals and systems 課程知道，在時間軸上是 impulse，頻率軸上也是 impulse:

$$s(t)=\sum_{k}\delta(t-kT) \longleftrightarrow S(j\Omega)=\frac{2\pi}{T}\sum_{k}\delta(\Omega-k\Omega_s)$$

其中 $\Omega_s=2\pi/T$ 是以 radians/s 為單位的取樣頻率

$$x_s(n)=x_c(t)s(t) \longleftrightarrow \frac{1}{2\pi}X_c(j\Omega)*S(j\Omega)$$

$$X_s(j\Omega)=\frac{1}{T}\sum_{k}X_c(j(\Omega-k\Omega_s)$$

--- 

#### C/D
![](https://i.imgur.com/p9L0Ftn.png)

---

#### D/C
![](https://i.imgur.com/XPRJlUP.png)

---

* Nyquist Theorem:
取樣頻率($\Omega_s$) $\geq$ 兩倍信號的最高頻率成分($2\Omega_N$)，才有機會藉由 low pass filter 由 $X_s(j\Omega)$ 擷取其低頻成分恢復成原信號 $X_c(j\Omega)$
* Aliasing: 若 $\Omega_s<2\Omega_N$，則原本信號的部分頻率成分遭到污染的現象。

### 2.4 Quantization
* Quantization level
* Linear or non-linear quantization
* Sample size or bit depth (color depth for images)
* Quantization Error/Noise
* Signal-to-Noise Ratio (SNR)
* Signal-to-quantization-noise ratio (SQNR)

### 2.5 Mini Project 1 - Generating Sine Waves










