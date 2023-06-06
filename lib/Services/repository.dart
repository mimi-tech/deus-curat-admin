import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:deuscurat_admin/Logic/sharedPreference.dart';
import 'package:deuscurat_admin/Services/apiConstants.dart';
import 'package:http/http.dart' as https;
import 'package:http/http.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;

class Repository{
  //static String baseUrl = 'http://localhost:1003';
  static String baseUrl = 'https://deus-curat.herokuapp.com';

  Future<Object> loginUser(emailAddress,password) async {
    try {
      var body = json.encode({
        'emailAddress': emailAddress,
        'password': password
      });
      var url = Uri.parse("$baseUrl/admin-login");

      Response response = await https.post(url, headers: {'Content-Type': 'application/json' },body:body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);
      if (jsonDecoded['status'] == true) {
        return Success(response: response,data: jsonDecoded);

      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }
  static Future<Object> getCommons() async {
    try {
      var url = Uri.parse("$baseUrl/get-commons?page=1");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json'});
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {
        return Success(response: response,data: jsonDecoded);
      }
      print(jsonDecoded["message"]);
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }
  static Future<Object> getHighestDonor() async {
    try {
      String token = await UserPreferences().getToken();

      var url = Uri.parse("$baseUrl/get-payment?page=1&highestDonors=highestDonors");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json' });
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded);
      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }


  static Future<Object> payment([String? requestId]) async {
    try {
      String token = await UserPreferences().getToken();

      var url = requestId == null?
      Uri.parse("$baseUrl/get-payment?page=1")
          :Uri.parse("$baseUrl/get-payment?page=1&requestId=$requestId");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json' });
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded);
      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static Future<Object> usersPayment(userAuthId) async {
    try {
      String token = await UserPreferences().getToken();

      var url = Uri.parse("$baseUrl/get-payment?page=1&userAuthId=$userAuthId");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json' });
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded,message: jsonDecoded['message']);
      }
     print(jsonDecoded['message']);
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static Future<Object> getApprovedNeeds() async {
    try {
      String token = await UserPreferences().getToken();

      var url = Uri.parse("$baseUrl/get-all-needy?page=1&type=display");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json','authorization':token });
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded);
      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }


  static Future<Object> updateNeedy(userAuthId,type) async {
    try {
      String token = await UserPreferences().getToken();

      var url = Uri.parse("$baseUrl/needy/update-a-needy-account-status");

        var body = json.encode({
         "userAuthId":userAuthId,
          "type":type
        });
      Response response = await https.put(url, headers: {'Content-Type': 'application/json','authorization':token },body:body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded,message:jsonDecoded['message'] );
      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static Future<Object> getRequest(pageNumber, type) async {
    try {
      String token = await UserPreferences().getToken();

      var url = Uri.parse("$baseUrl/get-all-needy?page=$pageNumber&type=$type");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json','authorization':token });
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded);
      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }
  static Future<Object> deleteNeedy(userAuthId) async {
    try {
      String token = await UserPreferences().getToken();

      var url = Uri.parse("$baseUrl/needy/delete-a-needy-account");

      var body = json.encode({
        "userAuthId":userAuthId,
      });
      Response response = await https.delete(url, headers: {'Content-Type': 'application/json','authorization':token },body:body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded);
      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }


  static Future<Object> updateNeedyDetails(title,description,amountNeeded,userAuthId) async {
    try {
      String token = await UserPreferences().getToken();

      var url = Uri.parse("$baseUrl/needy/update-a-needy-account");

      var body = json.encode({
        "title":title,
        "description":description,
        "amountNeeded":amountNeeded,
        "userAuthId":userAuthId,
      });
      Response response = await https.put(url, headers: {'Content-Type': 'application/json','authorization':token },body:body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded,message:jsonDecoded['message'] );
      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }


  static Future<Object> paymentType(pageNumber, type) async {
    try {
      String token = await UserPreferences().getToken();

      var url = Uri.parse("$baseUrl/get-payment?page=$pageNumber&type=$type");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json' });
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded);
      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }


  static Future<Object> getANeedy(userAuthId) async {
    try {
      String token = await UserPreferences().getToken();

      var url = Uri.parse("$baseUrl/needy/get-a-needy-account?userAuthId=$userAuthId");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json','authorization':token });
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }


  static Future<dynamic> uploadFileFirebase(file, [bool? isVideo]) async {
    try {
      print("wdjwhw");
      firabase_storage.UploadTask uploadTask;

      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child(isVideo != null ?'UsersImages':'UsersVideos')
          .child('/${DateTime.now()}');

      final metadata = isVideo != null
          ?firabase_storage.SettableMetadata(contentType: 'image/jpeg')
          :firabase_storage.SettableMetadata(contentType: 'video/mp4');

      //uploadTask = ref.putFile(File(file.path));
      uploadTask = ref.putData(file, metadata);

      await uploadTask.then((value) => null);
      var  imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("lllll$e");
      return false;
    }

  }


  static Future<Object> createTestimony(imagesAfter,videoAfter,userAuthId,testimonyTitle,testimonyDesc) async {
    try {
      String token = await UserPreferences().getToken();

      var url = Uri.parse("$baseUrl/testimony/create-testimony");
       var body  = json.encode({
         "imagesAfter":imagesAfter,
         "videoAfter":videoAfter,
         "userAuthId":userAuthId,
         "testimonyTitle":testimonyTitle,
         "testimonyDesc":testimonyDesc
       });
      Response response = await https.post(url, headers: {'Content-Type': 'application/json','authorization':token },body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded,message: jsonDecoded['message']);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static Future<Object> testimony(pageNumber) async {
    try {
      var url = Uri.parse("$baseUrl/get-testimony?page=$pageNumber");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json' });
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }


  static Future<Object> deleteTestimony(testimonyId) async {
    try {
      String token = await UserPreferences().getToken();
      var body = json.encode({
        "testimonyId":testimonyId
      });

      var url = Uri.parse("$baseUrl/testimony/delete-testimony");

      Response response = await https.delete(url, headers: {'Content-Type': 'application/json' ,'authorization':token },body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded,message: jsonDecoded['message']);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static Future<Object> users(pageNumber,type) async {
    try {
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$baseUrl/users/get-all-users?page=$pageNumber&type=$type");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json','authorization':token});
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static Future<Object> deleteUser(userAuthId) async {
    try {
      String token = await UserPreferences().getToken();
      var body = json.encode({
        "userAuthId":userAuthId
      });

      var url = Uri.parse("$baseUrl/users/delete-account");

      Response response = await https.delete(url, headers: {'Content-Type': 'application/json' ,'authorization':token },body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded,message: jsonDecoded['message']);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static Future<Object> blockUser(accountId) async {
    try {
      String token = await UserPreferences().getToken();
      var body = json.encode({
        "accountId":accountId
      });

      var url = Uri.parse("$baseUrl/users/account-status");

      Response response = await https.put(url, headers: {'Content-Type': 'application/json' ,'authorization':token },body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded,message: jsonDecoded['message']);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static Future<Object> getATestimony(testimonyId) async {
    try {
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$baseUrl/testimony/get-a-testimony?testimonyId=$testimonyId");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json','authorization':token});
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded);
      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);


    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static Future<Object> searchUser(searchQuery) async {
    try {
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$baseUrl/users/search-user?page=1&searchQuery=$searchQuery");
      Response response = await https.get(url, headers: {'Content-Type': 'application/json','authorization':token });
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);
      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded,message: jsonDecoded["message"]);
      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }
  static Future<Object> createAdmin(adminEmail) async {
    try {
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$baseUrl/users/create-admin");
       var body = json.encode({
         "adminEmail":adminEmail
       });
      Response response = await https.put(url, headers: {'Content-Type': 'application/json','authorization':token},body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded,message:jsonDecoded['message'] );
      }
      print(jsonDecoded['message']);
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }


  static Future<Object> support(pageNumber) async {
    try {
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$baseUrl/commons/get-support?page=$pageNumber");

      Response response = await https.get(url, headers: {'Content-Type': 'application/json','authorization':token});
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }


  static Future<Object> deleteSupport(supportId) async {
    try {
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$baseUrl/commons/delete-support");
      var body = json.encode({
        "supportId":supportId
      });
      Response response = await https.delete(url, headers: {'Content-Type': 'application/json','authorization':token},body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded,message:jsonDecoded['message'] );
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

  static Future<Object> updatePayment(requestAuthId,userAuthId,paymentId,amount) async {
    try {
      String token = await UserPreferences().getToken();
      var url = Uri.parse("$baseUrl/payment/update-payment");
      var body = json.encode({
        "requestAuthId": requestAuthId,
        "userAuthId": userAuthId,
        "paymentId": paymentId,
        "amount": amount
      });
      Response response = await https.put(url, headers: {'Content-Type': 'application/json','authorization':token},body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response,data: jsonDecoded,message:jsonDecoded['message'] );
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } on TimeoutException{
      return Failure(code: TIME_OUT, errorResponse: "Time out error");
    }

    catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e.toString());
    }
  }

}
