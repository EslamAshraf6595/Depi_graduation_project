import 'package:flutter/material.dart';
import 'calendar_controller.dart';
import 'history_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController _controller = CalendarController();
  final List<String> _weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x91000000),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: 400,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 20,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xe1fc6225),
                          Color(0xe1fc6225),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Calendar',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Calendar 2025',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xE6FFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Current Time and Date
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(height: 7),
                        Text(
                          _controller.formatDate(_controller.currentDate),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Calendar Grid
                  _buildCalendarGrid(),

                  // Plans Section
                  _buildPlansSection(),

                  // Add Plan Button
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: ElevatedButton(
                      onPressed: _showAddPlanDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xe1fc6225),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 4,
                        shadowColor: Color(0x42FC6225),
                      ),
                      child: Text(
                        'Add a plan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  // History Button (below Add Plan)
                  Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryScreen(controller: _controller),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'History',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Footer Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0x91000000),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Today • ${_controller.getPlansForDate(_controller.currentDate).isEmpty ? 'No events scheduled' : '${_controller.getPlansForDate(_controller.currentDate).length} events'}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    DateTime firstDayOfMonth = DateTime(_controller.currentDate.year, _controller.currentDate.month, 1);
    int daysInMonth = DateTime(_controller.currentDate.year, _controller.currentDate.month + 1, 0).day;
    int firstWeekday = firstDayOfMonth.weekday;

    List<Widget> dayWidgets = [];


    for (String day in _weekDays) {
      dayWidgets.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            day,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      );
    }

    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(Container());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime dayDate = DateTime(_controller.currentDate.year, _controller.currentDate.month, day);
      bool isSelected = _controller.isSameDay(dayDate, _controller.selectedDate);
      bool hasPlans = _controller.plans.containsKey(dayDate) && _controller.plans[dayDate]!.isNotEmpty;

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            _controller.setSelectedDate(dayDate);
          },
          child: Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xe1fc6225) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                if (hasPlans)
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Color(0xe1fc6225),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left, color: Color(0xFFFFFFFF)),
                onPressed: _controller.previousMonth,
              ),
              Text(
                _controller.formatMonthYear(_controller.currentDate),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right, color: Color(0xFFFFFFFF)),
                onPressed: _controller.nextMonth,
              ),
            ],
          ),
          SizedBox(height: 10),

          // Calendar Grid
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: dayWidgets,
          ),
        ],
      ),
    );
  }

  Widget _buildPlansSection() {
    List<Plan> plans = _controller.getPlansForDate(_controller.selectedDate);

    if (plans.isEmpty) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Text(
          'No Schedule of Plan Today',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF888888),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Plans of Today',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFFFFFF),
            ),
          ),
          SizedBox(height: 16),
          Column(
            children: plans.map((plan) => _buildPlanCard(plan, false)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(Plan plan, bool isHistory) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isHistory ? Colors.grey[800] : Colors.black45,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: Column(
        children: [
          // First row
          Container(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  plan.type,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isHistory ? Colors.grey[400] : Color(0xFFFFFFFF),
                  ),
                ),
                Spacer(),
                if (plan.isAllDay && !isHistory)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0x42FC6225),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Color(0xe1fc6225)),
                    ),
                    child: Text(
                      'All-day today',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xe1fc6225),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Second row
          Container(
            padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[700]!)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Duration:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Reps:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Sets:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Exercise:',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Third row: Values
          Container(
            padding: EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    plan.duration,
                    style: TextStyle(
                      fontSize: 14,
                      color: isHistory ? Colors.grey[400] : Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    plan.reps,
                    style: TextStyle(
                      fontSize: 14,
                      color: isHistory ? Colors.grey[400] : Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    plan.sets,
                    style: TextStyle(
                      fontSize: 14,
                      color: isHistory ? Colors.grey[400] : Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    plan.exercise,
                    style: TextStyle(
                      fontSize: 14,
                      color: isHistory ? Colors.grey[400] : Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddPlanDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Text(
                'Add a Plan',
                style: TextStyle(color: Colors.white),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _controller.typeController,
                      decoration: InputDecoration(
                        labelText: 'Type',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        hintText: 'e.g., Deadiff, Pull ups',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[700]!),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe1fc6225)),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    TextField(
                      controller: _controller.exerciseController,
                      decoration: InputDecoration(
                        labelText: 'Exercise (Number)',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        hintText: 'e.g., 110, 50, 25',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[700]!),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe1fc6225)),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: _controller.setsController,
                      decoration: InputDecoration(
                        labelText: 'Sets',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        hintText: 'e.g., 3',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[700]!),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe1fc6225)),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: _controller.repsController,
                      decoration: InputDecoration(
                        labelText: 'Reps',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        hintText: 'e.g., 10',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[700]!),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe1fc6225)),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: _controller.durationController,
                      decoration: InputDecoration(
                        labelText: 'Duration',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        hintText: 'e.g., 20 minutes',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[700]!),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xe1fc6225)),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          'All-day today',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        Spacer(),
                        Switch(
                          value: _controller.isAllDay,
                          onChanged: (value) {
                            setDialogState(() {
                              _controller.setAllDay(value);
                            });
                          },
                          activeColor: Color(0xe1fc6225),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controller.savePlan();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xe1fc6225),
                  ),
                  child: Text('Save Plan'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}