import 'package:equatable/equatable.dart';

class OtpLoginEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends OtpLoginEvent{
  final String mobileNumber;
  SendOtpEvent({required this.mobileNumber});
  @override
  List<Object?> get props => [mobileNumber];
}