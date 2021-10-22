import 'package:get/get.dart';
import 'package:payflow/modules/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(), permanent: true, tag: 'login');
  }
}
