import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:get/get.dart";
import 'package:flutter/material.dart';

class BottomSheetView {
  //create a method to show the bottom sheet or hide it
 // Function showBottomSheet;
  Widget bottomSheetView() {
    final _firestore = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser!;
    final String uid = user.uid;
    return Container(
      width: double.infinity,
      height: 70,
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').doc(uid).collection('todo').snapshots(),
        //builder
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            final data = snapshot.requireData;

            //print(snapshot.data!.docs.length);
            return Card(
              child: ListTile(
                leading: const Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Icon(Icons.task),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Total Task",
                      style: TextStyle(
                        color: Get.isDarkMode
                            ? Colors.white
                            : Colors.blueGrey[900],
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  //by default all tasks are uncompleted
                  //so we query firestore to see if the task is completed
                  child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Text(data.docs.length.toString(), style: TextStyle(color: Colors.white),)
                  ),
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Error getting todo's"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
