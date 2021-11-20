import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';

class BoletoInfoWidget extends StatelessWidget {
  final BoletoListController controller = Get.put(BoletoListController());
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          height: 80,
          width: 327,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.heading,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                AppImages.logomini,
                width: 56,
                height: 34,
                color: AppColors.background,
              ),
              Container(
                height: 32,
                width: 1,
                color: AppColors.background,
              ),
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Você tem ',
                                  style: TextStyles.captionBackground),
                              Obx(() {
                                return controller.isLoading.value != true
                                    ? Text(
                                        '${controller.boleto.length} boletos',
                                        style: TextStyles.captionBoldBackground,
                                      )
                                    : Container();
                              })
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .061),
                            child: Text(
                              'cadastrados para pagar',
                              style: TextStyles.captionBackground,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      )

                      // Text.rich(

                      //   TextSpan(
                      //     text: "Você tem",
                      //     style: TextStyles.captionBackground,
                      //     children: [
                      //       TextSpan(
                      //           text: ' ${controller.boleto.length} boletos',
                      //           style: TextStyles.captionBoldBackground,
                      //           children: [
                      //             TextSpan(
                      //               text: '\ncadastrados para pagar',
                      //               style: TextStyles.captionBackground,
                      //             )
                      //           ])
                      //     ],
                      //   ),
                      // ),
                      )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
