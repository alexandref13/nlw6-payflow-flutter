import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/user/user_controller.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    UserController userController = Get.find(tag: 'user');

    List pages = [
      MeusBoletosPage(),
      ExtractPage(),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: Container(
            color: AppColors.primary,
            child: Center(
              child: ListTile(
                title: Text.rich(
                  TextSpan(
                    text: 'Olá, ',
                    style: TextStyles.titleRegular,
                    children: [
                      TextSpan(
                        text: "${userController.name.split(' ')[0]}",
                        style: TextStyles.titleBoldBackground,
                      ),
                    ],
                  ),
                ),
                subtitle: Text(
                  'Mantenha suas contas em dia',
                  style: TextStyles.captionShape,
                ),
                trailing: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(
                        userController.photoUrl.value,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  homeController.setPage(0);
                },
                icon: Obx(
                  () => Icon(Icons.home,
                      color: homeController.currentPage.value == 0
                          ? AppColors.primary
                          : AppColors.body),
                ),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  onPressed: () {
                    Get.toNamed('/insertBoleto');
                  },
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: AppColors.background,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    homeController.setPage(1);
                  },
                  icon: Obx(
                    () => Icon(
                      Icons.description_outlined,
                      color: homeController.currentPage.value == 1
                          ? AppColors.primary
                          : AppColors.body,
                    ),
                  )),
            ],
          ),
        ),
        body: Obx(
          () => pages[homeController.currentPage.value],
        ),
      ),
    );
  }
}
