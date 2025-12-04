import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutScreen extends StatefulWidget {
  final int reps;
  final int sets;
  final int completedSets;
  final bool isPlaying;
  final int currentTime;
  final int weight;
  final int restTime;
  bool isFavorite = false;

  // AUDIO
  final Duration audioDuration;
  final Duration audioPosition;
  final VoidCallback onTogglePlay;
  final ValueChanged<Duration> onSeekAudio;

  final ValueChanged<int> onRepsChange;
  final ValueChanged<int> onSetsChange;
  final ValueChanged<int> onWeightIncrease;
  final ValueChanged<int> onWeightDecrease;
  final ValueChanged<int> onRestChange;

  final ValueChanged<int> onCurrentTimeChange;
  final VoidCallback onSummary;

  WorkoutScreen({
    super.key,
    required this.reps,
    required this.sets,
    required this.completedSets,
    required this.isPlaying,
    required this.currentTime,
    required this.weight,
    required this.restTime,
    required this.isFavorite,
    required this.audioDuration,
    required this.audioPosition,
    required this.onTogglePlay,
    required this.onSeekAudio,
    required this.onRepsChange,
    required this.onSetsChange,
    required this.onWeightIncrease,
    required this.onWeightDecrease,
    required this.onRestChange,
    required this.onCurrentTimeChange,
    required this.onSummary,
  });

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
      children: [
        // HEADER
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            Text("Workout",
                style: TextStyle(color: Colors.white, fontSize: 18.sp)),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.isFavorite = !widget.isFavorite;
                });
              },
              icon: Icon(Icons.star_border,
                  color: widget.isFavorite ? Colors.orange : Colors.white),
            )
          ],
        ),

        SizedBox(height: 20.h),

        // MAIN CARD FOR REPS / SETS / WEIGHT / REST
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF32383E),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              // REPS
              _rowControl(
                label: "Reps",
                value: widget.reps,
                onDecrease: () =>
                    widget.onRepsChange(widget.reps > 0 ? widget.reps - 1 : 0),
              ),

              SizedBox(height: 15.h),

              // SETS
              _rowControl(
                label: "Sets",
                value: widget.sets,
                onDecrease: () =>
                    widget.onSetsChange(widget.sets > 0 ? widget.sets - 1 : 0),
              ),

              SizedBox(height: 15.h),

              // REST
              _rowControl(
                label: "Rest (sec)",
                value: widget.restTime,
                onDecrease: () => widget.onRestChange(
                    widget.restTime > 0 ? widget.restTime - 1 : 0),
              ),

              SizedBox(height: 15.h),

              // WEIGHT
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Weight: ${widget.weight} kg",
                      style: TextStyle(color: Colors.white, fontSize: 22.sp)),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            widget.onWeightDecrease(widget.weight - 1),
                        icon: const Icon(Icons.remove, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () =>
                            widget.onWeightIncrease(widget.weight + 1),
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        // TIMER + AUDIO
        Column(
          children: [
            Text("Time Left: ${widget.currentTime} s",
                style: const TextStyle(color: Colors.white)),
            IconButton(
              onPressed: widget.onTogglePlay,
              icon: Icon(
                widget.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 32.sp,
              ),
            ),
            Slider(
              min: 0,
              max: widget.audioDuration.inSeconds.toDouble(),
              value: widget.audioPosition.inSeconds
                  .clamp(0, widget.audioDuration.inSeconds)
                  .toDouble(),
              onChanged: (value) =>
                  widget.onSeekAudio(Duration(seconds: value.toInt())),
              activeColor: Colors.orange,
              inactiveColor: Colors.white24,
            ),
          ],
        ),

        SizedBox(height: 20.h),

        ElevatedButton(
          onPressed: widget.onSummary,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              minimumSize: Size(double.infinity, 55.h)),
          child: const Text("Finish Workout"),
        )
      ],
    );
  }

  Widget _rowControl(
      {required String label,
      required int value,
      required VoidCallback onDecrease}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$label: $value",
            style: TextStyle(color: Colors.white, fontSize: 22.sp)),
        IconButton(
          onPressed: onDecrease,
          icon: const Icon(Icons.remove, color: Colors.white),
        )
      ],
    );
  }
}
