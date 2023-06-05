
class NeedyModel {
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
  String? images;
  String? video;
  bool? approvalStatus;
  bool? rejectStatus;
  bool? showStatus;
  bool? displayStatus;
  dynamic paidCount;
  dynamic likeCount;
  dynamic disLikeCount;
  dynamic amountNeeded;
  dynamic amountPaid;
  String? approvedDate;

  NeedyModel({

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
    this.images,
    this.video,
    this.approvalStatus,
    this.rejectStatus,
    this.showStatus,
    this.displayStatus,
    this.paidCount,
    this.likeCount,
    this.disLikeCount,
    this.amountNeeded,
    this.amountPaid,
    this.approvedDate,

  });
  // now create converter

  factory NeedyModel.fromJson(Map<String,dynamic> responseData){
    return NeedyModel(
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
      images: responseData['images'] ?? "",
      video: responseData['video'] ?? "",
      approvalStatus: responseData['approvalStatus'] ?? false,
      rejectStatus: responseData['rejectStatus'] ?? false,
      showStatus: responseData['showStatus'] ?? false,
      displayStatus: responseData['displayStatus'] ?? false,
      paidCount: responseData['paidCount'] ?? 0,
      likeCount: responseData['likeCount']?? 0,
      disLikeCount: responseData['disLikeCount']?? 0,
      amountNeeded: responseData['amountNeeded'] ?? "",
      amountPaid: responseData['amountPaid'] ?? "",

      approvedDate: responseData['approvedDate'] ?? DateTime.now().toString(),

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
      "images":images,
      "video":video,
      "approvalStatus":approvalStatus,
      "rejectStatus":rejectStatus,
      "showStatus":showStatus,
      "displayStatus":displayStatus,
      "paidCount":paidCount,
      "likeCount":likeCount,
      "disLikeCount":disLikeCount,
      "amountNeeded":amountNeeded,
      "amountPaid":amountPaid,
      "approvedDate":approvedDate,

    };
  }}