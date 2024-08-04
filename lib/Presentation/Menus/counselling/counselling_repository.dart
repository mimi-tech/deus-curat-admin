import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Models/counselee_model.dart';
import 'package:deuscurat_admin/Utils/toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final counseleeProvider = StateNotifierProvider<CounseleeNotifier, CounseleeState>((ref) {
  return CounseleeNotifier();
});

class CounseleeState {
  final List<CounseleeModel> counselees;
  final bool isLoading;
  final String errorMessage;
  final String updatingErrorMessage;
  final bool isUpdating;

  CounseleeState({
    required this.counselees,
    required this.isLoading,
    required this.errorMessage,
    required this.updatingErrorMessage,
    required this.isUpdating,
  });

  CounseleeState copyWith({
    List<CounseleeModel>? counselees,
    bool? isLoading,
    bool? isUpdating,
    String? errorMessage,
    String? updatingErrorMessage
  }) {
    return CounseleeState(
      counselees: counselees ?? this.counselees,
      isLoading: isLoading ?? this.isLoading,
        isUpdating: isUpdating ?? this.isUpdating,
      errorMessage: errorMessage ?? this.errorMessage,
        updatingErrorMessage: updatingErrorMessage ?? this.updatingErrorMessage
    );
  }
}

class CounseleeNotifier extends StateNotifier<CounseleeState> {
  CounseleeNotifier() : super(CounseleeState(counselees: [], isLoading: false, errorMessage: "",isUpdating:false,updatingErrorMessage:""));

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocument;
  DocumentSnapshot? _firstDocument;
  bool _hasMore = true;
  bool _hasPrevious = false;
  static const int _pageSize = 50;

  Future<void> fetchCounselees({bool next = true}) async {
   try{
    state = state.copyWith(isLoading: true);
    state = state.copyWith(errorMessage: "");
    Query query = _firestore.collection('christiansData').orderBy('datetime' ,descending: true).limit(_pageSize);

    if (next && _lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    } else if (!next && _firstDocument != null) {
      query = query.endBeforeDocument(_firstDocument!).limitToLast(_pageSize);
    }

    final snapshot = await query.get();
    if (snapshot.docs.isNotEmpty) {
      if (next) {
        _lastDocument = snapshot.docs.last;
        _firstDocument = snapshot.docs.first;
      } else {
        _lastDocument = snapshot.docs.last;
        _firstDocument = snapshot.docs.first;
      }

      _hasMore = snapshot.docs.length == _pageSize;
      _hasPrevious = _firstDocument != null;

      state = state.copyWith(
        counselees: snapshot.docs.map((doc) => CounseleeModel.fromFirestore(doc)).toList(),
        isLoading: false,
      );
    } else {
      state = state.copyWith(isLoading: false);
    }
  }catch(e){
     state = state.copyWith(isLoading: false);
     state = state.copyWith(errorMessage: e.toString());

     print("error $e");
   }

}

