
class NewUser {
  String? email;
  String? userId;
  String? phoneNumber;
  String? gender;
  dynamic createdAt;
  dynamic contributionCount;
  dynamic requestCount;
  String? firstName;
  String? lastName;
  bool? isActive;

  NewUser({

    this.email,
    this.userId,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.gender,
    this.createdAt,
    this.contributionCount,
    this.requestCount,
    this.isActive

  });
  // now create converter

  factory NewUser.fromJson(Map<String,dynamic> responseData){
    return NewUser(
      email : responseData['email'] ?? "",
      userId: responseData['id'] ?? "",
      phoneNumber: responseData['phoneNumber'] ?? "",
      firstName: responseData['firstName'] ?? "",
      lastName: responseData['lastName'] ?? "",
      gender: responseData['gender'] ?? "",
      contributionCount: responseData['contributionCount'] ?? 0,
      requestCount: responseData['requestCount'] ?? 0,
      isActive: responseData['isActive'] ?? false,
      createdAt: responseData['createdAt'] ?? DateTime.now().toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {

      "email": email,
      "userId":userId,
      "phoneNumber":phoneNumber,
      "firstName":firstName,
      "lastName":lastName,
      "gender":gender,
      "createdAt":createdAt,
      "contributionCount":contributionCount,
      "requestCount":requestCount,
      "isActive":isActive,
    };
  }}