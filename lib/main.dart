import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/pages/home_page.dart';
import 'package:to_do_list/pages/onboarding_page.dart';
import 'package:to_do_list/provider/todo_provider.dart';


bool show = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  show = prefs.getBool('ON_BOARDING') ?? true;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => TodoProvider()..getAllData())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: show ? OnboardingPage() : const HomePage(),
      ),
    );
  }
}
