import 'package:get/get.dart';
import 'package:payflow/shared/auth/auth_controller.dart';

class SplashController extends GetxController {
  AuthController authController = Get.put(
    AuthController(),
    permanent: true,
  );

  @override
  void onInit() {
    authController.currentUser();
    super.onInit();
  }
}
