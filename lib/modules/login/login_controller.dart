import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';

class LoginController extends GetxController {
  AuthController authController = Get.put(
    AuthController(),
    permanent: true,
  );

  googleSignIn() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    try {
      final response = await _googleSignIn.signIn();
      final user =
          UserModel(name: response!.displayName!, photoUrl: response.photoUrl);
      authController.setUser(user);
      print(response);
      return;
    } catch (error) {
      authController.setUser(null);
      print(error);
    }
  }
}
