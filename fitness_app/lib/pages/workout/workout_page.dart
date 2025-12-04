import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:fitness_app/models/exercise_model.dart';
import 'package:fitness_app/pages/home/homeScreen.dart';
import 'package:fitness_app/pages/workOut/workout_screen.dart';
import 'package:fitness_app/pages/workOut/workout_summary_screen.dart';
import 'package:fitness_app/provider/exercise_provider.dart';
import 'package:fitness_app/provider/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  final ExerciseModel exercise;
  const WorkoutPage({super.key, required this.exercise});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  late int reps;
  late int sets;
  late int restTime;
  late int weight;

  late int _currentTime;
  bool _showSummary = false;
  Timer? _timer;

  late ExerciseProvider exerciseProvider;
  late WorkoutProvider workoutProvider;

  // AUDIO
  late AudioPlayer _audioPlayer;
  Duration _audioDuration = Duration.zero;
  Duration _audioPosition = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    exerciseProvider = Provider.of<ExerciseProvider>(context, listen: false);
    workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);

    reps = widget.exercise.maxReps;
    sets = widget.exercise.maxSets;
    restTime = widget.exercise.rest;
    weight = widget.exercise.weight;

    _currentTime = int.tryParse(widget.exercise.duration ?? "0") ?? 0;

    _audioPlayer = AudioPlayer();
    _audioPlayer.setSource(AssetSource('music/music1.mp3'));

    _audioPlayer.onDurationChanged
        .listen((d) => setState(() => _audioDuration = d));
    _audioPlayer.onPositionChanged
        .listen((p) => setState(() => _audioPosition = p));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  // PLAY / PAUSE LOGIC
  void _togglePlayPause() {
    setState(() => _isPlaying = !_isPlaying);

    if (_isPlaying) {
      _audioPlayer.resume();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_currentTime > 0) {
          setState(() => _currentTime--);
        }
      });
    } else {
      _audioPlayer.pause();
      _timer?.cancel();
    }
  }

  void _saveWorkoutAndPop() {
    _timer?.cancel();
    _audioPlayer.stop();

    workoutProvider.completeExercise(widget.exercise);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  // ----------------------------
  // UPDATE EXERCISE PROGRESS
  // ----------------------------
  void _updateExerciseProgress() {
    // Calculate doneReps and doneSets
    widget.exercise.doneReps = widget.exercise.maxReps - reps;
    widget.exercise.doneSets = widget.exercise.maxSets - sets;

    // Update formAccuracy using progress getter
    widget.exercise.formAccuracy = widget.exercise.progress;

    // Notify providers
    exerciseProvider.updateExercise(widget.exercise);
    workoutProvider.calculateOverallAccuracy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showSummary
          ? WorkoutSummaryScreen(
              title: widget.exercise.title ?? "",
              reps: reps,
              sets: sets,
              durationSeconds: _currentTime,
              onBack: () => setState(() => _showSummary = false),
              onSave: () => _saveWorkoutAndPop(),
            )
          : WorkoutScreen(
              reps: reps,
              sets: sets,
              completedSets: widget.exercise.doneReps,
              isPlaying: _isPlaying,
              currentTime: _currentTime,
              weight: weight,
              restTime: restTime,
              isFavorite: widget.exercise.isFavorite,
              audioDuration: _audioDuration,
              audioPosition: _audioPosition,
              onTogglePlay: _togglePlayPause,
              onSeekAudio: (d) => _audioPlayer.seek(d),

              // -----------------------------
              // DECREMENT / INCREMENT LOGIC
              // -----------------------------
              onRepsChange: (newVal) {
                setState(() => reps = newVal);
                _updateExerciseProgress();
              },
              onSetsChange: (newVal) {
                setState(() => sets = newVal);
                _updateExerciseProgress();
              },
              onRestChange: (newVal) {
                setState(() => restTime = newVal);
                _updateExerciseProgress();
              },
              onWeightIncrease: (newVal) => setState(() => weight = newVal),
              onWeightDecrease: (newVal) => setState(() => weight = newVal),

              onCurrentTimeChange: (_) => setState(() => _currentTime--),

              onSummary: () => setState(() => _showSummary = true),
            ),
    );
  }
}
