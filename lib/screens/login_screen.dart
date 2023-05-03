import 'package:flutter/material.dart';
import 'package:zoom_clone/widgets/custom_button.dart';
import '../resource/auth.methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Start or join a meeting',
            style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38.0),
            child:Image.asset('assets/images/onboarding.jpg'),
          ),

           CustomButton(text: 'Google Sign In',
             onPressed: () async{
             print("you are in google sign in");
             bool res = await _authMethods.signInWithGoogle(context);
             print(res);
             if(res)
                {
                  Navigator.pushNamed(context, '/home');
                }
             
           },),

        ],
      ),
    );
  }
}