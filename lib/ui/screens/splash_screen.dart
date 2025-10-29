import 'package:school_match/domain/controllers/auth_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 5500), () async {
      // await authController.getPreferences(); // TODO: Implement this method

    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
       color: Color(0xFF110231),
      ),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lotties/Animacao1.json', width: 400),
          const SizedBox(height: 15,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
              child:const LinearProgressIndicator(
                color: Colors.grey,
                minHeight: 6,
              )
          ),
        ],
      ),
    );
  }

}
