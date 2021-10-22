import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payflow/shared/models/user_model.dart';

class AuthController extends GetxController {
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
      return;
    } else {
      setUser(null);
    }
  }
}
