class MilestoneModal {
  String? todoID;
  String? title;
  String? date;
  String? description;
  bool? status;

  MilestoneModal(
      {this.todoID, this.title, this.description, this.date, this.status});

  //create a map from the model
  factory MilestoneModal.fromMap(Map<String, dynamic> map) {
    return MilestoneModal(
      todoID: map['todoID'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      status: map['status'],
    );
  }

  //create a  addToMap from the model
  Map<String, dynamic> toMap() {
    return {
      'todoID': todoID,
      'title': title,
      'description': description,
      'date': date,
      'status': status,
    }; //returns a map
  }
}
