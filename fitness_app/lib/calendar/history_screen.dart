import 'package:flutter/material.dart';
import 'calendar_controller.dart';

class HistoryScreen extends StatelessWidget {
  final CalendarController controller;

  const HistoryScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Plan> historyPlans = controller.getHistoryPlans();

    return Scaffold(
      backgroundColor: Color(0x91000000),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: historyPlans.isEmpty
          ? Center(
        child: Text(
          'No history plans',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: historyPlans.length,
        itemBuilder: (context, index) {
          return _buildHistoryCard(historyPlans[index]);
        },
      ),
    );
  }

  Widget _buildHistoryCard(Plan plan) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[700]!),
      ),
      child: Column(
        children: [
          // Header with date
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              _formatHistoryDate(plan.date),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Plan content
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                // Plan type
                Row(
                  children: [
                    Text(
                      plan.type,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey[600]!),
                      ),
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                // Labels row
                Container(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
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

                // Values row
                Container(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          plan.duration,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          plan.reps,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          plan.sets,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          plan.exercise,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatHistoryDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}