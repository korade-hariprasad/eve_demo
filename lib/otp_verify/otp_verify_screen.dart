import 'package:eve_demo/charger_list/charger_list_screen.dart';
import 'package:eve_demo/otp_verify/bloc/otp_verify_event.dart';
import 'package:eve_demo/otp_verify/bloc/otp_verify_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../charger_list/bloc/charger_list_bloc.dart';
import 'bloc/otp_verify_bloc.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String mobileNumber, verificationId;

  const OtpVerifyScreen({super.key, required this.verificationId, required this.mobileNumber});

  @override
  OtpVerifyScreenState createState() => OtpVerifyScreenState();
}

class OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<OtpVerifyBloc>().add(TimerStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<OtpVerifyBloc, OtpVerifyState>(
            listener: (context, state) {
              if (state is OtpVerifyFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)),);
                context.read<OtpVerifyBloc>().add(TimerEndEvent());
              } else if (state is OtpVerifySuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Otp Verified")),);
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) =>
                  BlocProvider<ChargerListBloc>(
                    create: (context) => ChargerListBloc(),
                    child: const ChargerListScreen(),
                  ),), (route) => false);
              }
            },
            builder: (context, state) {
          return Padding(padding: const EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
                TextField(
                  controller: _otpController,
                  decoration: const InputDecoration(label: Text("Enter OTP here")),
                ),
                const SizedBox(height: 10,),
                (state is OtpVerifyLoadingState) ? const CircularProgressIndicator() :
                ElevatedButton(
                    onPressed: () {
                      context.read<OtpVerifyBloc>().add(VerifyOtpEvent(
                          otp: _otpController.text.trim(),
                          verificationId: widget.verificationId));
                      }, child: const Text("Verify Otp")),
                const SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state is TimerUpdatedState) Text("Resend otp in ${state.remainingTime} seconds"),
                    const SizedBox(width: 10,),
                    if (state is TimerEndedState) InkWell(child: const Text("Resend Otp", style: TextStyle(fontWeight: FontWeight.bold),),
                      onTap: () {
                      context.read<OtpVerifyBloc>().add(SendOtpEvent(mobileNumber: widget.mobileNumber));
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        })
    );
  }
}
