(
s.waitForBoot{

Server.default.makeGui;
	s.recSampleFormat = "int24";
})

// Additive

(
SynthDef('additivesynth', {
	arg freqs = #[120, 220, 640, 890, 1100, 1200, 1400, 1679, 1834, 2456], amps = #[0.6, 0.3, 0.15, 0.075, 0.0375, 0.01875, 0.009375, 0.0046875, 0.00234375, 0.001171875], phases=#[1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

    Out.ar(0, DynKlang.ar(`[freqs, amps, phases]))
}).add
)

a = Synth(\additivesynth);
a.set(\freqs, [121, 221, 270, 235, 240, 257, 360, 387, 380, 448] );
a.set(\amps, [0.1, 0.1, 0.05, 0.075, 0.0375, 0.00275, 0.020375, 0.2066875, 0.00334375, 0.503171875] );

(2000.cpsmidi + 1).midicps;
