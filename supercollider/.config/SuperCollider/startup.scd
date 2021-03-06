(
Server.default.options.maxLogins = 2;
Server.default.options.bindAddress = "0.0.0.0";
Server.default.options.zeroConf = true;
CmdPeriod.freeRemote = true;

~synthDefsFile = Platform.userHomeDir +/+ ".synthdefs.scd";

Server.default.reboot { // server options are only updated on reboot
	Server.default.options.numWireBufs = 2048;
	Server.default.options.numBuffers = 1024.pow(2);
	Server.default.options.memSize = 1024.pow(2); // kB
	Server.default.options.maxNodes = 32 * 1024;

	Server.default.waitForBoot {
		// Load synthdefs
		if (File.exists(~synthDefsFile)) {
			"Loading SynthDefs file...".postln;
			~synthDefsFile.load;
		} {
			"Unable to load SynthDef file".postln;
		};

		// Set up audio buses (and avoid allocating over the default)
		// ~audio = 16 collect: { |i| Bus.audio(numChannels: 2) };
		// Set up control buses
		// ~control = 32 collect: { |i| Bus.control };
		// Make wavetables
		//~wt = Environment.make {
		//    ~pluck = Buffer.allocConsecutive(256, Server.default, 1024, 1,
		//        { |buf, i| buf sine1Msg: 512.collect {|j| (j + 1).reciprocal.pow(i / 4 + 1) } }
		//    );
		//};

		// ~wt = (
		// 	pluck: Buffer.allocConsecutive(
		// 		numBufs: 256,
		// 		server: Server.default,
		// 		numFrames: 1024,
		// 		numChannels: 1,
		// 		completionMessage: { |buf, i| buf sine1Msg: 512.collect { |j| (j + 1).reciprocal.pow(i / 4 + 1) } },
		// 	),
		// );

		// TODO: make this a class and use SynthDef.wrap to allow additional controls
		// ~additive = { |numPartials, freqFunc, ampFunc, phaseFunc, envFunc, panFunc|
		// 	Mix.fill(numPartials) { |i|
		// 		var freq, amp, phase, env, pan, action;
		// 		i = i + 1;
		// 		action = (i <= 1).if { Done.freeSelf } { Done.none };
		// 		freq = freqFunc.(i);
		// 		amp = ampFunc.(i);
		// 		phase = phaseFunc.(i);
		// 		env = EnvGen.ar(envFunc.(i), doneAction: action) * amp;
		// 		pan = panFunc.(i);
		// 		Pan2.ar(_, pan) <> SinOsc.ar(freq, phase, env)
		// 	};
		// };

		// Show server meter, node tree, and 16 audio and control buses each
		// s.makeWindow;
		// s.meter;
		// s.plotTree;
		// Stethoscope.new(s, 16, rate: \audio);
		// Stethoscope.new(s, 16, rate: \control);
		//HelpBrowser.new;


	}

	// boot the server and start SuperDirt
	//        s.waitForBoot {
	//            ~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
	//            ~dirt.loadSoundFiles;   // load samples (path containing a wildcard can be passed in)
	//
	//            s.sync; // wait for samples to be read
	//            ~dirt.start(57120, 0 ! 2);   // start listening on port 57120, create two busses each sending audio to channel 0
	//
	//            // optional, needed for convenient access from sclang:
	//            (
	//                ~d1 = ~dirt.orbits[0]; ~d2 = ~dirt.orbits[1]; ~d3 = ~dirt.orbits[2];
	//                ~d4 = ~dirt.orbits[3]; ~d5 = ~dirt.orbits[4]; ~d6 = ~dirt.orbits[5];
	//                ~d7 = ~dirt.orbits[6]; ~d8 = ~dirt.orbits[7]; ~d9 = ~dirt.orbits[8];
	//                ~d10 = ~dirt.orbits[9]; ~d11 = ~dirt.orbits[10]; ~d12 = ~dirt.orbits[11];
	//            );
	//        };
	//
	//        s.latency = 0.3; // increase this if you get "late" messages
};
)
