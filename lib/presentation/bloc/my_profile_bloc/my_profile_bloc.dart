import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc() : super(MyProfileInitial()) {
    on<MyProfileInitialEvent>(myProfileInitialEvent);
    on<LoadMyProfileEvent>(loadMyProfileEvent);
  }

  FutureOr<void> loadMyProfileEvent(
      LoadMyProfileEvent event, Emitter<MyProfileState> emit) async {
    emit(MyProfileLoadingState());
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var uuid = await _prefs.getString('uuid');
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('uuid', isEqualTo: uuid)
        .get();
      print(querySnapshot.docs.first.data());
    emit(MyProfileLoadedState(data: querySnapshot.docs.first.data()));
  }

  FutureOr<void> myProfileInitialEvent(MyProfileInitialEvent event, Emitter<MyProfileState> emit) {
  
  }
}

