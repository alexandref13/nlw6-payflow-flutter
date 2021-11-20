import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/user/user_controller.dart';

class AuthController extends GetxController {
  UserController userController = Get.put(
    UserController(),
    permanent: true,
    tag: 'user',
  );
  UserModel? _user;
  UserModel get user => _user!;

  void setUser(UserModel? user) {
    if (user != null) {
      saveUser(user);
      _user = user;
      Get.offAllNamed('home');
    } else {
      Get.offAllNamed('login');
    }
  }

  Future<void> saveUser(UserModel user) async {
    await GetStorage.init();

    final box = GetStorage();

    await box.write('user', user.toJson());
  }

  currentUser() async {
    await GetStorage.init();
    final box = GetStorage();

    await Future.delayed(Duration(seconds: 2));

    if (box.read('user') != null) {
      final user = box.read('user');
      setUser(UserModel.fromJson(user));
      var newUser = json.decode(user);

      userController.name.value = newUser['name'];
      userController.photoUrl.value = newUser['photoUrl'];
      return;
    } else {
      setUser(null);
    }
  }
}
