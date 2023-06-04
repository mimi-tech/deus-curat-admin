
import 'package:deuscurat_admin/Commons/strings.dart';

class PaymentModel {
  String? id;
  String? requestId;
  String? requestAuthId;
  String? userAuthId;
  String? phoneNumber;
  String? gender;
  dynamic createdAt;
  String? firstName;
  String? lastName;

  dynamic needyName;
  dynamic needyGender;
  bool? accepted;
  dynamic amount;
  String? needyAddress;
  String? needyTitle;
  String? needyImage;


  PaymentModel({

    this.id,
    this.requestId,
    this.requestAuthId,
    this.userAuthId,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.gender,
    this.createdAt,
    this.needyName,
    this.needyGender,
    this.accepted,
    this.amount,
    this.needyAddress,
    this.needyTitle,
    this.needyImage,
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
      needyAddress: responseData['requestDetails']['needyAddress'] ?? "No 8b Douglas road",
      needyTitle: responseData['requestDetails']['needyTitle'] ?? "I need to go to school",
      needyImage: responseData['requestDetails']['needyImage'] ?? placeholder,
      amount: responseData['amount'] ?? 0,
      accepted: responseData['accepted'] ?? false,
      userAuthId: responseData['userAuthId'] ?? "",

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
      "needyAddress":needyAddress,
      "needyTitle":needyTitle,
      "needyImage":needyImage,
      "userAuthId":userAuthId,
    };
  }}