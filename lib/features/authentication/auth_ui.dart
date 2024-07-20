import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:offers_hub/features/authentication/auth_api.dart';
import 'package:offers_hub/utilis/constants.dart';

bool isGuest = false;

class AuthUI extends StatelessWidget {
  const AuthUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
            ColorizeAnimatedText('OffersHub',
                colors: [
                  Colors.white,
                  const Color.fromARGB(255, 226, 101, 92),
                  Color.fromARGB(255, 120, 83, 184)
                ],
                textStyle: TextStyle(fontSize: 60)),
          ]),
          AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
            TyperAnimatedText(
              '..a new way to grab the best offers',
              textStyle: TextStyle(color: Colors.white),
            ),
          ]),
          SizedBox(
            height: 80,
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: () async {
                await AuthApi.signInWithGoogle();
              },
              icon: Text('Login with'),
              label: Image.asset(
                'assets/general/google_logo.png',
                height: 50,
                width: 50,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: ElevatedButton.icon(
                onPressed: () async {
                  isGuest = true;
                  await auth.signOut();
                },
                icon: Text('Login as Guest'),
                label: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Icon(Icons.person_2_rounded),
                )),
          )
        ],
      ),
    );
  }
}
