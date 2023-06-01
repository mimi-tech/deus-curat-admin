import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Logic/sharedPreference.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/commonModel.dart';
import 'package:deuscurat_admin/Models/needyModel.dart';
import 'package:deuscurat_admin/Models/payment.dart';
import 'package:deuscurat_admin/Services/apiConstants.dart';
import 'package:deuscurat_admin/Services/repository.dart';
import 'package:deuscurat_admin/Utils/constant.dart';
import 'package:deuscurat_admin/Utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<dynamic>>((ref) {
  return AuthNotifier(Repository());
});
class AuthNotifier extends StateNotifier<AsyncValue<dynamic>> {
  final Repository _repository;
  AuthNotifier(this._repository) : super( const AsyncData(null) );

  // Define a state provider for the picked file

  Future<dynamic> login(String email, String password) async {
    state = const AsyncValue.loading();
    var response = await _repository.loginUser(email, password);
    if (response is Success) {
      String fullName = "${response.data!['data']['firstName']} ${response.data!['data']['lastName']}";
      UserPreferences().saveToken(response.data!["token"]);
      UserPreferences().saveAuthId(response.data!['data']['id']);
      UserPreferences().saveFullName(fullName);
      state =  const AsyncValue.data("logged in");
      return true;
    }
    if(response is Failure){

      state = AsyncValue.error(response.errorResponse.toString(),StackTrace.current);
      return false;
    }
  }
}


final getCommons = FutureProvider<List<CommonsModel>>((ref) async {
  var response = await Repository.getCommons();
  if (response is Success) {
    final List<dynamic> responseData = response.data!["data"];
    final commons = responseData.map((json) => CommonsModel.fromJson(json)).toList();
    return commons;
  }

  return [];
});

final getHighestDonors = FutureProvider<List<PaymentModel>>((ref) async {
  var response = await Repository.getHighestDonor();
  if (response is Success) {
    final List<dynamic> responseData = response.data!["data"];
    final highestDonors = responseData.map((json) => PaymentModel.fromJson(json)).toList();

    return highestDonors;
  }

  return [];
});

final getNeedy = FutureProvider<List<NeedyModel>>((ref) async {
  Constant.requestPayments.clear();
  var response = await Repository.getApprovedNeeds();
  if (response is Success) {
    final List<dynamic> responseData = response.data!["data"];
    final needs = responseData.map((json) => NeedyModel.fromJson(json)).toList();
    for(int i = 0; i < needs.length; i++){
       await getPayment(needs[i].id);
    }
    return needs;
  }

  return [];
}
);


  getPayment([String? requestId]) async {
    var response = await Repository.payment(requestId);
    if (response is Success) {
      final List<dynamic> responseData = response.data!["data"];

      Constant.requestPayments.add(response.data!["data"]);
    }
    if(response is Failure){
      Constant.requestPayments.addAll([]);
    }
  }







class MyChangeNotifier extends ChangeNotifier {
  // Your ChangeNotifier implementation
  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  int _pageNumber = 1;
  int get pageNumber => _pageNumber;

  void incrementPageNumber(){
    _pageNumber++;
    notifyListeners();
  }

  void decrementPageNumber(){
    _pageNumber--;
    notifyListeners();
  }

  getDeleteNeedy(userAuthId) async {
     setLoading(true);
    var response = await Repository.deleteNeedy(userAuthId);
    if (response is Success) {
      FlutterToastFunction().getToast(title: response.message,color: kGreenColor);
      return true;
    }
    if(response is Failure){
      FlutterToastFunction().getToast(title: response.errorResponse,color: kRedColor);
      setLoading(false);
    }
  }

  getUpdateNeedStatus(userAuthId,type) async {
    setLoading(true);
    var response = await Repository.updateNeedy(userAuthId,type);
    if (response is Success) {
      FlutterToastFunction().getToast(title: response.message,color: kGreenColor);
    }
    if(response is Failure){
      setLoading(false);
      FlutterToastFunction().getToast(title: response.errorResponse,color: kRedColor);

    }
  }

  getUpdateNeedyDetails(title,description,amountNeeded,userAuthId) async {
    setLoading(true);
    var response = await Repository.updateNeedyDetails(title,description,amountNeeded,userAuthId);
    if (response is Success) {
      FlutterToastFunction().getToast(title: response.message,color: kGreenColor);

    }
    if(response is Failure){
      setLoading(false);
      FlutterToastFunction().getToast(title: response.errorResponse,color: kRedColor);

    }
  }

  Future<List<NeedyModel>> getRequest(type) async {
    var response = await Repository.getRequest(pageNumber, type);
    if (response is Success) {
      final List<dynamic> responseData = response.data!["data"];
      final needs = responseData.map((json) => NeedyModel.fromJson(json)).toList();
      return needs;
    }
    return [];
  }

}