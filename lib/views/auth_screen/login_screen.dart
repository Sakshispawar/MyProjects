import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controller/auth_contoller.dart';
import 'package:emart_app/views/auth_screen/signup_screen.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets_common/button_widget.dart';
import '../home_screen/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          //   responsive top space by velocity x
          (context.screenHeight * 0.1).heightBox, //10% h of screen
          applogoWidget(),
          10.heightBox,
          "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Obx(
            () => Column(
              children: [
                customTextField(
                    hint: emailHint,
                    title: email,
                    isPass: false,
                    controller: controller.emailController),
                customTextField(
                  hint: passwordHint,
                  title: password,
                  isPass: true,
                  controller: controller.passwordController,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: forgetPass.text.make(),
                  ),
                ),
                5.heightBox,
                // for loader
                controller.isloading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : ourButton(
                        bgcolor: redColor,
                        title: login,
                        textColor: whiteColor,
                        onPress: () async {
                          //loader
                          controller.isloading(true);
                          try {
                            // verify
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loginsucc);
                                Get.offAll(() => const Home());
                              }
                              //   for error
                              else {
                                //loader
                                controller.isloading(false);
                              }
                            });
                          } catch (e) {
                            VxToast.show(context, msg: e.toString());
                          }
                        }).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                createNewAcc.text.color(fontGrey).make(),
                5.heightBox,
                ourButton(
                    bgcolor: lightGolden,
                    title: signup,
                    textColor: redColor,
                    onPress: () {
                      Get.to(() => const SignupScreen());
                    }).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                loginWith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: lightGrey,
                        radius: 25,
                        child: Image.asset(
                          socialIconList[index],
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ),
          //   left right padding of 70
        ],
      )),
    ));
  }
}
