(
s.waitForBoot{

Server.default.makeGui;
	s.recSampleFormat = "int24";
})


//Basic Fm Sound 1
(
SynthDef("freqmod", { arg bus = 0, freq = 440, carPartial = 1, modPartial = 1, index = 3, mul = 0.05;

	var mod;
	var car;

	mod = SinOsc.ar( freq * modPartial, 0, freq * index);

	car = SinOsc.ar( (freq * carPartial) + mod, 0, mul );

	Out.ar(bus, car)
}).add;
)


a = Synth("fm1", [\bus, 0, \freq, 240, \carPartial, 1, \modPartial, 2.4]);
a.set(\modPartial, 3, \carPartial, 3, \index, 50, \freq, 100);



b = Synth("freqmod", [\bus, 1, \freq, 242, \carPartial, 1, \modPartial, 2.401]);
b.set(\modPartial, 5.4, \carPartial, 1, \index, 17, \freq, 312);


(
a = Synth("freqmod", [\bus, 0, \freq, 141, \carPartial, 1, \modPartial, 0.09, \index, 5.0]);
a = Synth("freqmod", [\bus, 0, \freq, 141, \carPartial, 1, \modPartial, 0.9, \index, 5.0]);
a = Synth("freqmod", [\bus, 0, \freq, 141, \carPartial, 1, \modPartial, 1.9, \index, 5.0]);
)


//Fm W/Env Sound 2
(
SynthDef("fqmodenv", { arg bus = 0, freq = 440, carPartial = 1, modPartial = 1, index = 3, mul = 0.05, emAtk=0.1, emDecay=0.1, emSus=1, emRel=0.1, emCrv=0, gate=1;

	var mod, car, envMain;

	envMain = EnvGen.ar( Env.adsr( emAtk, emDecay, emSus, emRel, curve:emCrv ), gate);

	mod = SinOsc.ar( freq * modPartial, 0, freq * index);

	car = SinOsc.ar( (freq * carPartial) + mod, 0, mul );

	Out.ar(bus, car*envMain)
}).add;
)


e = Synth("fm1env", [\bus, 0, \freq, 300, \carPartial, 4.0, \modPartial, 6.8, \index, 10.0, \gate, 0, \emAtk, 0.001, \emSus, 1.0, \emRel, 24.0, \emCrv, -9]);
Routine{ 1.do{ e.set(\gate, 1); 0.01.wait; e.set(\gate, 0); } }.play;


//Fm Component
(
SynthDef("carrier", { arg inbus = 2, outbus = 0, freq = 440, carPartial = 1, index = 3, mul = 0.2;

	var mod;
	var car;
	mod = In.ar(inbus, 1);
	Out.ar(
		outbus,
		SinOsc.ar((freq * carPartial) + mod, 0, mul);
	)

}).add;

SynthDef("modulator", { arg outbus = 2, freq, modPartial = 1, index = 3;
	Out.ar(
		outbus,
		SinOsc.ar(freq * modPartial, 0, freq)
		*
		index
	)
}).add;


~fmfreq = 576;

~mL1 = Synth.head(s, "modulator", [\outbus, 2, \freq, ~fmfreq, \modPartial, 0.649, \index, 2]);
~mL2 = Synth.head(s, "modulator", [\outbus, 2, \freq, ~fmfreq, \modPartial, 1.683, \index, 2.31]);

~mR1 = Synth.head(s, "modulator", [\outbus, 4, \freq, ~fmfreq, \modPartial, 0.729, \index, 1.43]);
~mR2 = Synth.head(s, "modulator", [\outbus, 4, \freq, ~fmfreq, \modPartial, 2.19, \index, 1.76]);

~cL = Synth.tail(s, "carrier", [\inbus, 2, \outbus, 0, \freq, ~fmfreq, \carPartial, 1]);
~cR = Synth.tail(s, "carrier", [\inbus, 4, \outbus, 1, \freq, ~fmfreq, \carPartial, 0.97]);


~fmfreq = 250; ~mL1.set(\freq, ~fmfreq); ~mL2.set(\freq, ~fmfreq); ~mR1.set(\freq, ~fmfreq); ~mR2.set(\freq, ~fmfreq); ~cL.set(\freq, ~fmfreq); ~cR.set(\freq, ~fmfreq);
)

