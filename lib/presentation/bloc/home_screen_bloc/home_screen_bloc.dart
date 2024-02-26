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
        emit(NavigateToMyProfileTabState());
            debugPrint(" Bloc : NavigateToMyProfileTabState ");
      }

  FutureOr<void> navigateToMyContactsTabEvent(
      NavigateToMyContactsTabEvent event, Emitter<HomeScreenState> emit) {}

  FutureOr<void> navigateToEarnTabEvent(
      NavigateToEarnTabEvent event, Emitter<HomeScreenState> emit) {}

  FutureOr<void> navigateToLearnTabEvent(
      NavigateToLearnTabEvent event, Emitter<HomeScreenState> emit) {}
}
