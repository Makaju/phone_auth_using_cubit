import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth/cubit/auth_cubit.dart';
import 'package:phone_auth/screens/verify_phone_number_screen/verify_phone_number_screen.dart';

import '../../cubit/auth_state.dart';

class SignInWithPhone extends StatelessWidget {
  SignInWithPhone({Key? key}) : super(key: key);
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sign in with phone'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              TextField(
                controller: phoneNumber,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone Number',
                  counterText: '',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if(state is AuthCodeSentState){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                VerifyPhoneNumberScreen()));
                  }

                },

                builder: (context, state) {
                  if(state is AuthLoadingState){
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: CupertinoButton(
                        color: Colors.blueAccent,
                        onPressed: () {
                          String number='+977${phoneNumber.text}';
                          BlocProvider.of<AuthCubit>(context).sendOTP(number);



                        },
                        child: const Text('Submit')),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
