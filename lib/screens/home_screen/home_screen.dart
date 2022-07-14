import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth/cubit/auth_cubit.dart';
import 'package:phone_auth/screens/verify_phone_number_screen/verify_phone_number_screen.dart';

import '../../cubit/auth_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoggedOutState) {
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerifyPhoneNumberScreen()));
            }
          },
          builder: (context, state) {
            return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).logOut();
                },
                child: const Text('Log Out'));
          },
        ),
      ),
    );
  }
}
