import 'package:equatable/equatable.dart';

class OtpVerifyState extends Equatable{
  @override
  List<Object?> get props => [];
}

class TimerUpdatedState extends OtpVerifyState{
  final int remainingTime;
  TimerUpdatedState({required this.remainingTime});
  @override
  List<Object?> get props => [remainingTime];
}

class TimerEndedState extends OtpVerifyState{}

class TimerStartedState extends OtpVerifyState{
  final int remainingTime;
  TimerStartedState({required this.remainingTime});
  @override
  List<Object?> get props => [remainingTime];
}

class OtpVerifySuccessState extends OtpVerifyState{}

class OtpVerifyFailedState extends OtpVerifyState{
  final String error;
  OtpVerifyFailedState({required this.error});
  @override
  List<Object?> get props => [error];
}

class OtpVerifyLoadingState extends OtpVerifyState{}