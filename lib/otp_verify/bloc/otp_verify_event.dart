import 'package:equatable/equatable.dart';

class OtpVerifyEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends OtpVerifyEvent{
  final String mobileNumber;
  SendOtpEvent({required this.mobileNumber});
  @override
  List<Object?> get props => [mobileNumber];
}

class VerifyOtpEvent extends OtpVerifyEvent{
  final String otp;
  final String verificationId;
  VerifyOtpEvent({required this.otp, required this.verificationId});
  @override
  List<Object?> get props => [otp, verificationId];
}

class TimerStartEvent extends OtpVerifyEvent{}

class TimerUpdateEvent extends OtpVerifyEvent{
  final int remainingTime;
  TimerUpdateEvent({required this.remainingTime});
  @override
  List<Object?> get props => [remainingTime];
}

class TimerEndEvent extends OtpVerifyEvent{}