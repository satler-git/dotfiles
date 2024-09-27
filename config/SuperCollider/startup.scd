// SuperDirtのインクルード
include("SuperDirt");

// SuperDirtの設定
s.waitForBoot {
    // サンプルレートやバッファの設定
    s.options.sampleRate = 44100;
    s.options.numBuffers = 1024 * 128;
    s.options.memSize = 8192 * 32;
    s.options.numWireBufs = 64;
    s.options.maxNodes = 1024 * 32;
    s.options.numOutputBusChannels = 2;
    s.options.numInputBusChannels = 2;
    s.latency_(0.3); // レイテンシの設定

    // SuperDirtの起動
    ~dirt = SuperDirt(2, s);
    ~dirt.loadSoundFiles; // サウンドファイルのロード
    s.sync; // サウンドの同期
    ~dirt.start(57120, [0, 0]); // SuperDirtの開始
};

// SuperDirtを開始する
SuperDirt.start;

