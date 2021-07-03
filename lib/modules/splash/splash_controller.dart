import 'package:get/get.dart';

class SplashController extends GetxController {
  handleToLogin() {
    Future.delayed(Duration(seconds: 4)).then((value) {
      Get.toNamed('/login');
    });
  }

  @override
  void onInit() {
    handleToLogin();
    super.onInit();
  }
}
