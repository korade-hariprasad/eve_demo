import 'package:equatable/equatable.dart';

class OtpLoginState extends Equatable{
  @override
  List<Object?> get props => [];
}

class OtpLoginInitialState extends OtpLoginState{}

class OtpLoginLoadingState extends OtpLoginState{}

class OtpLoginSendSuccessfulState extends OtpLoginState{
  final String verificationId;
  OtpLoginSendSuccessfulState({required this.verificationId});
}

class OtpLoginSendFailedState extends OtpLoginState{
  final String error;
  OtpLoginSendFailedState({required this.error});
  @override
  List<Object?> get props => [error];
}