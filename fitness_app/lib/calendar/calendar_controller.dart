import 'package:flutter/material.dart';

class Plan {
  final String type;
  final String exercise;
  final String sets;
  final String reps;
  final String duration;
  final bool isAllDay;
  final DateTime date;

  Plan({
    required this.type,
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.duration,
    required this.isAllDay,
    required this.date,
  });
}

class CalendarController extends ChangeNotifier {
  DateTime _currentDate = DateTime(2025, 7, 10);
  DateTime _selectedDate = DateTime(2025, 7, 10);


  Map<DateTime, List<Plan>> _plans = {
    DateTime(2025, 7, 5): [
      Plan(
        type: 'Push ups',
        exercise: '50',
        sets: '3',
        reps: '15',
        duration: '30 minutes',
        isAllDay: false,
        date: DateTime(2025, 7, 5),
      ),
    ],
    DateTime(2025, 7, 8): [
      Plan(
        type: 'Pull ups',
        exercise: '30',
        sets: '4',
        reps: '10',
        duration: '25 minutes',
        isAllDay: false,
        date: DateTime(2025, 7, 8),
      ),
    ],
  };

  // Controllers for the add plan form
  final TextEditingController typeController = TextEditingController();
  final TextEditingController exerciseController = TextEditingController();
  final TextEditingController setsController = TextEditingController(text: '3');
  final TextEditingController repsController = TextEditingController(text: '10');
  final TextEditingController durationController = TextEditingController(text: '20 minutes');
  bool _isAllDay = true;

  DateTime get currentDate => _currentDate;
  DateTime get selectedDate => _selectedDate;
  Map<DateTime, List<Plan>> get plans => _plans;
  bool get isAllDay => _isAllDay;

  void setCurrentDate(DateTime date) {
    _currentDate = date;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setAllDay(bool value) {
    _isAllDay = value;
    notifyListeners();
  }

  void previousMonth() {
    _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
    notifyListeners();
  }

  void nextMonth() {
    _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
    notifyListeners();
  }

  void savePlan() {
    if (typeController.text.isEmpty) return;

    Plan newPlan = Plan(
      type: typeController.text,
      exercise: exerciseController.text,
      sets: setsController.text,
      reps: repsController.text,
      duration: durationController.text,
      isAllDay: _isAllDay,
      date: _selectedDate,
    );

    if (!_plans.containsKey(_selectedDate)) {
      _plans[_selectedDate] = [];
    }
    _plans[_selectedDate]!.add(newPlan);

    typeController.clear();
    exerciseController.clear();
    setsController.text = '3';
    repsController.text = '10';
    durationController.text = '20 minutes';
    _isAllDay = true;

    notifyListeners();
  }

  List<Plan> getPlansForDate(DateTime date) {
    for (DateTime planDate in _plans.keys) {
      if (isSameDay(planDate, date)) {
        return _plans[planDate]!;
      }
    }
    return [];
  }

  List<Plan> getHistoryPlans() {
    List<Plan> history = [];
    DateTime today = DateTime.now();

    _plans.forEach((date, plans) {

      if (date.isBefore(DateTime(today.year, today.month, today.day))) {
        history.addAll(plans);
      }
    });

    return history;
  }

  String formatDate(DateTime date) {
    return '${_getWeekday(date.weekday)}, ${_getMonth(date.month)} ${date.day}';
  }

  String formatMonthYear(DateTime date) {
    return '${_getMonth(date.month)} ${date.year}';
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  String _getWeekday(int weekday) {
    switch (weekday) {
      case 1: return 'Monday';
      case 2: return 'Tuesday';
      case 3: return 'Wednesday';
      case 4: return 'Thursday';
      case 5: return 'Friday';
      case 6: return 'Saturday';
      case 7: return 'Sunday';
      default: return '';
    }
  }

  String _getMonth(int month) {
    switch (month) {
      case 1: return 'January';
      case 2: return 'February';
      case 3: return 'March';
      case 4: return 'April';
      case 5: return 'May';
      case 6: return 'June';
      case 7: return 'July';
      case 8: return 'August';
      case 9: return 'September';
      case 10: return 'October';
      case 11: return 'November';
      case 12: return 'December';
      default: return '';
    }
  }

  @override
  void dispose() {
    typeController.dispose();
    exerciseController.dispose();
    setsController.dispose();
    repsController.dispose();
    durationController.dispose();
    super.dispose();
  }
}