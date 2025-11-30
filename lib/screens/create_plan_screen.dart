import 'package:flutter/material.dart';
import 'edit_plan_screen.dart'; // ✅ Import the real EditPlanScreen
import 'add_exercise_screen.dart'; // ✅ Import the new AddExerciseScreen

class CreatePlanScreen extends StatefulWidget {
  const CreatePlanScreen({super.key});

  @override
  State<CreatePlanScreen> createState() => _CreatePlanScreenState();
}

class _CreatePlanScreenState extends State<CreatePlanScreen> {
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
          "Create Plan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Warm up / Main / Cool Down with goal-style design
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _exerciseType("Warm up", Icons.loop, 0),
                _exerciseType("Main", Icons.access_time, 1),
                _exerciseType("Cool Down", Icons.pie_chart, 2),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Title field
            const Text("Exercise",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            const SizedBox(height: 10),

            Container(
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
                    color: Colors.orange.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
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

            // 🔹 Main exercises styled like goal boxes
            const Text("Main exercise",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            const SizedBox(height: 12),

            _mainExerciseCard("Push ups", "30 minutes", "115", "15", "5"),
            const SizedBox(height: 12),
            _mainExerciseCard("Pull ups", "20 minutes", "90", "10", "4"),
            const SizedBox(height: 12),
            _mainExerciseCard("Squats", "15 minutes", "60", "12", "3"),
            const SizedBox(height: 20),

            // 🔹 Other exercises styled
            const Text("Other exercises",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            const SizedBox(height: 12),

            _searchBar(),
            const SizedBox(height: 16),

            _otherExerciseCard("Lunges", "12 minutes", "45", "10", "3"),
            const SizedBox(height: 12),
            _otherExerciseCard("Plank", "10 minutes", "-", "-", "1"),
            const SizedBox(height: 12),
            _otherExerciseCard("Burpees", "8 minutes", "40", "8", "2"),
            const SizedBox(height: 30),

            // 🔹 Buttons
            _gradientButton("Create Plan", () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Plan created successfully!"),
                  backgroundColor: Colors.orange,
                ),
              );
            }),
            const SizedBox(height: 12),

            // ✅ Navigate to AddExerciseScreen
            _outlinedButton("Create Exercise", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddExerciseScreen()),
              );
            }),
          ],
        ),
      ),
    );
  }

  // 🔸 Warm up / Main / Cool Down styled like Goal screen
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
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? Colors.orange.withOpacity(0.6)
                      : Colors.black.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: RadialGradient(
                  colors: [
                    Colors.orange.withOpacity(0.35),
                    Colors.transparent,
                  ],
                  radius: 1.2,
                  center: Alignment.topCenter,
                ),
              ),
              child: Icon(icon,
                  size: 32,
                  color: isSelected ? Colors.orange : Colors.white70),
            ),
          ),
          const SizedBox(height: 6),
          Text(label,
              style: TextStyle(
                  color: isSelected ? Colors.orange : Colors.white,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ---------- Shared card wrapper (deep black + right orange glow) ----------
  Widget _glowCard({required Widget child}) {
    final borderRadius = BorderRadius.circular(16);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: const Color(0xFF0E0E0E), // deep black base
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            // subtle left-to-right dark gradient to avoid flat black
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF121212), Color(0xFF0B0B0B)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            // soft orange highlight on the RIGHT only
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.centerRight,
                      radius: 1.1,
                      colors: [
                        const Color(0xFFFFA84C).withOpacity(0.55),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
              ),
            ),
            // content
            Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  // 🔸 Main exercise card styled black + orange glow (using _glowCard)
  Widget _mainExerciseCard(
      String title, String duration, String reps, String sets, String exercise) {
    return _glowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditPlanScreen()),
                  );
                },
                child: const Text("Edit plan",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoItem("Duration:", duration),
              _infoItem("Reps:", reps),
              _infoItem("Sets:", sets),
              _infoItem("Exercise:", exercise),
            ],
          ),
        ],
      ),
    );
  }

  // 🔸 Other exercise card (same wrapper)
// 🔸 Other exercise card (same wrapper)
Widget _otherExerciseCard(
    String title, String duration, String reps, String sets, String exercise) {
  return _glowCard(
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _infoItem("Duration:", duration),
                  _infoItem("Reps:", reps),
                  _infoItem("Sets:", sets),
                  _infoItem("Exercise:", exercise),
                ],
              ),
            ],
          ),
        ),

        // ✅ Wrap the + icon with GestureDetector to navigate
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddExerciseScreen()),
            );
          },
          child: const Icon(Icons.add, color: Colors.orange, size: 22),
        ),
      ],
    ),
  );
}


  // 🔸 Info item
  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }

  // 🔸 Search bar
  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.orange.withOpacity(0.6), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
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
    );
  }

  // 🔸 Gradient button
  Widget _gradientButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [Color(0xFFFFA84C), Color(0xFFFF6B2C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: onPressed,
          child: Text(text,
              style: const TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  // 🔸 Outlined button
  Widget _outlinedButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.orange, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: const TextStyle(
                color: Colors.orange,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
