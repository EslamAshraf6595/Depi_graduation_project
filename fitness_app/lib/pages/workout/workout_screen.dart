import 'package:fitness_app/pages/workout/edit_value_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Define the gradient
const orangeGradient = LinearGradient(
  colors: [Color(0xFFFFA05C), Color(0xFFF06500)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

class WorkoutScreen extends StatelessWidget {
  final int reps;
  final int sets;
  final int completedSets;
  final bool isPlaying;
  final int currentTime;
  final bool isFavorite;
  final int weight;
  final int restTime;

  final ValueChanged<int> onRepsChange;
  final ValueChanged<int> onSetsChange;
  final ValueChanged<int> onCompletedSetsChange;
  final ValueChanged<bool> onIsPlayingChange;
  final ValueChanged<int> onCurrentTimeChange;
  final ValueChanged<bool> onIsFavoriteChange;
  final ValueChanged<int> onWeightChange;
  final ValueChanged<int> onRestTimeChange;
  final VoidCallback onSummary;

  const WorkoutScreen({
    super.key,
    required this.reps,
    required this.sets,
    required this.completedSets,
    required this.isPlaying,
    required this.currentTime,
    required this.isFavorite,
    required this.weight,
    required this.restTime,
    required this.onRepsChange,
    required this.onSetsChange,
    required this.onCompletedSetsChange,
    required this.onIsPlayingChange,
    required this.onCurrentTimeChange,
    required this.onIsFavoriteChange,
    required this.onWeightChange,
    required this.onRestTimeChange,
    required this.onSummary,
  });

  void _showEditWeightDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return EditValueDialog(
          title: "Edit Weight",
          initialValue: weight.toString(),
          onSave: (newValue) {
            onWeightChange(int.tryParse(newValue) ?? weight);
          },
        );
      },
    );
  }

  void _showEditRestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return EditValueDialog(
          title: "Edit Rest Time (seconds)",
          initialValue: restTime.toString(),
          onSave: (newValue) {
            onRestTimeChange(int.tryParse(newValue) ?? restTime);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
      children: [
        SizedBox(height: 24.h),
        _TopBar(onSummary: onSummary),
        SizedBox(height: 16.h),
        _ExerciseCard(
          reps: reps,
          completedSets: completedSets,
          totalSets: sets,
          weight: weight,
          isFavorite: isFavorite,
          onFavoriteClick: () => onIsFavoriteChange(!isFavorite),
          onWeightClick: () => _showEditWeightDialog(context),
        ),
        SizedBox(height: 16.h),
        _WorkoutProgressBar(
          currentTime: currentTime,
          totalTime: 1800,
        ),
        SizedBox(height: 16.h),
        _RestTimer(
          seconds: restTime,
          onClick: () => _showEditRestDialog(context),
        ),
        SizedBox(height: 16.h),
        _PlaybackControls(
          isPlaying: isPlaying,
          onPlayPause: () => onIsPlayingChange(!isPlaying),
          onRewind: () =>
              onCurrentTimeChange((currentTime - 10).clamp(0, 1800)),
          onForward: () =>
              onCurrentTimeChange((currentTime + 10).clamp(0, 1800)),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CounterControl(
              label: "Reps:",
              value: reps,
              onDecrease: () => {if (reps > 1) onRepsChange(reps - 1)},
              onIncrease: () => onRepsChange(reps + 1),
            ),
            _CounterControl(
              label: "Sets:",
              value: sets,
              onDecrease: () => {if (sets > 1) onSetsChange(sets - 1)},
              onIncrease: () => onSetsChange(sets + 1),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _NextWorkoutCard(onClick: onSummary),
      ],
    );
  }
}

// ---------------- TOP BAR ----------------

class _TopBar extends StatelessWidget {
  final VoidCallback onSummary;
  const _TopBar({required this.onSummary});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
        ),
        Text(
          "Workout",
          style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 18.sp),
        ),
        IconButton(
          onPressed: onSummary,
          icon: Icon(Icons.list, color: Color(0xFFD4D4D8), size: 22.sp),
        ),
      ],
    );
  }
}

// ---------------- CARD ----------------

class _ExerciseCard extends StatelessWidget {
  final int reps;
  final int completedSets;
  final int totalSets;
  final int weight;
  final bool isFavorite;
  final VoidCallback onFavoriteClick;
  final VoidCallback onWeightClick;

