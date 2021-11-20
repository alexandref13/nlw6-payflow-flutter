import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/user/user_controller.dart';

class LoginController extends GetxController {
  AuthController authController = Get.put(
    AuthController(),
  );

  UserController userController = Get.find(
    tag: 'user',
  );

  googleSignIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();

      final user = UserModel(
        name: response!.displayName!,
        photoUrl: response.photoUrl,
      );

      userController.name.value = response.displayName!;
      userController.photoUrl.value = response.photoUrl!;

      authController.setUser(user);
      return;
    } catch (error) {
      authController.setUser(null);
      print('error: $error');
    }
  }
}
