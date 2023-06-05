import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Logic/sharedPreference.dart';
import 'package:deuscurat_admin/Logic/stateProvider.dart';
import 'package:deuscurat_admin/Models/commonModel.dart';
import 'package:deuscurat_admin/Models/needyModel.dart';
import 'package:deuscurat_admin/Models/payment.dart';
import 'package:deuscurat_admin/Models/supportModel.dart';
import 'package:deuscurat_admin/Models/testimonyModel.dart';
import 'package:deuscurat_admin/Models/userModel.dart';
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
  MyChangeNotifier().requestPayments.clear();
  var response = await Repository.getApprovedNeeds();
  if (response is Success) {
    final List<dynamic> responseData = response.data!["data"];
    final needs = responseData.map((json) => NeedyModel.fromJson(json)).toList();
    for(int i = 0; i < needs.length; i++){
       await MyChangeNotifier().getPayment(needs[i].id);
    }
    return needs;
  }

  return [];
}
);












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


  String _errorText = "";
  String get errorText => _errorText;
  void incrementPageNumber(){
    _pageNumber++;
    notifyListeners();
  }

  void decrementPageNumber(){
    _pageNumber--;
    notifyListeners();
  }


  setErrorText(String successText) async {
    _errorText = errorText;
    notifyListeners();
  }

   List<dynamic> _requestPayments =  [];
  List<dynamic> get requestPayments => _requestPayments;

 List<NeedyModel> _neededDonationMadeTo =  [];
  List<NeedyModel> get neededDonationMadeTo => _neededDonationMadeTo;

  List<PaymentModel> _usersPayment =  [];
  List<PaymentModel> get usersPayment => _usersPayment;

  List<NewUser> _searchedUsers =  [];
  List<NewUser> get searchedUsers => _searchedUsers;


  getDeleteNeedy(userAuthId) async {
     setLoading(true);
    var response = await Repository.deleteNeedy(userAuthId);
    if (response is Success) {
      setLoading(false);
      FlutterToastFunction().getToast(title: response.message,color: kGreenColor);
      return true;
    }
    if(response is Failure){
      FlutterToastFunction().getToast(title: response.errorResponse,color: kRedColor);
      setLoading(false);
    }
  }

  void isLoading(){
    setLoading(true);
  }

  void notIsLoading(){
    setLoading(false);
  }

  getUpdateNeedStatus(userAuthId,type) async {
    setLoading(true);
    var response = await Repository.updateNeedy(userAuthId,type);
    if (response is Success) {
      setLoading(false);
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
      setLoading(false);
      FlutterToastFunction().getToast(title: response.message,color: kGreenColor);

    }
    if(response is Failure){
      setLoading(false);
      FlutterToastFunction().getToast(title: response.errorResponse,color: kRedColor);

    }
  }

  Future<List<NeedyModel>> getRequest(type) async {
    requestPayments.clear();
    var response = await Repository.getRequest(pageNumber, type);
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

  Future<NeedyModel> getARequest(userAuthId) async {

    var response = await Repository.getANeedy(userAuthId);
    if (response is Success) {
      NeedyModel needy = NeedyModel.fromJson(response.data!["data"]);

      return needy;
    }
    throw "Error occurred";
  }

  Future<List<PaymentModel>> getPaymentType(type) async {
    //setLoading(true);
    neededDonationMadeTo.clear();
    var response = await Repository.paymentType(pageNumber, type);
    if (response is Success) {
      final List<dynamic> responseData = response.data!["data"];
      final needs = responseData.map((json) => PaymentModel.fromJson(json)).toList();
      for(int i = 0; i <  needs.length; i++){
       var result = await getARequest(needs[i].requestId);
       neededDonationMadeTo.add(result);
      }

      return needs;
    }

    return [];
  }


  Future<List<TestimonyModel>> getTestimony() async {
    //setLoading(true);
    var response = await Repository.testimony(pageNumber);
    if (response is Success) {
      final List<dynamic> responseData = response.data!["data"];
      final testimony = responseData.map((json) => TestimonyModel.fromJson(json)).toList();
      return testimony;
    }

    return [];
  }

  getCreateTestimony(imagesAfter, videoAfter, userAuthId, testimonyTitle, testimonyDesc) async {
    setLoading(true);
    var imageUrl = await Repository.uploadFileFirebase(imagesAfter);
    var videoUrl = await Repository.uploadFileFirebase(videoAfter,true);

    var response = await Repository.createTestimony(imageUrl, videoUrl, userAuthId, testimonyTitle, testimonyDesc);
    if (response is Success) {
      FlutterToastFunction().getToast(title: response.message,color: kGreenColor);
      setLoading(false);
    }

    if(response is Failure){
      FlutterToastFunction().getToast(title: response.errorResponse,color: kRedColor);
      setLoading(false);
    }
  }
  getPayment([String? requestId]) async {
    var response = await Repository.payment(requestId);
    if (response is Success) {
     requestPayments.add(response.data!["data"]);

    }
    if(response is Failure){
      requestPayments.addAll([]);
    }
  }

  Future<List<PaymentModel>> getUserPayment(userAuthId) async {
    var response = await Repository.usersPayment(userAuthId);
    if (response is Success) {
      List<dynamic> payment = response.data!["data"];
      final users = payment.map((json) => PaymentModel.fromJson(json)).toList();
      return users;

    }
   return [];
  }

  getDeleteTestimony(testimonyId) async {
    setLoading(true);
    var response = await Repository.deleteTestimony(testimonyId);
    if (response is Success) {
      setLoading(false);
      FlutterToastFunction().getToast(title: response.message,color: kGreenColor);
    }
    if(response is Failure){

      setLoading(false);
      FlutterToastFunction().getToast(title: response.errorResponse,color: kRedColor);

    }
  }

  Future<List<NewUser>> getUsers(type) async {
    usersPayment.clear();
    neededDonationMadeTo.clear();
    var response = await Repository.users(pageNumber,type);
    if (response is Success) {
      final List<dynamic> responseData = response.data!["data"];
      final users = responseData.map((json) => NewUser.fromJson(json)).toList();
      for(int i = 0; i < users.length; i++){
        if(users[i].contributionCount >=1){
        var result = await getUserPayment(users[i].userId);
        usersPayment.addAll(result);
      }else{
          usersPayment.add(PaymentModel());
        }

      }

      return users;
    }
    return [];
  }

  getDeleteUser(userAuthId) async {
    setLoading(true);
    var response = await Repository.deleteUser(userAuthId);
    if (response is Success) {
      setLoading(false);
      FlutterToastFunction().getToast(title: response.message,color: kGreenColor);
    }
    if(response is Failure){

      setLoading(false);
      FlutterToastFunction().getToast(title: response.errorResponse,color: kRedColor);

    }
  }
  getBlockUser(accountId) async {
    setLoading(true);
    var response = await Repository.blockUser(accountId);
    if (response is Success) {
      setLoading(false);
      FlutterToastFunction().getToast(title: response.message,color: kGreenColor);
    }
    if(response is Failure){

      setLoading(false);
      FlutterToastFunction().getToast(title: response.errorResponse,color: kRedColor);

    }
  }

  Future<TestimonyModel> getUserTestimony(testimonyId) async {
    var response = await Repository.getATestimony(testimonyId);
    if (response is Success) {

      final testimony =  TestimonyModel.fromJson(response.data!["data"]);
      return testimony;

    }
    return TestimonyModel();
  }

  getSearchUser(searchQuery) async {

      setLoading(true);
      searchedUsers.clear();
      var response = await Repository.searchUser(searchQuery);
      if (response is Success) {
        final List<dynamic> responseData = response.data!["data"];
        final user = responseData.map((json) => NewUser.fromJson(json)).toList();
        searchedUsers.addAll(user);
        setLoading(false);
        if(user.isEmpty){
          setErrorText(response.message.toString());
        }
      }
      if(response is Failure){
        setLoading(false);
        FlutterToastFunction().getToast(title: response.errorResponse.toString(),color: kRedColor);

        setErrorText(response.errorResponse.toString());

      }

  }

  getCreateAdmin(adminEmail) async {
    setLoading(true);
    var response = await Repository.createAdmin(adminEmail);
    if (response is Success) {
      setLoading(false);
      FlutterToastFunction().getToast(title: response.message,color: kGreenColor);
      getUsers("admin");
    }
    if(response is Failure){

      setLoading(false);
      FlutterToastFunction().getToast(title: response.errorResponse,color: kRedColor);

    }
  }

  Future<List<SupportModel>> getSupport() async {
    var response = await Repository.support(pageNumber);
    if (response is Success) {
      List<dynamic> result = response.data!["data"];
      final support = result.map((json) => SupportModel.fromJson(json)).toList();
      return support;

    }
    return [];
  }

  getDeleteSupport(supportId) async {
    setLoading(true);
    var response = await Repository.deleteSupport(supportId);
    if (response is Success) {
      setLoading(false);
      FlutterToastFunction().getToast(title: response.message,color: kGreenColor);

    }
    if(response is Failure){

      setLoading(false);
      FlutterToastFunction().getToast(title: response.errorResponse,color: kRedColor);

    }
  }
}