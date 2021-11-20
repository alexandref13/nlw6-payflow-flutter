import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class BarcodeScannerPage extends StatelessWidget {
  final BarcodeScannerController controller =
      Get.put(BarcodeScannerController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Obx(
            () {
              if (controller.status.value.showCamera) {
                return Container(
                  child: controller.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                centerTitle: true,
                title: Text(
                  'Escaneie o código de barras do boleto',
                  style: TextStyles.buttonBackground,
                ),
                leading: BackButton(
                  color: AppColors.background,
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              bottomNavigationBar: SetLabelButtons(
                enablePrimaryColor: false,
                primaryLabel: 'Inserir código do boleto',
                primaryOnTap: () {},
                secondaryLabel: 'Adicionar da galeria',
                secondaryOnTap: () {},
              ),
            ),
          ),
          Obx(
            () {
              if (controller.status.value.hasError) {
                return BottomSheetWidget(
                  title: 'Não foi possível identificar um código de barras',
                  subtitle:
                      'Tente escanear novamente ou digite o código do seu boleto',
                  primaryLabel: 'Escanear novamente',
                  primaryOnTap: () {
                    controller.scanWithCamera();
                  },
                  secondaryLabel: 'Digitar código',
                  secondaryOnTap: () {
                    Get.offNamed('/insertBoleto');
                  },
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