  const _ExerciseCard({
    required this.reps,
    required this.completedSets,
    required this.totalSets,
    required this.weight,
    required this.isFavorite,
    required this.onFavoriteClick,
    required this.onWeightClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Color(0xFF32383E),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.access_time, color: Color(0xFFA1A1AA), size: 20.sp),
              Text("Pushups",
                  style: TextStyle(color: Colors.white, fontSize: 24.sp)),
              IconButton(
                onPressed: onFavoriteClick,
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Color(0xFFFFA05C) : Colors.white,
                  size: 20.sp,
                ),
              )
            ],
          ),
          Text(
            "Reps: $reps",
            style: TextStyle(color: Colors.white, fontSize: 31.sp),
          ),
          Column(
            children: [
              Text("Completed Sets:",
                  style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 14.sp)),
              Text(
                "$completedSets/$totalSets",
                style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 20.sp),
              ),
            ],
          ),
          OutlinedButton(
            onPressed: onWeightClick,
            style: OutlinedButton.styleFrom(
              foregroundColor: Color(0xFFFFA05C),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r)),
              side: BorderSide(color: Color(0xFFFFA05C), width: 1.w),
            ),
            child: Text(
              "Weight: ${weight}lbs",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- PROGRESS BAR ----------------

class _WorkoutProgressBar extends StatelessWidget {
  final int currentTime;
  final int totalTime;

  const _WorkoutProgressBar(
      {required this.currentTime, required this.totalTime});

  @override
  Widget build(BuildContext context) {
    final double progress = (currentTime / totalTime).clamp(0.0, 1.0);

    final String minutes = (currentTime ~/ 60).toString();
    final String seconds = (currentTime % 60).toString().padLeft(2, '0');
    final String totalMinutes = (totalTime ~/ 60).toString();

    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      double dotOffset =
          (maxWidth - 15.w).clamp(0.0, double.infinity) * progress;

      return Column(
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                width: maxWidth,
                height: 6.h,
                decoration: BoxDecoration(
                  color: Color(0xFF3F3F46),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              Container(
                width: maxWidth * progress,
                height: 6.h,
                decoration: BoxDecoration(
                  gradient: orangeGradient,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: dotOffset),
                child: Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    gradient: orangeGradient,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$minutes:$seconds",
                  style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 14.sp)),
              Text("$totalMinutes:00",
                  style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 14.sp)),
            ],
          )
        ],
      );
    });
  }
}

// ---------------- REST TIMER ----------------

class _RestTimer extends StatelessWidget {
  final int seconds;
  final VoidCallback onClick;

  const _RestTimer({required this.seconds, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Color(0xFF471E00),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Rest: $seconds seconds",
              style: TextStyle(color: Color(0xFFFFA05C), fontSize: 16.sp),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.edit, color: Color(0xFFFFA05C), size: 15.sp),
          ],
        ),
      ),
    );
  }
}

// ---------------- CONTROLS ----------------

class _PlaybackControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onRewind;
  final VoidCallback onForward;

  const _PlaybackControls(
      {required this.isPlaying,
      required this.onPlayPause,
      required this.onRewind,
      required this.onForward});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onRewind,
          icon: Icon(Icons.fast_rewind, color: Color(0xFFA1A1AA), size: 24.sp),
        ),
        SizedBox(width: 24.w),
        FloatingActionButton(
          onPressed: onPlayPause,
          backgroundColor: Color(0xFF18181B),
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Color(0xFFFFA05C),
            size: 28.sp,
          ),
        ),
        SizedBox(width: 24.w),
        IconButton(
          onPressed: onForward,
          icon: Icon(Icons.fast_forward, color: Color(0xFFA1A1AA), size: 24.sp),
        ),
      ],
    );
  }
}

class _CounterControl extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const _CounterControl({
    required this.label,
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 14.sp)),
        SizedBox(height: 4.h),
        Row(
          children: [
            IconButton(
              onPressed: onDecrease,
              icon: Icon(Icons.remove, color: Color(0xFFFFA05C), size: 12.sp),
            ),
            Text(
              value.toString(),
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
            IconButton(
              onPressed: onIncrease,
              icon: Icon(Icons.add, color: Color(0xFFFFA05C), size: 12.sp),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------- NEXT WORKOUT ----------------

class _NextWorkoutCard extends StatelessWidget {
  final VoidCallback onClick;
  const _NextWorkoutCard({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF161512).withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 95.h,
          padding: EdgeInsets.all(8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Push ups",
                      style: TextStyle(color: Colors.white, fontSize: 24.sp)),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      InfoItem(label: "Reps:", value: "115"),
                      SizedBox(width: 16.w),
                      InfoItem(label: "Sets:", value: "15"),
                      SizedBox(width: 16.w),
                      InfoItem(label: "Weight:", value: "150"),
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward, color: Color(0xFFFFA05C), size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final String label;
  final String value;
  const InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 14.sp)),
        Text(value, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
      ],
    );
  }
}
