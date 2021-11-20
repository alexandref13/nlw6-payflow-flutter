import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';

class ExtractPage extends StatelessWidget {
  final BoletoListController controller = Get.put(BoletoListController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 32,
            left: 24,
            right: 24,
          ),
          child: Row(
            children: [
              Text(
                "Meus extratos",
                style: TextStyles.titleBoldHeading,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Divider(
            height: 1,
            color: AppColors.stroke,
          ),
        ),
        // SingleChildScrollView(child: BoletoListWidget()),
      ],
    );
  }
}
