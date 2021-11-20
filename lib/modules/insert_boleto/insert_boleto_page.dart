import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  State<InsertBoletoPage> createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final InsertBoletoController controller = Get.put(InsertBoletoController());

  @override
  void initState() {
    if (widget.barcode != null) {
      controller.barcodeTextEditing.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 93, vertical: 24),
              child: Text(
                'Preencha os dados do boleto',
                style: TextStyles.titleBoldHeading,
                textAlign: TextAlign.center,
              ),
            ),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  InputTextWidget(
                    label: "Nome do boleto",
                    icon: Icons.description_outlined,
                    onChanged: (value) {
                      controller.onChange(name: value);
                    },
                    validator: controller.validateName,
                  ),
                  InputTextWidget(
                    label: "Vencimento",
                    icon: FontAwesomeIcons.timesCircle,
                    onChanged: (value) {
                      controller.onChange(dueDate: value);
                    },
                    controller: controller.dueDateMasked,
                    validator: controller.validateVencimento,
                  ),
                  InputTextWidget(
                    label: "Valor",
                    icon: FontAwesomeIcons.wallet,
                    onChanged: (value) {
                      controller.onChange(
                          value: controller.moneyMasked.numberValue);
                    },
                    controller: controller.moneyMasked,
                    validator: (_) => controller
                        .validateValor(controller.moneyMasked.numberValue),
                  ),
                  InputTextWidget(
                    label: "Código",
                    icon: FontAwesomeIcons.barcode,
                    onChanged: (value) {
                      controller.onChange(barcode: value);
                    },
                    controller: controller.barcodeTextEditing,
                    validator: controller.validateCodigo,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: SetLabelButtons(
        enablePrimaryColor: false,
        enabelSecondaryColor: true,
        primaryLabel: "Cancelar",
        primaryOnTap: () {
          Get.back();
        },
        secondaryLabel: "Confimar",
        secondaryOnTap: () async {
          await controller.cadastrarBoleto();
          Get.back();
        },
      ),
    );
  }
}
