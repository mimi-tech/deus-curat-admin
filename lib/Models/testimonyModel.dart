
class TestimonyModel {
  String? id;
  String? email;
  String? userAuthId;
  String? phoneNumber;
  String? gender;
  dynamic createdAt;
  dynamic contributorCount;
  dynamic requestCount;
  String? firstName;
  String? lastName;
  String? address;
  String? title;
  String? description;
  String? imagesBefore;
  String? imagesAfter;
  String? videoBefore;
  String? videoAfter;
  bool? approvalStatus;
  bool? rejectStatus;
  bool? showStatus;
  bool? displayStatus;
  dynamic paidCount;
  dynamic likeCount;
  dynamic disLikeCount;
  dynamic amountNeeded;
  dynamic amountPaid;
  dynamic testimonyTitle;
  dynamic testimonyDesc;

  TestimonyModel({

    this.id,
    this.email,
    this.userAuthId,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.gender,
    this.createdAt,
    this.contributorCount,
    this.requestCount,
    this.address,
    this.title,
    this.description,
    this.imagesBefore,
    this.imagesAfter,
    this.videoBefore,
    this.videoAfter,
    this.approvalStatus,
    this.rejectStatus,
    this.showStatus,
    this.displayStatus,
    this.paidCount,
    this.likeCount,
    this.disLikeCount,
    this.amountNeeded,
    this.amountPaid,
    this.testimonyTitle,
    this.testimonyDesc,

  });
  // now create converter

  factory TestimonyModel.fromJson(Map<String,dynamic> responseData){
    return TestimonyModel(
      id : responseData['_id'] ?? "",
      email : responseData['email'] ?? "",
      userAuthId: responseData['userAuthId'] ?? "",
      phoneNumber: responseData['phoneNumber'] ?? "",
      firstName: responseData['firstName'] ?? "",
      lastName: responseData['lastName'] ?? "",
      gender: responseData['gender'] ?? "",
      contributorCount: responseData['contributorCount'] ?? 0,
      requestCount: responseData['requestCount'] ?? 0,
      createdAt: responseData['createdAt'] ?? DateTime.now().toString(),
      address: responseData['address'] ?? "",
      title: responseData['title'] ?? "",
      description: responseData['description'] ?? "",
      imagesBefore: responseData['imagesBefore'] ?? "",
      imagesAfter: responseData['imagesAfter'] ?? "",
      videoAfter: responseData['videoAfter'] ?? "",
      videoBefore: responseData['videoBefore'] ?? "",
      approvalStatus: responseData['approvalStatus'] ?? false,
      rejectStatus: responseData['rejectStatus'] ?? false,
      showStatus: responseData['showStatus'] ?? false,
      displayStatus: responseData['displayStatus'] ?? false,
      paidCount: responseData['paidCount'] ?? 0,
      likeCount: responseData['likeCount']?? 0,
      disLikeCount: responseData['disLikeCount']?? 0,
      amountNeeded: responseData['amountNeeded'].toString() ?? "",
      amountPaid: responseData['amountPaid'].toString() ?? "",
      testimonyTitle: responseData['testimonyTitle'] ?? "",
      testimonyDesc: responseData['testimonyDesc'] ?? "",

    );
  }
  Map<String, dynamic> toJson() {
    return {

      "id": id,
      "email": email,
      "userAuthId":userAuthId,
      "phoneNumber":phoneNumber,
      "firstName":firstName,
      "lastName":lastName,
      "gender":gender,
      "createdAt":createdAt,
      "contributorCount":contributorCount,
      "address":address,
      "title":title,
      "description":description,
      "requestCount":requestCount,
      "imagesBefore":imagesBefore,
      "imagesAfter":imagesAfter,
      "videoBefore":videoBefore,
      "videoAfter":videoAfter,
      "approvalStatus":approvalStatus,
      "rejectStatus":rejectStatus,
      "showStatus":showStatus,
      "displayStatus":displayStatus,
      "paidCount":paidCount,
      "likeCount":likeCount,
      "disLikeCount":disLikeCount,
      "amountNeeded":amountNeeded,
      "amountPaid":amountPaid,
      "testimonyTitle":testimonyTitle,
      "testimonyDesc":testimonyDesc,
    };
  }}