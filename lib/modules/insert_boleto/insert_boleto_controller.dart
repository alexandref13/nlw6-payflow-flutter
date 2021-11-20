import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoController extends GetxController {
  BoletoListController controller = Get.put(BoletoListController());
  final formKey = GlobalKey<FormState>();

  BoletoModel boletoModel = BoletoModel();

  var moneyMasked =
      MoneyMaskedTextController(leftSymbol: "R\$", decimalSeparator: ",");
  final dueDateMasked = MaskedTextController(mask: "00/00/0000");
  final barcodeTextEditing = TextEditingController();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  String? validateVencimento(String? value) =>
      value?.isEmpty ?? true ? "A data de vencimento não pode ser vazio" : null;
  String? validateValor(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  String? validateCodigo(String? value) =>
      value?.isEmpty ?? true ? "O código do boleto não pode ser vazio" : null;

  void onChange({
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
  }) {
    boletoModel = boletoModel.copyWith(
      name: name,
      dueDate: dueDate,
      value: value,
      barcode: barcode,
    );
  }

  Future<void> saveBoleto() async {
    final instance = await SharedPreferences.getInstance();

    final boletos = instance.getStringList("boletos") ?? <String>[];
    boletos.add(boletoModel.toJson());

    await instance.setStringList("boletos", boletos);

    controller.getBoletos();

    return;
  }

  Future<void> cadastrarBoleto() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      return await saveBoleto();
    }

    // final instance = await SharedPreferences.getInstance();

    // await instance.clear();
  }
}
