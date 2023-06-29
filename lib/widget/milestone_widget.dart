import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parenthood/model/todo_model.dart';
import 'package:parenthood/views/MilestonePage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MilestoneWidget extends StatefulWidget {
  const MilestoneWidget({Key? key}) : super(key: key);

  MilestoneWidgetManager createState() => MilestoneWidgetManager();
}

class MilestoneWidgetManager extends State<MilestoneWidget> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final MilestoneModal milestoneModal = MilestoneModal();

  @override
  Widget build(BuildContext context) {
    return Container();
  }


  //widget for todo list view from firebase
  Future<Widget> milestoneWidget(BuildContext context, DateTime startDate, DateTime endDate) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = await _auth.currentUser!;
    final String uid = user.uid;
    Stream<QuerySnapshot> _userData = _firestore.collection('users').doc(uid).collection('milestones')
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Error getting todos"),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!.docs;
          if (data.isEmpty) {
            print('Snapshot data: ${snapshot.data!.docs}');
            return const Center(
              child: Text("No Milestones"),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {

                // Extract the target date from Firestore.
                DateTime targetDate = data[index]['date'].toDate();

                // Calculate the difference in days.
                int remainingDays = targetDate.difference(DateTime.now()).inDays;

                // Define card border color based on remaining days.
                Color borderColor;
                if (remainingDays > 30) {
                  borderColor = Colors.green;
                } else if (remainingDays > 15) {
                  borderColor = Colors.blue;
                } else if (remainingDays > 10) {
                  borderColor = Colors.yellow;
                } else {
                  borderColor = Colors.red; // Consider defaulting to red if less than or equal to 10 days remaining.
                }

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MilestoneDetailScreen(
                        title: data[index]['title'],
                        description: data[index]['description'],
                        date: data[index]['date'],
                      )),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: borderColor, width: 8.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: Padding( // Added Padding for card size increase.
                      padding: const EdgeInsets.all(20),
                      child: Column( // Changed from ListTile to Column.
                        children: [

                          Padding(
                            padding: EdgeInsets.only(bottom: 8), // Added some padding below the icon.
                            child: Align(
                              alignment: Alignment.centerLeft, // Align to the right.
                              child: Image.network(
                                data[index]['iconUrl'],
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),),
                          ),

                          SizedBox(
                            height: 8,
                          ), // Added some space between icon and title.
                          Align(
                            alignment: Alignment.centerLeft, // Align to the left.
                            child: Text(
                              data[index]['title'],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Adjust your font size and style as needed.
                            ),
                          ),
                          SizedBox(height: 8), // Added some space between title and description.
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data[index]['description'],
                              style: TextStyle(fontSize: 16),
                              maxLines: 2, // Show only 2 lines.
                              overflow: TextOverflow.ellipsis, // Truncate after 2 lines.
                            ),
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MilestoneDetailScreen(
                                  title: data[index]['title'],
                                  description: data[index]['description'],
                                  date: data[index]['date'],
                                )),
                              );
                            },
                            // Align Text to the right also give back ground color to button

                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Read More',
                                  style: TextStyle(fontSize: 14, color: Colors.white), // Adjust your font size and style as needed.
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8), // Added some space between description and date.
                          Align(
                            alignment: Alignment.centerRight, // Align to the left.
                            child: Text(
                              DateFormat('dd-MM-yyyy').format(data[index]['date'].toDate()) + ' ' + data[index]['time'],
                              style: TextStyle(fontSize: 14, color: Colors.grey), // Adjust your font size and style as needed.
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        } else {
          return const Center(
            child: Text("No Milestone to display."),
          );
        }
      },
    );
  }
}