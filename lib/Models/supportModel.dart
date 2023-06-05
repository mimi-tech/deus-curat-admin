
class SupportModel {
  String? email;
  String? userId;
  String? phoneNumber;
  String? gender;
  dynamic createdAt;
  dynamic message;
  dynamic header;
  String? firstName;
  String? id;
  bool? isActive;

  SupportModel({

    this.email,
    this.userId,
    this.phoneNumber,
    this.firstName,
    this.id,
    this.gender,
    this.createdAt,
    this.message,
    this.header,
    this.isActive

  });
  // now create converter

  factory SupportModel.fromJson(Map<String,dynamic> responseData){
    return SupportModel(
      email : responseData['userDetails']['email'] ?? "",
      id: responseData['_id'] ?? "",
      phoneNumber: responseData['userDetails']['phoneNumber'] ?? "",
      firstName: responseData['userDetails']['name'] ?? "",
      userId: responseData['userDetails']['userId'] ?? "",
      gender: responseData['userDetails']['gender'] ?? "",
      message: responseData['message'] ?? 0,
      header: responseData['header'] ?? 0,
      isActive: responseData['isActive'] ?? false,
      createdAt: responseData['dateAdded'] ?? DateTime.now().toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {

      "email": email,
      "userId":userId,
      "phoneNumber":phoneNumber,
      "firstName":firstName,
      "id":id,
      "gender":gender,
      "createdAt":createdAt,
      "message":message,
      "header":header,
      "isActive":isActive,
    };
  }}