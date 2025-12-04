import 'package:fitness_app/models/exercise_model.dart';
import 'package:fitness_app/pages/goal/create_plan_screen.dart';
import 'package:flutter/material.dart';

class SuperSetScreen extends StatefulWidget {
  const SuperSetScreen({super.key});

  @override
  State<SuperSetScreen> createState() => _SuperSetScreenState();
}

class _SuperSetScreenState extends State<SuperSetScreen> {
  String selectedGoal ='';
  int selectedType = 0;
  int reps=0;
  int sets=0;
  int weight=0;
  int rest=0;
  int type=0;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Create Exercise",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Warm up / Main / Cool Down
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _exerciseType("Warm up", Icons.loop, 0),
                _exerciseType("Main", Icons.access_time, 1),
                _exerciseType("Cool Down", Icons.pie_chart, 2),
              ],
            ),
            const SizedBox(height: 30),

            // 🔹 Super Set Title
            const Text("Super Set (1 of 5)",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            const SizedBox(height: 12),

            // 🔹 Title input with glow
            _glowBox(
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter a title for the exercise",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Dropdown (Exercise Duration) with glow
            const Text("Exercise duration",
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 10),

            _glowBox(
              child: DropdownButtonFormField<String>(
                value: selectedGoal,
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                items: ["1 month", "2 months", "3 months"]
                    .map((goal) => DropdownMenuItem(
                          value: goal,
                          child: Text(goal),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedGoal = value!);
                },
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 30),

            // 🔹 Reps / Sets / Weight / Rest
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 150 / 88,
              children: [
                _goalBox("Reps:", "${reps} reps"),
                _goalBox("Sets:", "${sets} sets"),
                _goalBox("Weight:", "${weight} lbs"),
                _goalBox("Rest timer:", "${rest} seconds"),
              ],
            ),
            const SizedBox(height: 40),

            // 🔹 Next set button
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFA84C), Color(0xFFFF6B2C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    ExerciseModel exercise = ExerciseModel(
                      title: titleController.text,
                      duration: selectedGoal,
                      maxReps: reps,
                      maxSets: sets,
                      weight: weight,
                      rest: rest,
                      type: selectedType,
                    );

                    Navigator.pop(context, exercise);
                  },
                  child: const Text("Next set",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔸 Shared GlowBox
  Widget _glowBox({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xFF161512), Color(0xFF000000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.orange, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: child,
    );
  }

  // 🔸 Warm up / Main / Cool Down
  Widget _exerciseType(String label, IconData icon, int index) {
    bool isSelected = selectedType == index;
    return GestureDetector(
      onTap: () => setState(() => selectedType = index),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Color(0xFF161512), Color(0xFF000000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: isSelected ? Colors.orange : const Color(0xFF505962),
                width: 2,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFEA8945).withOpacity(0.35),
                    Colors.transparent,
                  ],
                  radius: 1.0,
                  center: Alignment.topCenter,
                ),
              ),
              child: Icon(
                icon,
                size: 30,
                color: isSelected ? Colors.orange : Colors.white70,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.orange : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 🔸 GoalBox
  Widget _goalBox(String label, String value) {
    return Container(
      width: 150,
      height: 88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFF161512), Color(0xFF000000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(width: 1, color: Color(0xFF505962)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: RadialGradient(
            colors: [
              const Color(0xFFEA8945).withOpacity(0.35),
              Colors.transparent,
            ],
            radius: 1.2,
            center: Alignment.topCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Column(
                  children: const [
                    Icon(Icons.arrow_drop_up, color: Colors.white70, size: 22),
                    Icon(Icons.arrow_drop_down,
                        color: Colors.white70, size: 22),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
