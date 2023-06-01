import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:deuscurat_admin/Logic/sharedPreference.dart';
import 'package:deuscurat_admin/Services/apiConstants.dart';
import 'package:http/http.dart' as https;
import 'package:http/http.dart';

class Repository{
  static String baseUrl = 'http://localhost:1003';
  //static String baseUrl = 'https://deus-curat.herokuapp.com';

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

  static Future<Object> getApprovedNeeds() async {
    try {
      String token = await UserPreferences().getToken();

      var url = Uri.parse("$baseUrl/get-all-needy?page=1&type=approval");

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

}