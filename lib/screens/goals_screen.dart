import 'package:flutter/material.dart';
import 'create_exercise_screen.dart';
import 'edit_exercise_screen.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  bool isPlansTabSelected = true;

  List<Map<String, String>> _exercises = [
    {
      "title": "Push ups",
      "duration": "30 minutes",
      "reps": "115",
      "sets": "15",
      "exercise": "5",
      "target": "2000"
    },
    {
      "title": "Pull ups",
      "duration": "20 minutes",
      "reps": "90",
      "sets": "10",
      "exercise": "4",
      "target": "1000"
    },
    {
      "title": "Squats",
      "duration": "15 minutes",
      "reps": "60",
      "sets": "12",
      "exercise": "3",
      "target": "1500"
    },
  ];

  double _calculateOverallProgress() {
    if (_exercises.isEmpty) return 0;
    double totalProgress = 0;
    for (var ex in _exercises) {
      final reps = int.tryParse(ex['reps'] ?? '') ?? 0;
      final sets = int.tryParse(ex['sets'] ?? '') ?? 0;
      final target = int.tryParse(ex['target'] ?? '') ?? 1000;
      final exerciseProgress = (reps * sets) / target;
      totalProgress += exerciseProgress.clamp(0, 1);
    }
    return (totalProgress / _exercises.length) * 100;
  }

  @override
  Widget build(BuildContext context) {
    final progressPercent = _calculateOverallProgress();

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Goals",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overall progress: ${progressPercent.toStringAsFixed(0)}%",
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (progressPercent / 100).clamp(0.0, 1.0),
                minHeight: 10,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFFFF7F32)),
                backgroundColor: Colors.white24,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPlansTabSelected = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isPlansTabSelected ? Colors.orange : Colors.black,
                        borderRadius: BorderRadius.circular(6),
                        border: isPlansTabSelected
                            ? null
                            : Border.all(color: Colors.orange.withOpacity(0.5)),
                        boxShadow: isPlansTabSelected
                            ? [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          "Plans",
                          style: TextStyle(
                              color: isPlansTabSelected
                                  ? Colors.white
                                  : Colors.white70,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPlansTabSelected = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            !isPlansTabSelected ? Colors.orange : Colors.black,
                        borderRadius: BorderRadius.circular(6),
                        border: !isPlansTabSelected
                            ? null
                            : Border.all(color: Colors.orange.withOpacity(0.5)),
                        boxShadow: !isPlansTabSelected
                            ? [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          "Exercises",
                          style: TextStyle(
                              color: !isPlansTabSelected
                                  ? Colors.white
                                  : Colors.white70,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isPlansTabSelected) ...[
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateExerciseScreen()),
                  );
                  if (result != null && result is Map<String, String>) {
                    setState(() {
                      _exercises.add(result);
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFA84C), Color(0xFFFF6B2C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Colors.white, size: 22),
                      SizedBox(width: 8),
                      Text(
                        "Create new plan",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Colors.orange.withOpacity(0.7), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search plans or exercises",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search, color: Colors.white54),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _exercises.length,
                  itemBuilder: (context, index) {
                    final ex = _exercises[index];
                    return Column(
                      children: [
                        _exerciseCard(
                          ex['title']!,
                          ex['duration']!,
                          ex['reps']!,
                          ex['sets']!,
                          ex['exercise']!,
                          index,
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              )
            ] else ...[
              Expanded(
                child: ListView.builder(
                  itemCount: _exercises.length,
                  itemBuilder: (context, index) {
                    final ex = _exercises[index];
                    return Column(
                      children: [
                        _exerciseCard(
                          ex['title']!,
                          ex['duration']!,
                          ex['reps']!,
                          ex['sets']!,
                          ex['exercise']!,
                          index,
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              )
            ]
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF1C1C1E),
        shape: const CircularNotchedRectangle(),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/home.png", width: 28, height: 28),
              Image.asset("assets/gym.png", width: 28, height: 28),
              Image.asset("assets/add.png", width: 28, height: 28),
              Image.asset("assets/calendar.png", width: 28, height: 28),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/image.png", width: 32, height: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _exerciseCard(
      String title, String duration, String reps, String sets, String exercise, int index) {
    final int repsNum = int.tryParse(reps) ?? 0;
    final int setsNum = int.tryParse(sets) ?? 0;
    final int targetNum = int.tryParse(_exercises[index]['target'] ?? '') ?? 1000;
    final double progress = ((repsNum * setsNum) / targetNum).clamp(0.0, 1.0);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF0E0E0E), Color(0xFF000000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: RadialGradient(
            colors: [
              const Color(0xFFEA8945).withOpacity(0.3),
              const Color(0xFF0E0E0E),
            ],
            center: Alignment.topRight,
            radius: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditExerciseScreen(
                          title: title,
                          duration: duration,
                          reps: reps,
                          sets: sets,
                          exercise: exercise,
                        ),
                      ),
                    );
                    if (result != null && mounted) {
                      setState(() {
                        _exercises[index] = {
                          'title': result['title'],
                          'duration': result['duration'],
                          'reps': result['reps'],
                          'sets': result['sets'],
                          'exercise': result['exercise'],
                          'target': _exercises[index]['target'] ?? '1000',
                        };
                      });
                    }
                  },
                  child: const Icon(Icons.edit, color: Colors.orange, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoItem("Duration:", duration),
                _infoItem("Reps:", reps),
                _infoItem("Sets:", sets),
                _infoItem("Exercise:", exercise),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Progress", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFFF7F32),
                ),
                backgroundColor: Colors.white24,
              ),
            ),
            const SizedBox(height: 4),
            Text("${(progress * 100).toStringAsFixed(0)}%",
                style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
      ],
    );
  }
}
