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

<a title="Tjwikcom / Public domain" href="https://commons.wikimedia.org/wiki/File:ADC_Symbol.svg"><img width="256" alt="ADC Symbol" src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/ADC_Symbol.svg/256px-ADC_Symbol.svg.png"></a>

以聲音信號為例，非常粗淺的說明投影片
* pptx [SpeechA2D.pptx](SpeechA2D.pptx)
* pdf  [SpeechA2D.pdf](SpeechA2D.pdf)



### 2.2 Why Digital?

* Analog Transistor Amplifier Circuit
一組雙極型電晶體放大器電路實例
<a title="Twisp / Public domain" href="https://commons.wikimedia.org/wiki/File:Amplifier_Circuit_Small.svg"><img width="512" alt="Amplifier Circuit Small" src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Amplifier_Circuit_Small.svg/512px-Amplifier_Circuit_Small.svg.png"></a>

* Discrete-Time Signal Processing (DSP)
![](https://i.imgur.com/vBjpyuE.png)
    * DSP? What does D stand for? Discrete or Digital?
    * C/D: Continuous to Discrete Conversion
    ![](https://i.imgur.com/GUYvJKO.png)
        > http://zpostbox.ru/simple_adc.html
    
    ![](https://i.imgur.com/p5K0mXs.png)
    > https://www.allaboutcircuits.com/worksheets/analog-to-digital-conversion/



也可參考[成大資工Wiki](http://wiki.csie.ncku.edu.tw/embedded/ADC)詳細看ADC (Analog-to-Digital Converter)

* Digital 優點 (Pros)
* Digital 缺點 (Cons)

### 2.3 Sampling
* Nyquist Theorem
* Aliasing

### 2.4 Quantization
* Quantization level
* Linear or non-linear quantization
* Sample size or bit depth (color depth for images)
* Quantization Error/Noise
* Signal-to-Noise Ratio (SNR)
* Signal-to-quantization-noise ratio (SQNR)

### 2.5 Mini Project 1 - Generating Sine Waves










