import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';

class BoletoListWidget extends StatelessWidget {
  final BoletoListController controller = Get.put(BoletoListController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return controller.isLoading.value
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: controller.boleto
                      .map((e) => BoletoTileWidget(data: e))
                      .toList(),
                ),
              );
      },
    );
  }
}
