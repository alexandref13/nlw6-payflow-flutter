import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentPage = 0.obs;

  void setPage(int index) {
    currentPage.value = index;
  }
}
