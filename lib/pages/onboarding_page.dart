import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';


class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );


    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: IntroductionScreen(
            key: introKey,
            globalBackgroundColor: Colors.white,
            pages: [
              PageViewModel(
                title: "",
                body:"",
                image: Center(child: Image.asset("images/onboarding-screen-image-1.jpg")),
                decoration: pageDecoration,
                footer: Center(child: Text('Welcome',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),))
              ),
              PageViewModel(
                title: '',
                body:
                    "",
                image: Center(child: Image.asset("images/onboarding-screen-image-2.jpg")),
                decoration: pageDecoration,
                footer: Center(child: Text('Be Punctual',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),))
              ),
              PageViewModel(
                title: "",
                body:
                    " Complete Your Task Timely",
                image: Center(child: Image.asset("images/onboarding-screen-image-3.PNG")),
                footer: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: ElevatedButton(
                    onPressed: () => _onDone(context),
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(55), // NEW
                      primary: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                decoration: pageDecoration,
              ),
            ],

            skipOrBackFlex: 0,
            nextFlex: 0,
            showBackButton: true,
            back: const Text('Back',
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
            next: const Text('Next',
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),

            showDoneButton: false,
            curve: Curves.fastLinearToSlowEaseIn,
            controlsMargin: const EdgeInsets.all(16),
            controlsPadding: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            dotsDecorator: const DotsDecorator(
              size: Size(8.0, 8.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(15.0, 5.0),
              activeColor: Colors.black,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onDone(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
