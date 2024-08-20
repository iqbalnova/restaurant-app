import 'package:flutter/material.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  Future<void> checkLoginStatus() async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.restaurant);
      // Put logic after login here
      // if (1 > 2) {
      //   Navigator.pushReplacementNamed(context, AppRoutes.main);
      // } else {
      //   // Navigator.pushReplacementNamed(context, AppRoutes.login);
      //   Navigator.pushReplacementNamed(context, AppRoutes.login);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              Images.splashLogo,
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
