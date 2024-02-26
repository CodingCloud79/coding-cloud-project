import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'enter_phone_number_event.dart';
part 'enter_phone_number_state.dart';

class EnterPhoneNumberBloc extends Bloc<EnterPhoneNumberEvent, EnterPhoneNumberState> {
  EnterPhoneNumberBloc() : super(EnterPhoneNumberInitial()) {
    on<EnterPhoneNumberEvent>((event, emit) {
     
    });
  }
}
