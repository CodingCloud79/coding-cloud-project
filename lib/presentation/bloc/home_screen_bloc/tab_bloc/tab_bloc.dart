import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'tab_state.dart';
part 'tab_event.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitial(tabIndex: 0)) {
    on<TabChangeEvent>(
      (event, emit) {
        // ignore: unnecessary_type_check
        if (event is TabChangeEvent) {
          emit(TabInitial(tabIndex: event.tabIndex));
          
        }
      },
    );
  }
}
