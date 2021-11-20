import 'package:get/get.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoListController extends GetxController {
  var isLoading = false.obs;
  var boleto = <BoletoModel>[].obs();

  BoletoListController() {
    getBoletos();
  }

  getBoletos() async {
    try {
      isLoading(true);
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList("boletos") ?? <String>[];

      boleto.assignAll(response.map((e) => BoletoModel.fromJson(e)).toList());
      isLoading(false);
    } catch (err) {
      boleto = <BoletoModel>[];
    }
  }
}
