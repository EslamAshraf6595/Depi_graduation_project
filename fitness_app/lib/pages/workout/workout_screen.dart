import 'package:fitness_app/pages/workout/edit_value_dialog.dart';
import 'package:flutter/material.dart';

// Define the gradient
const orangeGradient = LinearGradient(
  colors: [Color(0xFFFFA05C), Color(0xFFF06500)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

class WorkoutScreen extends StatelessWidget {
  // State
  final int reps;
  final int sets;
  final int completedSets;
  final bool isPlaying;
  final int currentTime;
  final bool isFavorite;
  final int weight;
  final int restTime;

  // Callbacks
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        const SizedBox(height: 24), // Space for the real status bar
        _TopBar(onSummary: onSummary),
        const SizedBox(height: 16),
        _ExerciseCard(
          reps: reps,
          completedSets: completedSets,
          totalSets: sets,
          weight: weight,
          isFavorite: isFavorite,
          onFavoriteClick: () => onIsFavoriteChange(!isFavorite),
          onWeightClick: () => _showEditWeightDialog(context),
        ),
        const SizedBox(height: 16),
        _WorkoutProgressBar(
          currentTime: currentTime,
          totalTime: 1800, // 30:00
        ),
        const SizedBox(height: 16),
        _RestTimer(
          seconds: restTime,
          onClick: () => _showEditRestDialog(context),
        ),
        const SizedBox(height: 16),
        _PlaybackControls(
          isPlaying: isPlaying,
          onPlayPause: () => onIsPlayingChange(!isPlaying),
          onRewind: () => onCurrentTimeChange((currentTime - 10).clamp(0, 1800)),
          onForward: () => onCurrentTimeChange((currentTime + 10).clamp(0, 1800)),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CounterControl(
              label: "Reps:",
              value: reps,
              onDecrease: () => { if (reps > 1) onRepsChange(reps - 1) },
              onIncrease: () => onRepsChange(reps + 1),
            ),
            _CounterControl(
              label: "Sets:",
              value: sets,
              onDecrease: () => { if (sets > 1) onSetsChange(sets - 1) },
              onIncrease: () => onSetsChange(sets + 1),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _NextWorkoutCard(onClick: onSummary),
      ],
    );
  }
}

// All helper widgets below...

class _TopBar extends StatelessWidget {
  final VoidCallback onSummary;
  const _TopBar({required this.onSummary});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            // This now safely pops back to your HomeScreen
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        const Text(
          "Workout",
          style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 18),
        ),
        IconButton(
          onPressed: onSummary,
          icon: const Icon(Icons.list, color: Color(0xFFD4D4D8)),
        ),
      ],
    );
  }
}

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
      height: 235,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF32383E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.access_time, color: Color(0xFFA1A1AA), size: 20),
              const Text(
                "Pushups",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              IconButton(
                onPressed: onFavoriteClick,
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? const Color(0xFFFFA05C) : Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "Reps: $reps",
            style: const TextStyle(color: Colors.white, fontSize: 31),
          ),
          Column(
            children: [
              const Text(
                "Completed Sets:",
                style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 14),
              ),
              Text(
                "$completedSets/$totalSets",
                style: const TextStyle(color: Color(0xFFA1A1AA), fontSize: 20),
              ),
            ],
          ),
          OutlinedButton(
            onPressed: onWeightClick,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFFFA05C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              side: const BorderSide(color: Color(0xFFFFA05C), width: 1),
            ),
            child: Text(
              "Weight: ${weight}lbs",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkoutProgressBar extends StatelessWidget {
  final int currentTime;
  final int totalTime;
  const _WorkoutProgressBar({required this.currentTime, required this.totalTime});

  @override
  Widget build(BuildContext context) {
    final double progress = (currentTime / totalTime).clamp(0.0, 1.0);
    final String minutes = (currentTime ~/ 60).toString();
    final String seconds = (currentTime % 60).toString().padLeft(2, '0');
    final String totalMinutes = (totalTime ~/ 60).toString();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final double dotOffset = (maxWidth - 15).clamp(0.0, double.infinity) * progress;

        return Column(
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: maxWidth,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3F3F46),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  width: maxWidth * progress,
                  height: 6,
                  decoration: BoxDecoration(
                    gradient: orangeGradient,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: dotOffset),
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                      gradient: orangeGradient,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$minutes:$seconds",
                  style: const TextStyle(color: Color(0xFFA1A1AA), fontSize: 14),
                ),
                Text(
                  "$totalMinutes:00",
                  style: const TextStyle(color: Color(0xFFA1A1AA), fontSize: 14),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _RestTimer extends StatelessWidget {
  final int seconds;
  final VoidCallback onClick;
  const _RestTimer({required this.seconds, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF471E00),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Rest: $seconds seconds",
              style: const TextStyle(color: Color(0xFFFFA05C), fontSize: 16),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.edit, color: Color(0xFFFFA05C), size: 15),
          ],
        ),
      ),
    );
  }
}

class _PlaybackControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onRewind;
  final VoidCallback onForward;

  const _PlaybackControls({
    required this.isPlaying,
    required this.onPlayPause,
    required this.onRewind,
    required this.onForward,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onRewind,
          icon: const Icon(Icons.fast_rewind, color: Color(0xFFA1A1AA), size: 24),
        ),
        const SizedBox(width: 24),
        FloatingActionButton(
          onPressed: onPlayPause,
          backgroundColor: const Color(0xFF18181B),
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: const Color(0xFFFFA05C),
            size: 28,
          ),
        ),
        const SizedBox(width: 24),
        IconButton(
          onPressed: onForward,
          icon: const Icon(Icons.fast_forward, color: Color(0xFFA1A1AA), size: 24),
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
        Text(
          label,
          style: const TextStyle(color: Color(0xFFA1A1AA), fontSize: 14),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            IconButton(
              onPressed: onDecrease,
              icon: const Icon(Icons.remove, color: Color(0xFFFFA05C), size: 12),
            ),
            Text(
              value.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            IconButton(
              onPressed: onIncrease,
              icon: const Icon(Icons.add, color: Color(0xFFFFA05C), size: 12),
            ),
          ],
        ),
      ],
    );
  }
}

class _NextWorkoutCard extends StatelessWidget {
  final VoidCallback onClick;
  const _NextWorkoutCard({required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF161512).withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 86,
          padding: const EdgeInsets.all(8),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Push ups",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      InfoItem(label: "Reps:", value: "115"),
                      SizedBox(width: 16),
                      InfoItem(label: "Sets:", value: "15"),
                      SizedBox(width: 16),
                      InfoItem(label: "Weight:", value: "150"),
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward, color: Color(0xFFFFA05C), size: 20),
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
  const InfoItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFFA1A1AA), fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}