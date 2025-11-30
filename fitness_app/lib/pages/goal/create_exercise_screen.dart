import 'package:flutter/material.dart';
import 'super_set_screen.dart';

class CreateExerciseScreen extends StatefulWidget {
  const CreateExerciseScreen({super.key});

  @override
  State<CreateExerciseScreen> createState() => _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends State<CreateExerciseScreen> {
  String selectedGoal = "2 months";
  int selectedType = 0;

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

            const Text("Regular exercise",
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

            Row(
              children: [
                const Text("Set Goal",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(width: 6),
                Icon(Icons.info_outline, size: 18, color: Colors.white54),
              ],
            ),
            const SizedBox(height: 10),

            // 🔹 Dropdown with glow
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
                _goalBox("Reps:", "7 reps"),
                _goalBox("Sets:", "10 sets"),
                _goalBox("Weight:", "150 lbs"),
                _goalBox("Rest timer:", "80s"),
              ],
            ),
            const SizedBox(height: 40),

            // Create workout button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SuperSetScreen()),
                  );
                },
                child: const Text("Create workout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 🔸 Shared GlowBox (used for Regular exercise & Set Goal only)
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
            width: 90,
            height: 90,
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
                size: 32,
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

  // 🔸 GoalBox styled like design
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
            Text(
              label,
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: const [
                    Icon(Icons.arrow_drop_up, color: Colors.white70, size: 22),
                    Icon(Icons.arrow_drop_down, color: Colors.white70, size: 22),
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