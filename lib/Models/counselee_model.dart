import 'package:cloud_firestore/cloud_firestore.dart';

class CounseleeModel {
   String? id;
   String? name;
   String? email;
   String? city;
   String? datetime;
   String? selectedDate;
   String? selectedTime;
   String? message;
   String? phoneNumber;
   String? replied;
    String ?reply;
   String ?seen;
   String? sex;
   String? state;

  CounseleeModel({
     this.id,
     this.name,
     this.email,
     this.city,
     this.datetime,
     this.selectedDate,
     this.selectedTime,
     this.message,
     this.phoneNumber,
     this.replied,
     this.reply,
     this.seen,
     this.sex,
     this.state,
  });

  factory CounseleeModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return CounseleeModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      city: data['city'] ?? '',
      datetime: data['datetime'] ?? '',
      selectedTime: data['userTime'] ?? '12:00',
      selectedDate: data['userDate'] ?? DateTime.now().toString(),
      message: data['message'] ?? '',
      phoneNumber: data['phone'] ?? '',
      replied: data['replied'] ?? '',
      reply: data['reply'] ?? '',
      seen: data['seen'] ?? '',
      sex: data['sex'] ?? '',
      state: data['state'] ?? '',
    );
  }
}
