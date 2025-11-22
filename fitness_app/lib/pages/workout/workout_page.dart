import 'dart.async';
import 'package:fitness_app/pages/workout/workout_complete_dialog.dart';
import 'package:fitness_app/pages/workout/workout_screen.dart';
import 'package:fitness_app/pages/workout/workout_summary_data.dart';
import 'package:fitness_app/pages/workout/workout_summary_screen.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  // Navigation
  String _currentScreen = 'workout';
  WorkoutSummaryData? _summaryData;

  // All workout state is "hoisted" here, so it doesn't reset!
  int _reps = 10;
  int _sets = 5;
  int _completedSets = 3;
  bool _isPlaying = false;
  int _currentTime = 479; // 7:59 (Total workout time)
  bool _isFavorite = true;
  int _weight = 150;
  int _restTime = 80;

  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel(); // Always cancel timers
    super.dispose();
  }

  void _handlePlayPause(bool play) {
    setState(() {
      _isPlaying = play;
    });
    if (_isPlaying) {
      _startTimer();
    } else {
      _timer?.cancel();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentTime > 0) {
        setState(() {
          _currentTime--;
        });
      } else {
        // Timer hit 0
        setState(() {
          _isPlaying = false;
        });
        timer.cancel();
        _showWorkoutCompleteDialog();
      }
    });
  }

  void _showWorkoutCompleteDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return WorkoutCompleteDialog(
          onSeeSummary: () {
            Navigator.of(dialogContext).pop(); // Close the dialog
            _navigateToSummary();
          },
        );
      },
    );
  }

  void _navigateToSummary() {
    setState(() {
      _summaryData = WorkoutSummaryData(
        totalReps: _reps * _completedSets,
        totalSets: _completedSets,
        totalDurationSeconds: 479 - _currentTime,
      );
      _currentScreen = 'summary';
    });
  }

  @override
  Widget build(BuildContext context) {
    // This is the container for *your* feature
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF353A40), Color(0xFF121416)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _currentScreen == 'workout'
            ? WorkoutScreen(
          reps: _reps,
          sets: _sets,
          completedSets: _completedSets,
          isPlaying: _isPlaying,
          currentTime: _currentTime,
          isFavorite: _isFavorite,
          weight: _weight,
          restTime: _restTime,

          // Pass functions to *change* the state
          onRepsChange: (val) => setState(() => _reps = val),
          onSetsChange: (val) => setState(() => _sets = val),
          onCompletedSetsChange: (val) => setState(() => _completedSets = val),
          onIsPlayingChange: _handlePlayPause,
          onCurrentTimeChange: (val) => setState(() => _currentTime = val),
          onIsFavoriteChange: (val) => setState(() => _isFavorite = val),
          onWeightChange: (val) => setState(() => _weight = val),
          onRestTimeChange: (val) => setState(() => _restTime = val),
          onSummary: _navigateToSummary,
        )
            : WorkoutSummaryScreen(
          // This `onBack` logic is now simple!
          onBack: () => setState(() => _currentScreen = 'workout'),
          summaryData: _summaryData ?? WorkoutSummaryData(totalReps: 0, totalSets: 0, totalDurationSeconds: 0),
        ),
      ),
    );
  }
}