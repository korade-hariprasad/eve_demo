import 'package:eve_demo/otp_login/bloc/otp_login_bloc.dart';
import 'package:eve_demo/otp_login/bloc/otp_login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../otp_verify/bloc/otp_verify_bloc.dart';
import '../otp_verify/bloc/otp_verify_state.dart';
import '../otp_verify/otp_verify_screen.dart';
import 'bloc/otp_login_state.dart';

class OtpLoginScreen extends StatefulWidget {
  const OtpLoginScreen({super.key});

  @override
  OtpLoginScreenState createState() => OtpLoginScreenState();
}

class OtpLoginScreenState extends State<OtpLoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  late String _mobileNumber;
  final TextEditingController _countryCodeController = TextEditingController();
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'IN');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OtpLoginBloc, OtpLoginState>(
        listener: (context, state) {
          if (state is OtpLoginSendSuccessfulState) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) =>
                BlocProvider(create: (context) => OtpVerifyBloc(TimerUpdatedState(remainingTime: 30)),
                    child: OtpVerifyScreen(mobileNumber: _mobileNumber, verificationId: state.verificationId,)
                ),
            ));
          } else if (state is OtpLoginSendFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    _mobileNumber = number.phoneNumber ?? '';
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  selectorTextStyle: const TextStyle(color: Colors.black),
                  initialValue: _phoneNumber,
                  textFieldController: _mobileController,
                  formatInput: true,
                  inputDecoration: const InputDecoration(labelText: 'Enter mobile number'),
                  keyboardType: TextInputType.phone,
                  inputBorder: const OutlineInputBorder(),
                  onFieldSubmitted: (value) {
                    /*
                    print(_mobileNumber);
                    context.read<OtpLoginBloc>().add(SendOtpEvent(mobileNumber: _mobileNumber));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid 10-digit mobile number')));
                    */
                  },
                ),
                const SizedBox(height: 20),
                (state is OtpLoginLoadingState) ? const CircularProgressIndicator() : ElevatedButton(
                  onPressed: () {
                    context.read<OtpLoginBloc>().add(SendOtpEvent(mobileNumber: _mobileNumber));
                  },
                  child: const Text("Send OTP"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}