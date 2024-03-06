import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitialState()) {
    on<HomeScreenLoadedEvent>(homeScreenLoadedEvent);
    on<NavigateToHomeTabEvent>(navigateToHomeTabEvent);
    on<NavigateToLearnTabEvent>(navigateToLearnTabEvent);
    on<NavigateToEarnTabEvent>(navigateToEarnTabEvent);
    on<NavigateToMyConnectsTabEvent>(navigateToMyContactsTabEvent);
    on<NavigateToMyProfileEvent>(navigateToMyProfileEvent);
    on<NavigateToPrivacyPolicyEvent>(navigateToPrivacyPolicyEvent);
    on<NavigateToRewardPointsEvent>(navigateToRewardPointsEvent);
    on<NavigateToWithdrawlsEvent>(navigateToWithdrawlsEvent);
    on<NavigateToMyCoursesEvent>(navigateToMyCoursesEvent);
    on<HomeScreenLogoutEvent>(homeScreenLogoutEvent);
    on<DrawerTabChangeEvent>(drawerTabChangeState);
  }

  FutureOr<void> navigateToHomeTabEvent(
      NavigateToHomeTabEvent event, Emitter<HomeScreenState> emit) {
    emit(NavigateToHomeTabState());
    emit(DrawerTabChangeState(tabIndex: 0));
    debugPrint(" Bloc :  NavigateToHomeTabState");
  }

  FutureOr<void> navigateToMyContactsTabEvent(
      NavigateToMyConnectsTabEvent event, Emitter<HomeScreenState> emit) {
    debugPrint(" Bloc : NavigateToMyContactsTabEvent  ");
    emit(NavigateToMyConnectsTabState());
    emit(DrawerTabChangeState(tabIndex: 2));
  }

  FutureOr<void> navigateToEarnTabEvent(
      NavigateToEarnTabEvent event, Emitter<HomeScreenState> emit) {
    debugPrint(" Bloc : NavigateToEarnTabEvent ");
    emit(NavigateToEarnTabState());
    emit(DrawerTabChangeState(tabIndex: 3));
  }

  FutureOr<void> navigateToLearnTabEvent(
      NavigateToLearnTabEvent event, Emitter<HomeScreenState> emit) {
    debugPrint(" Bloc : NavigateToLearnTabEvent ");
    emit(NavigateToLearnTabState());
    emit(DrawerTabChangeState(tabIndex: 5));
  }

  FutureOr<void> navigateToWithdrawlsEvent(
      NavigateToWithdrawlsEvent event, Emitter<HomeScreenState> emit) {
    emit(NavigateToWithdrawlsState());
    emit(DrawerTabChangeState(tabIndex: 4));
    debugPrint(" Bloc :  NavigateToWithdrawlsState");
  }

  FutureOr<void> navigateToRewardPointsEvent(
      NavigateToRewardPointsEvent event, Emitter<HomeScreenState> emit) {
    emit(NavigateToRewardPointsState());
    emit(DrawerTabChangeState(tabIndex: 0));
    debugPrint(" Bloc :  NavigateToRewardPointsState");
  }

  FutureOr<void> navigateToPrivacyPolicyEvent(
      NavigateToPrivacyPolicyEvent event, Emitter<HomeScreenState> emit) {
    emit(NavigateToPrivacyPolicyState());
    debugPrint(" Bloc :  NavigateToPrivacyPolicyState ");
  }

  FutureOr<void> navigateToMyProfileEvent(
      NavigateToMyProfileEvent event, Emitter<HomeScreenState> emit) {
    emit(NavigateToMyProfileState());
    debugPrint(" Bloc : NavigateToMyProfileState ");
  }

  FutureOr<void> navigateToMyCoursesEvent(
      NavigateToMyCoursesEvent event, Emitter<HomeScreenState> emit) {
    debugPrint(" Bloc : NavigateToMyCoursesEvent ");
    emit(NavigateToMyCoursesState());
  }

  FutureOr<void> homeScreenLogoutEvent(
      HomeScreenLogoutEvent event, Emitter<HomeScreenState> emit) {
    emit(HomeScreenLogoutState());
  }

  FutureOr<void> drawerTabChangeState(
      DrawerTabChangeEvent event, Emitter<HomeScreenState> emit) {
    if (event is DrawerTabChangeEvent) {
      emit(DrawerTabChangeState(tabIndex: event.tabIndex));
      debugPrint("${event.tabIndex}");
    }
  }

  FutureOr<void> homeScreenLoadedEvent(HomeScreenLoadedEvent event, Emitter<HomeScreenState> emit) {
  //  emit(HomeScreenLoadedState(quiz));
  //  FirebaseFirestore 
  }
}
