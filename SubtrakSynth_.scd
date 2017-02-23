(
s.waitForBoot{

Server.default.makeGui;
	s.recSampleFormat = "int24";
})

SynthDef("trigsynth", {
	arg pitch = 65, sin1amp=0.12, sin2amp=0.12, saw1amp=0.12, saw2amp=0.12, tri1amp=0.12,tri2amp=0.12, sqr1amp=0.12, sqr2amp=0.12, sin1tune=0.0, sin2tune=0.0, saw1tune=0.0, saw2tune=0.0, tri1tune=0.0, tri2tune=0.0, sqr1tune=0.0, sqr2tune=0.0, atk=0.1, sus=0.2, rel=0.1, lvl=0.6, crv=1, trig=1 ;
	var synth, sin1, sin2, saw1, saw2, tri1, tri2, sqr1, sqr2, env;
	env = EnvGen.ar (Env.linen(attackTime:atk, sustainTime:sus, releaseTime:rel, level:lvl, curve:crv),doneAction:0, gate: trig );
	sin1 = SinOsc.ar ((pitch+sin1tune).midicps, phase:1.0.rand);
	sin2 = SinOsc.ar ((pitch+sin2tune).midicps, phase:1.0.rand);
	saw1 = LFSaw.ar((pitch+saw1tune).midicps  , iphase:1.0.rand);
	saw2 = LFSaw.ar ((pitch+saw2tune).midicps, iphase:1.0.rand);
	tri1 = LFTri.ar ((pitch+tri1tune).midicps, iphase:1.0.rand);
	tri2 = LFTri.ar ((pitch+tri2tune).midicps, iphase:1.0.rand);
	sqr1 = Pulse.ar ((pitch+sqr1tune).midicps);
	sqr2 = Pulse.ar ((pitch+sqr2tune).midicps);
	synth = Mix.ar( [sin1*sin1amp, saw1*saw1amp ,tri1*tri1amp, sqr1*sqr1amp, sin2*sin2amp, saw2*saw2amp ,tri2*tri2amp, sqr1*sqr2amp] );
	Out.ar(0, synth*env);
}).add;)

~synth1 = Synth(\trigsynth);
~synth1.set(\trig, 0);
~synth1.set(\trig, 1);

~synth2 = Synth( \trigsynth, [\pitch, 59, \sin1amp, 0, \sin2amp, 0, \tri1amp, 0, \tri2amp, 0, \sqr1amp, 0, \sqr2amp, 0, \saw1amp, 0.5, \saw2amp, 0.5, \saw2tune, 12, \atk, 0.02, \sus, 0.7 ] );

~synth2.set(\trig, 0);
~synth2.set(\trig, 1, \pitch, 23, \saw1tune, 2);
~synth2.set(\trig, 0);
~synth2.set(\trig, 1, \pitch, 63, \saw1tune, 1);
~synth2.set(\trig, 0);
~synth2.set(\trig, 1, \pitch, 33, \sawtune, -10, \atk, 0.5, \rel, 0.3, \sus,3.15);



//SYNTHESIS RECIPIES

//arg pitch = 65, sin1amp=0.12, sin2amp=0.12, saw1amp=0.12, saw2amp=0.12, tri1amp=0.12,tri2amp=0.12, sqr1amp=0.12, sqr2amp=0.12, sin1tune=0.0, sin2tune=0.0, saw1tune=0.0, saw2tune=0.0, tri1tune=0.0, tri2tune=0.0, sqr1tune=0.0, sqr2tune=0.0, atk=0.1, sus=0.2, rel=0.1, lvl=0.6, crv=1, trig=1

//RECIPIE UNO
~sr1 = Synth(\trigsynth);
~sr1.set(\trig, 1);
~sr1.set(\trig, 0);
//v1
~sr1.set(\pitch, 60, \sin1amp, 0, \sin2amp, 0, \saw1amp, 1, \saw2amp, 0, \tri1amp, 0, \tri2amp, 0, \sqr1amp, 0, \sqr2amp, 0, \sin1tune, 0, \sin2tune, 0, \saw1tune, 0, \saw2tune, 0, \tri1tune, 0, \tri2tune, 0, \sqr1tune, 0, \sqr2tune, 0, \atk, 0.1, \sus, 0.1, \rel, 0.2, \lvl, 0.1, \crv, -2, \trig, 1);
//v2 saw both
~sr1.set(\pitch, 60, \sin1amp, 0, \sin2amp, 0, \saw1amp, 0.5, \saw2amp, 0.5, \tri1amp, 0, \tri2amp, 0, \sqr1amp, 0, \sqr2amp, 0, \sin1tune, 0, \sin2tune, 0, \saw1tune, 3, \saw2tune, -3, \tri1tune, 0, \tri2tune, 0, \sqr1tune, 0, \sqr2tune, 0, \atk, 0.1, \sus, 0.1, \rel, 0.2, \lvl, 0.1, \crv, -2, \trig, 1);
//v3 Sine&2saw
~sr1.set(\pitch, 60, \sin1amp, 0.3333, \sin2amp, 0, \saw1amp, 0.3333, \saw2amp, 0.3333, \tri1amp, 0, \tri2amp, 0, \sqr1amp, 0, \sqr2amp, 0, \sin1tune, 7, \sin2tune, 0, \saw1tune, 3, \saw2tune, -3, \tri1tune, 0, \tri2tune, 0, \sqr1tune, 0, \sqr2tune, 0, \atk, 0.1, \sus, 0.1, \rel, 0.2, \lvl, 0.1, \crv, -2, \trig, 1);
// v4 sin 2 saw chord
(
~sr1 = Synth(\trigsynth);
~sr2 = Synth(\trigsynth);
~sr3 = Synth(\trigsynth);
)
(
~sr1.set(\trig, 0);
~sr2.set(\trig, 0);
~sr3.set(\trig, 0);
)
(
~sr1.set(\pitch, 60, \sin1amp, 0.3333, \sin2amp, 0, \saw1amp, 0.3333, \saw2amp, 0.3333, \tri1amp, 0, \tri2amp, 0, \sqr1amp, 0, \sqr2amp, 0, \sin1tune, 7, \sin2tune, 0, \saw1tune, 3, \saw2tune, -3, \tri1tune, 0, \tri2tune, 0, \sqr1tune, 0, \sqr2tune, 0, \atk, 0.1, \sus, 1.2, \rel, 0.2, \lvl, 1.0, \crv, 2, \trig, 1);
~sr2.set(\pitch, 63, \sin1amp, 0.3333, \sin2amp, 0, \saw1amp, 0.3333, \saw2amp, 0.3333, \tri1amp, 0, \tri2amp, 0, \sqr1amp, 0, \sqr2amp, 0, \sin1tune, 7, \sin2tune, 0, \saw1tune, 3, \saw2tune, -3, \tri1tune, 0, \tri2tune, 0, \sqr1tune, 0, \sqr2tune, 0, \atk, 0.1, \sus, 1.2, \rel, 0.2, \lvl, 1.0, \crv, 2, \trig, 1);
~sr3.set(\pitch, 67, \sin1amp, 0.3333, \sin2amp, 0, \saw1amp, 0.3333, \saw2amp, 0.3333, \tri1amp, 0, \tri2amp, 0, \sqr1amp, 0, \sqr2amp, 0, \sin1tune, 7, \sin2tune, 0, \saw1tune, 3, \saw2tune, -3, \tri1tune, 0, \tri2tune, 0, \sqr1tune, 0, \sqr2tune, 0, \atk, 0.1, \sus, 1.2, \rel, 0.2, \lvl, 1.0, \crv, 2, \trig, 1);
)

