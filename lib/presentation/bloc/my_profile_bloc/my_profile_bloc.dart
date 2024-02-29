import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc() : super(MyProfileInitial()) {
    on<MyProfileLoadedEvent>(myProfileLoadedEvent);
  }

  FutureOr<void> myProfileLoadedEvent(
      MyProfileLoadedEvent event, Emitter<MyProfileState> emit) {
    emit(MyProfileLoadedState());
  }
}
