import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? userID;
  String? userName;
  String? email;
  String? profileImageUrl;
  String? partnerEmail;

  UserModel({this.userID, this.userName, this.email, this.profileImageUrl, this.partnerEmail});

  //create a map from the model
  fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'],
      userName: map['userName'],
      email: map['email'],
      profileImageUrl: map['profileImageUrl'],
      partnerEmail: map['partnerEmail'],
    );
  }

  //create a  addToMap from the model
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'userName': userName,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'partnerEmail': partnerEmail,
    }; //returns a map
  }

  Future getCurrentUser() async {
    User? user = await FirebaseAuth.instance.currentUser;
    return user;
  }
}
