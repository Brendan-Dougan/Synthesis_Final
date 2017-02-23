(
s.waitForBoot{

Server.default.makeGui;

~path = "/Users/brendandougan/Desktop/granularsynthesis/";

//Buffers with Grain Envelopes
s.sendMsg(\b_allocRead, 30, ~path++"/grainEnv/gEnv_gauss.aif");
s.sendMsg(\b_allocRead, 31, ~path++"/grainEnv/gEnv_tri.aif");
s.sendMsg(\b_allocRead, 32, ~path++"/grainEnv/gEnv_expodec.aif");
s.sendMsg(\b_allocRead, 33, ~path++"/grainEnv/gEnv_rexpodec.aif");

//Buffers with Source Sound File
	~b2 = Buffer.read(s, ~path++"/sources/crisps.aif");
	~b1 = Buffer.read(s, ~path++"/sources/ss.aif");

SynthDef(\granny, {
	arg gate = 1, amp = 1, sourcebuf, envbufnum=0, ratemin=2, ratemax=50, durmin=0.05, durmax=0.1, pitchmin=0.5, pitchmax=3.0, posmin=0.0, posmax=1.0;
	var mainenv, freqdev, granulator, rate, ratechgrate, dur, pitch, pos;
	ratechgrate = ((ratemax-ratemin)/2.0) + ratemin;
	rate = Impulse.kr( TIRand.kr(ratemin, ratemax, Impulse.kr(ratechgrate)) );
	dur = LFNoise1.kr.range(durmin, durmax);
	pitch = LFNoise1.kr.range(pitchmin, pitchmax);
	pos = LFNoise1.kr.range(posmin, posmax);
	mainenv = EnvGen.kr( Env.asr(releaseTime:0.1), gate, doneAction:2 );
	granulator = GrainBuf.ar(1, rate, dur, sourcebuf, pitch, pos, 2, 0, envbufnum+30);
	Out.ar(0, granulator * mainenv * amp);
}).add;

}

)

x = Synth(\granny, [\sourcebuf, ~b1.bufnum, \envbufnum, 0]);
//Change Rate
x.set(\ratemin, 1.6, \ratemax, 14.2);
x.set(\ratemin, 1.6, \ratemax, 5.2);
x.set(\ratemin, 13, \ratemax, 13); //For steady rate set ratemin and ratemax to the same value
x.set(\ratemin, 3, \ratemax, 3); //For steady rate set ratemin and ratemax to the same value
//Change Grain Duration
x.set(\durmin, 0.08, \durmax, 0.3);
x.set(\durmin, 0.07, \durmax, 0.07); //for equal grain length set min/max to same
x.set(\durmin, 0.4, \durmax, 0.4); //for equal grain length set min/max to same
x.set(\durmin, 0.05, \durmax, 1.3);
//Change Grain Pitch
x.set(\pitchmin, 0.1, \pitchmax, 0.3);
x.set(\pitchmin, 3.1, \pitchmax, 8.3);
x.set(\pitchmin, 0.1, \pitchmax, 8.3);
x.set(\pitchmin, 1, \pitchmax, 1);
//Change position of sound file from which to read the grain (values from 0-1)
x.set(\posmin, 0.1, \posmax, 0.3);
x.set(\posmin, 0.9, \posmax, 0.9); //for grains of same content set min/max to same
x.set(\posmin, 0.5, \posmax, 0.8);
x.set(\posmin, 0.0, \posmax, 1.0);
x.set(\posmin, 0.45, \posmax, 0.45);

//Change Grain Envelope (between 0-3)
x.set(\envbufnum, 3);
x.set(\envbufnum, 2);
x.set(\envbufnum, 1);
x.set(\envbufnum, 0);

//Change Source
x.set(\sourcebuf, ~b2.bufnum);
x.free
