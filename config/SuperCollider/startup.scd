include("SuperDirt")
SuperDirt.start(
s.options.sampleRate = 44100;

s.options.numBuffers = 1024 * 128;

s.options.memSize = 8192 * 32;

s.options.numWireBufs = 64;

s.options.maxNodes = 1024 * 32;

s.options.numOutputBusChannels = 2;

s.options.numInputBusChannels = 2;

s.latency_(0.3);
// 8. lateメッセージが出る場合は増やす。

s.waitForBoot {
 ~dirt = SuperDirt(2, s);

 ~dirt.loadSoundFiles;

 s.sync;

 ~dirt.start(57120, [0, 0]);
}
)
