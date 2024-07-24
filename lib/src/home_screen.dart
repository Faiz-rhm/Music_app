import 'package:audio_app/src/audio_load_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
import 'package:just_audio/just_audio.dart';

import 'app_colors.dart';
import 'widgets/button_widget.dart';
import 'widgets/play_widget.dart';
import 'widgets/title_widget.dart';
import 'widgets/top_widget.dart';
import 'widgets/volume_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final _player = AudioPlayer();
  Duration? maxDuration;
  Duration? elapsedDuration;
  List<double>? samples;
  double sliderValue = 0;
  int totalSamples = 256;
  late WaveformCustomizations? waveformCustomizations;

  Future<void> parseData() async {
    final json = await rootBundle.loadString('assets/audio/audio_data.json');
    Map<String, dynamic> audioDataMap = {
      "json": json,
      "totalSamples": totalSamples,
    };

    final samplesData = await compute(loadparseJson, audioDataMap);

    await Future.delayed(const Duration(milliseconds: 200));

    maxDuration = Duration(milliseconds: _player.duration!.inMilliseconds);

    setState(() {
      samples = samplesData["samples"];
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    totalSamples = 1000;
    samples = [];
    maxDuration = const Duration(milliseconds: 1000);
    elapsedDuration = const Duration();

    _player.positionStream.listen((Duration timeElapsed) {
      setState(() {
        elapsedDuration = timeElapsed;
      });
    });

    _player.playbackEventStream.listen((event) {},
      onError: (Object e, StackTrace stackTrace) {
    });

    try {
      await _player.setAudioSource(AudioSource.asset('assets/audio/Dr.mp3'));
    } on PlayerException {
      print("Error loading audio source:");
    }

    parseData();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    waveformCustomizations = WaveformCustomizations(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.85,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: AppColors.backgroundColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const TopWidget(),

          const ButtonWidget(),

          const TitleWidget(),

          Container(
            height: size.height * 0.4,
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.waveBackgroundColor,
              borderRadius: BorderRadius.circular(16)
            ),
            child: CurvedPolgonWaveformExample(
              maxDuration: maxDuration!,
              elapsedDuration: elapsedDuration!,
              samples: samples!,
              waveformCustomizations: waveformCustomizations!,
            ),
          ),

          PlayWidget(_player),

          VolumeWidget(_player),

          const SizedBox(height: 16,),
        ],
      ),
    );
  }
}

class CurvedPolgonWaveformExample extends StatelessWidget {
  const CurvedPolgonWaveformExample({
    super.key,
    required this.maxDuration,
    required this.elapsedDuration,
    required this.samples,
    required this.waveformCustomizations,
  });

  final Duration maxDuration;
  final Duration elapsedDuration;
  final List<double> samples;
  final WaveformCustomizations waveformCustomizations;

  @override
  Widget build(BuildContext context) {
    return CurvedPolygonWaveform(
      maxDuration: maxDuration,
      elapsedDuration: elapsedDuration,
      samples: samples,
      height: waveformCustomizations.height,
      width: waveformCustomizations.width,
      inactiveColor: AppColors.waveInActiveColor,
      invert: waveformCustomizations.invert,
      absolute: waveformCustomizations.absolute,
      activeColor: AppColors.waveActiveColor,
      showActiveWaveform: waveformCustomizations.showActiveWaveform,
      strokeWidth: waveformCustomizations.borderWidth,
      style: waveformCustomizations.style,
    );
  }
}

class WaveformCustomizations {
  WaveformCustomizations({
    required this.height,
    required this.width,
    this.activeColor = Colors.red,
    this.inactiveColor = Colors.blue,
    this.activeGradient,
    this.inactiveGradient,
    this.style = PaintingStyle.fill,
    this.showActiveWaveform = true,
    this.absolute = false,
    this.invert = false,
    this.borderWidth = 1.0,
    this.activeBorderColor = Colors.white,
    this.inactiveBorderColor = Colors.white,
    this.isRoundedRectangle = false,
    this.isCentered = true,
  });

  double height;
  double width;
  Color inactiveColor;
  Gradient? inactiveGradient;
  bool invert;
  bool absolute;
  Color activeColor;
  Gradient? activeGradient;
  bool showActiveWaveform;
  PaintingStyle style;
  double borderWidth;
  Color activeBorderColor;
  Color inactiveBorderColor;
  bool isRoundedRectangle;
  bool isCentered;
}
