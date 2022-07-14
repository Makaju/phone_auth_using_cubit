import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_state.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  VerifyPhoneNumberScreen({Key? key}) : super(key: key);
  TextEditingController otpText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Verigy Phone Number'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              TextField(
                controller: otpText,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone Number',
                  counterText: '',
                ),
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is AuthLoggedInState) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyPhoneNumberScreen()));
                  } else if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(state.error),
                      duration: const Duration(seconds: 2),
                    ));
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                      onPressed: () {
                        String otp = otpText.text;
                        BlocProvider.of<AuthCubit>(context).verifyOTP(otp);
                      }, child: const Text('Submit'));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
