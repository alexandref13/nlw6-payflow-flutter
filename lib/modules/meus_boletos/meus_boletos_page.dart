import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_info/boleto_info_widget.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_widget.dart';

class MeusBoletosPage extends StatelessWidget {
  final BoletoListController controller = Get.put(BoletoListController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 80,
            child: Stack(
              children: [
                Container(
                  height: 40,
                  color: AppColors.primary,
                ),
                AnimatedCard(
                  child: BoletoInfoWidget(),
                  direction: AnimatedCardDirection.left,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 32,
              left: 24,
              right: 24,
            ),
            child: Row(
              children: [
                Text(
                  "Meus boletos",
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
          BoletoListWidget(),
        ],
      ),
    );
  }
}
