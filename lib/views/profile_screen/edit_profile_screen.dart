import 'dart:io';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/Profile_controller.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets_common/button_widget.dart';
import '../../widgets_common/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    // controller.nameController.text=data['name'];
    // controller.passController.text=data['password'];

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                ? Image.asset(
                    manProfile,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                :
                // new image
                data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                    ? Image.network(data['imageUrl'])
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            ourButton(
              bgcolor: redColor,
              onPress: () {
                controller.chageImg(context: context);
              },
              textColor: whiteColor,
              title: "Change",
            ),
            const Divider(),
            20.heightBox,
            customTextField(
              controller: controller.nameController,
              title: name,
              isPass: false,
              hint: nameHint,
            ),
            customTextField(
              controller: controller.oldpassController,
              title: oldpass,
              isPass: true,
              hint: passwordHint,
            ),
            20.heightBox,
            customTextField(
              controller: controller.newpassController,
              title: newpass,
              isPass: true,
              hint: passwordHint,
            ),
            20.heightBox,
            controller.isLoading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                      bgcolor: redColor,
                      onPress: () async {
                        //   save image first then password  then name
                        controller.isLoading(true);

                        //if image not selected
                        if (controller.profileImgPath.value.isNotEmpty) {
                          await controller.uploadProfileImage();
                        } else {
                          //pass old image link again
                          controller.profileImgLink = data['imageUrl'];
                        }

                        // set new password only if it matches old password

                        if (data['password'] ==
                            controller.oldpassController.text) {
                          await controller.changeAuthPassword(
                            email: data['email'],
                            password: controller.oldpassController.text,
                            //relogin with old pass
                            newpassword: controller
                                .newpassController.text, //change to new
                          );

                          await controller.updateProfile(
                            imgUrl: controller.profileImgLink,
                            name: controller.nameController.text,
                            password: controller.newpassController.text,
                          );
                          VxToast.show(context, msg: "Updated");
                        } else {
                          VxToast.show(context, msg: "Wrong old Password");
                          controller.isLoading(false);
                        }
                      },
                      textColor: whiteColor,
                      title: "Save",
                    ),
                  ),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .rounded
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .make(),
      ),
    ));
  }
}