  Future<void> fetchNewCounselees({bool next = true}) async {
    try{
      state = state.copyWith(isLoading: true);
      state = state.copyWith(errorMessage: "");
      Query query = _firestore.collection('christiansData').where("seen", isEqualTo: "No").orderBy('datetime' ,descending: true).limit(_pageSize);

      if (next && _lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      } else if (!next && _firstDocument != null) {
        query = query.endBeforeDocument(_firstDocument!).limitToLast(_pageSize);
      }

      final snapshot = await query.get();
      if (snapshot.docs.isNotEmpty) {
        print("ddddd${snapshot.docs}");
        if (next) {
          _lastDocument = snapshot.docs.last;
          _firstDocument = snapshot.docs.first;
        } else {
          _lastDocument = snapshot.docs.last;
          _firstDocument = snapshot.docs.first;
        }

        _hasMore = snapshot.docs.length == _pageSize;
        _hasPrevious = _firstDocument != null;

        state = state.copyWith(
          counselees: snapshot.docs.map((doc) => CounseleeModel.fromFirestore(doc)).toList(),
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    }catch(e){
      state = state.copyWith(isLoading: false);
      state = state.copyWith(errorMessage: e.toString());
    }

  }

  Future<void> fetchRepliedCounselees({bool next = true}) async {
    try{
      state = state.copyWith(isLoading: true);
      state = state.copyWith(errorMessage: "");
      Query query = _firestore.collection('christiansData')
          .where("seen", isEqualTo: "Yes")
          .where("replied", isEqualTo:  "Yes")
          .orderBy('datetime' ,descending: true).limit(_pageSize);

      if (next && _lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      } else if (!next && _firstDocument != null) {
        query = query.endBeforeDocument(_firstDocument!).limitToLast(_pageSize);
      }

      final snapshot = await query.get();
      if (snapshot.docs.isNotEmpty) {
        if (next) {
          _lastDocument = snapshot.docs.last;
          _firstDocument = snapshot.docs.first;
        } else {
          _lastDocument = snapshot.docs.last;
          _firstDocument = snapshot.docs.first;
        }

        _hasMore = snapshot.docs.length == _pageSize;
        _hasPrevious = _firstDocument != null;

        state = state.copyWith(
          counselees: snapshot.docs.map((doc) => CounseleeModel.fromFirestore(doc)).toList(),
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    }catch(e){
      state = state.copyWith(isLoading: false);
      state = state.copyWith(errorMessage: e.toString());
    }

  }

  Future<void> fetchRejectedCounselees({bool next = true}) async {
    try{
      state = state.copyWith(isLoading: true);
      state = state.copyWith(errorMessage: "");
      Query query = _firestore.collection('christiansData')
          .where("seen", isEqualTo: "Yes")
          .where("replied", isEqualTo:  "No")
          .orderBy('datetime' ,descending: true).limit(_pageSize);

      if (next && _lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      } else if (!next && _firstDocument != null) {
        query = query.endBeforeDocument(_firstDocument!).limitToLast(_pageSize);
      }

      final snapshot = await query.get();
      if (snapshot.docs.isNotEmpty) {
        if (next) {
          _lastDocument = snapshot.docs.last;
          _firstDocument = snapshot.docs.first;
        } else {
          _lastDocument = snapshot.docs.last;
          _firstDocument = snapshot.docs.first;
        }

        _hasMore = snapshot.docs.length == _pageSize;
        _hasPrevious = _firstDocument != null;

        state = state.copyWith(
          counselees: snapshot.docs.map((doc) => CounseleeModel.fromFirestore(doc)).toList(),
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    }catch(e){
      print(e);
      state = state.copyWith(isLoading: false);
      state = state.copyWith(errorMessage: e.toString());
    }

  }

  Future updateCounselee(CounseleeModel counselee, String reply, List<CounseleeModel> allCounselee) async {
    try {
      await _firestore.collection('christiansData').doc(counselee.id).update({
        'reply': reply,
        'replied': 'Yes',
        'seen': 'Yes',
      }).then((value) {
        FlutterToastFunction().getToast(title:"Successful");
        for(var items in allCounselee){
          if(items.id == counselee.id){
            items.reply = reply;
            items.seen = "Yes";
            items.replied = "Yes";
           break;
          }
          state = state.copyWith(
            counselees:allCounselee ,
            isLoading: false,
          );
        }

      }).catchError((onError){
        FlutterToastFunction().getToast(title: onError.toString());
        state = state.copyWith(errorMessage: onError.toString());
      });
    }catch(e){
      FlutterToastFunction().getToast(title: e.toString());
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future updateSeenCounselee(CounseleeModel counselee, List<CounseleeModel> allCounselee) async {
    try {
      state = state.copyWith(isLoading: true);
      await _firestore.collection('christiansData').doc(counselee.id).update({
        'seen': counselee.seen == 'Yes'?"No":"Yes",
      }).then((value) {
        FlutterToastFunction().getToast(title:"Successful");
        for(var items in allCounselee){
          if(items.id == counselee.id){
            items.seen = items.seen == 'Yes'?"No":"Yes";
            break;
          }
          state = state.copyWith(
            counselees:allCounselee ,
            isLoading: false,
          );
        }
        state = state.copyWith(isLoading: false);
      }).catchError((onError){
        FlutterToastFunction().getToast(title: onError.toString());
        state = state.copyWith(errorMessage: onError.toString());
        state = state.copyWith(isLoading: false);
      });
    }catch(e){
      FlutterToastFunction().getToast(title: e.toString());
      state = state.copyWith(errorMessage: e.toString());
      state = state.copyWith(isLoading: false);
    }
  }

  Future deleteCounselee(CounseleeModel counselee, List<CounseleeModel> allCounselee) async {
    try {
      state = state.copyWith(isLoading: true);
      await _firestore.collection('christiansData').doc(counselee.id).delete().then((value) {
        allCounselee.removeWhere((item) => item.id == counselee.id);

        FlutterToastFunction().getToast(title:"Successful");
        state = state.copyWith(isLoading: false);
      }).catchError((onError){
        FlutterToastFunction().getToast(title: onError.toString());
        state = state.copyWith(errorMessage: onError.toString());
        state = state.copyWith(isLoading: false);
      });
    }catch(e){
      FlutterToastFunction().getToast(title: e.toString());
      state = state.copyWith(errorMessage: e.toString());
      state = state.copyWith(isLoading: false);
    }
  }


  void executeFunction(String functionName, {bool next = true}) {
    _lastDocument = null;
    switch (functionName) {

      case counselling:
        fetchCounselees(next: next);
        break;
      case replayedCounselee:
        fetchRepliedCounselees(next: next);
        break;
      case newCounselee:
        fetchNewCounselees(next: next);
        break;
      case notAcceptedCounselee:
        fetchRejectedCounselees(next: next);
        break;
      default:
        print('No matching function found');
    }
  }
}

