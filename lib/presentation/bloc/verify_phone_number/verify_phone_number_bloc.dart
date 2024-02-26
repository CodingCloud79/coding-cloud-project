import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'verify_phone_number_event.dart';
part 'verify_phone_number_state.dart';

class VerifyPhoneNumberBloc extends Bloc<VerifyPhoneNumberEvent, VerifyPhoneNumberState> {
  VerifyPhoneNumberBloc() : super(VerifyPhoneNumberInitial()) {
    on<VerifyPhoneNumberEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
