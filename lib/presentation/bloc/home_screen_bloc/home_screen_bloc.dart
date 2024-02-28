import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitialState()) {
    on<NavigateToHomeTabEvent>(navigateToHomeTabEvent);
    on<NavigateToLearnTabEvent>(navigateToLearnTabEvent);
    on<NavigateToEarnTabEvent>(navigateToEarnTabEvent);
    on<NavigateToMyContactsTabEvent>(navigateToMyContactsTabEvent);
    on<NavigateToMyProfileEvent>(navigateToMyProfileEvent);
    on<NavigateToPrivacyPolicyEvent>(navigateToPrivacyPolicyEvent);
    on<NavigateToRewardPointsEvent>(navigateToRewardPointsEvent);
    on<NavigateToWithdrawlsEvent>(navigateToWithdrawlsEvent);
    on<NavigateToMyCoursesEvent>(navigateToMyCoursesEvent);
  }
  FutureOr<void> navigateToHomeTabEvent(
      NavigateToHomeTabEvent event, Emitter<HomeScreenState> emit) {
    emit(NavigateToHomeTabState());
    debugPrint(" Bloc :  NavigateToHomeTabState");
  }

  FutureOr<void> navigateToWithdrawlsEvent(
      NavigateToWithdrawlsEvent event, Emitter<HomeScreenState> emit) {
    emit(NavigateToWithdrawlsState());
    debugPrint(" Bloc :  NavigateToWithdrawlsState");
  }

  FutureOr<void> navigateToRewardPointsEvent(
      NavigateToRewardPointsEvent event, Emitter<HomeScreenState> emit) {
    emit(NavigateToRewardPointsState());
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

  FutureOr<void> navigateToMyContactsTabEvent(
      NavigateToMyContactsTabEvent event, Emitter<HomeScreenState> emit) {
    debugPrint(" Bloc : NavigateToMyContactsTabEvent  ");
    emit(NavigateToMyContactsTabState());
  }

  FutureOr<void> navigateToEarnTabEvent(
      NavigateToEarnTabEvent event, Emitter<HomeScreenState> emit) {
    debugPrint(" Bloc : NavigateToEarnTabEvent ");
    emit(NavigateToEarnTabState());

  }

  FutureOr<void> navigateToLearnTabEvent(
      NavigateToLearnTabEvent event, Emitter<HomeScreenState> emit) {
    debugPrint(" Bloc : NavigateToLearnTabEvent ");
    emit(NavigateToLearnTabState());

  }

  FutureOr<void> navigateToMyCoursesEvent(
      NavigateToMyCoursesEvent event, Emitter<HomeScreenState> emit) {
    debugPrint(" Bloc : NavigateToMyCoursesEvent ");
    emit(NavigateToMyCoursesState());
  }
}
