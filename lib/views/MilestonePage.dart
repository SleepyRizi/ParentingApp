import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MilestoneDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final Timestamp date;

  MilestoneDetailScreen({required this.title, required this.description, required this.date});

  @override
  _MilestoneDetailScreenState createState() => _MilestoneDetailScreenState();
}

class _MilestoneDetailScreenState extends State<MilestoneDetailScreen> {
  late Timer _timer;
  Duration _timeUntilTarget = Duration();

  @override
  void initState() {
    super.initState();

    DateTime targetDate = widget.date.toDate();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeUntilTarget = targetDate.difference(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Milestone Detail', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(255, 226, 227, 196),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Time remaining:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTimeUnitBox('${_timeUntilTarget.inDays}', 'DAYS'),
                buildTimeUnitBox('${_timeUntilTarget.inHours.remainder(24)}', 'HOURS'),
                buildTimeUnitBox('${_timeUntilTarget.inMinutes.remainder(60)}', 'MINUTES'),
                buildTimeUnitBox('${_timeUntilTarget.inSeconds.remainder(60)}', 'SECONDS'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimeUnitBox(String time, String unit) {
    return Column(
      children: [
        Text(
          unit,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            time,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
