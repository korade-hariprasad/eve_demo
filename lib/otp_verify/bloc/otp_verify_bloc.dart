import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../network/firebase/firebase_auth_service.dart';
import 'otp_verify_event.dart';
import 'otp_verify_state.dart';

class OtpVerifyBloc extends Bloc<OtpVerifyEvent, OtpVerifyState> {
  static const int REMAINING_TIME = 5; // Timer starts at 30 seconds
  int _remainingTime = REMAINING_TIME;
  Timer? _timer; // Timer instance to manage countdown
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  OtpVerifyBloc(super.initialState) {
    on<TimerStartEvent>(_onTimerStartEvent);
    on<SendOtpEvent>(_onSendOtpEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    on<TimerUpdateEvent>(_onTimerUpdateEvent);
    on<TimerEndEvent>(_onTimerEndEvent);
  }

  FutureOr<void> _onTimerStartEvent(TimerStartEvent event, Emitter<OtpVerifyState> emit) {
    _remainingTime = REMAINING_TIME;
    //emit(TimerStartedState(remainingTime: _remainingTime));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        add(TimerUpdateEvent(remainingTime: _remainingTime));
      } else {
        add(TimerEndEvent());
      }
    });
  }

  FutureOr<void> _onSendOtpEvent(SendOtpEvent event, Emitter<OtpVerifyState> emit) async {
    emit(OtpVerifyLoadingState());
    try {
      await firebaseAuthService.sendOtp(event.mobileNumber);
      add(TimerStartEvent()); // Start timer after OTP is sent
    } catch (e) {
      emit(OtpVerifyFailedState(error: 'Failed to send OTP'));
    }
  }

  FutureOr<void> _onVerifyOtpEvent(VerifyOtpEvent event, Emitter<OtpVerifyState> emit) async {
    emit(OtpVerifyLoadingState());
    try {
      // Add your OTP verification logic here
      await firebaseAuthService.verifyOtp(event.verificationId, event.otp);
      emit(OtpVerifySuccessState());
      _timer?.cancel(); // Cancel timer if OTP is verified
    } catch (e) {
      emit(OtpVerifyFailedState(error: 'OTP verification failed'));
    }
  }

  FutureOr<void> _onTimerUpdateEvent(TimerUpdateEvent event, Emitter<OtpVerifyState> emit) {
    emit(TimerUpdatedState(remainingTime: event.remainingTime));
  }

  FutureOr<void> _onTimerEndEvent(TimerEndEvent event, Emitter<OtpVerifyState> emit) {
    _timer?.cancel(); // Stop the timer
    _remainingTime = REMAINING_TIME; // Reset time
    emit(TimerEndedState());
  }

  @override
  Future<void> close() {
    _timer?.cancel(); // Ensure timer is cancelled when Bloc is closed
    return super.close();
  }
}