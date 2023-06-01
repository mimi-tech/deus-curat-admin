
class PaymentModel {
  String? id;
  String? requestId;
  String? requestAuthId;
  String? phoneNumber;
  String? gender;
  dynamic createdAt;
  String? firstName;
  String? lastName;

  dynamic needyName;
  dynamic needyGender;
  bool? accepted;
  dynamic amount;

  PaymentModel({

    this.id,
    this.requestId,
    this.requestAuthId,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.gender,
    this.createdAt,
    this.needyName,
    this.needyGender,
    this.accepted,
    this.amount,
  });
  // now create converter

  factory PaymentModel.fromJson(Map<String,dynamic> responseData){
    return PaymentModel(
      id : responseData['_id'] ?? "",
      requestId : responseData['requestId'] ?? "",
      requestAuthId: responseData['requestAuthId'] ?? "",
      phoneNumber: responseData['senderDetails']['phoneNumber'] ?? "",
      firstName: responseData['senderDetails']['firstName'] ?? "",
      lastName: responseData['senderDetails']['lastName'] ?? "",
      gender: responseData['senderDetails']['gender'] ?? "",
      createdAt: responseData['createdAt'] ?? DateTime.now().toString(),
      needyName: responseData['requestDetails']['needyName']?? "",
      needyGender: responseData['requestDetails']['needyGender'] ?? "",
      amount: responseData['amount'] ?? 0,
      accepted: responseData['accepted'] ?? false,

    );
  }
  Map<String, dynamic> toJson() {
    return {

      "id": id,
      "requestId": requestId,
      "requestAuthId":requestAuthId,
      "phoneNumber":phoneNumber,
      "firstName":firstName,
      "lastName":lastName,
      "gender":gender,
      "createdAt":createdAt,
      "needyName":needyName,
      "needyGender":needyGender,
      "accepted":accepted,
      "amount":amount,
    };
  }}