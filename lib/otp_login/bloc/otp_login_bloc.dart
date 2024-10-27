import 'dart:async';
import 'package:eve_demo/otp_login/bloc/otp_login_event.dart';
import 'package:eve_demo/otp_login/bloc/otp_login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../network/firebase/firebase_auth_service.dart';

class OtpLoginBloc extends Bloc<SendOtpEvent, OtpLoginState>{

  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  OtpLoginBloc(super.initialState){
    on<SendOtpEvent>(_onSendOtpEvent);
  }

  Future<void> _onSendOtpEvent(SendOtpEvent event, Emitter<OtpLoginState> emit) async {
    emit(OtpLoginLoadingState());
    try {
      String verificationId = await firebaseAuthService.sendOtp(event.mobileNumber);
      emit(OtpLoginSendSuccessfulState(verificationId: verificationId));
    } catch (e) {
      emit(OtpLoginSendFailedState(error: e.toString()));
    }
  }
}