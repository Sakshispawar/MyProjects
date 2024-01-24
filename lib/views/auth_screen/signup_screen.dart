import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/auth_contoller.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets_common/button_widget.dart';
import '../home_screen/home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  // text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          "Join the  $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Obx(
            ()=> Column(
              children: [
                customTextField(
                  hint: nameHint,
                  title: name,
                  controller: nameController,
                  isPass: false,
                ),
                customTextField(
                  hint: emailHint,
                  title: email,
                  controller: emailController,
                  isPass: false,
                ),
                customTextField(
                  hint: passwordHint,
                  title: password,
                  controller: passwordController,
                  isPass: true,
                ),
                customTextField(
                  hint: passwordHint,
                  title: retypePass,
                  controller: passwordRetypeController,
                  isPass: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: forgetPass.text.make(),
                  ),
                ),
                5.heightBox,

                Row(
                  children: [
                    Checkbox(
                      checkColor: whiteColor,
                      activeColor: redColor,
                      value: isCheck,
                      onChanged: (newValue) {
                        setState(() {
                          isCheck = newValue; //for working checkbox
                        });
                      },
                    ),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                          text: const TextSpan(
                        children: [
                          TextSpan(
                              text: "I agree  to the ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: termAndCond,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              )),
                          TextSpan(
                              text: " &  ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: privPolicy,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              )),
                        ],
                      )),
                    )
                  ],
                ),

                5.heightBox,
                controller.isloading.value
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                )
                :ourButton(
                  bgcolor: isCheck == true ? redColor : lightGrey,
                  title: signup,
                  textColor: whiteColor,
                  onPress: () async {
                    if (isCheck != false) {
                      controller.isloading(true);
                      try {
                        await controller
                            .signupMethod(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          return controller.storeUserData(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                          );
                        }).then((value) {
                          VxToast.show(context, msg: loginsucc);
                          Get.offAll(() => const Home());
                        });
                      } catch (e) {
                        // error while adding data for storage
                        auth.signOut();
                        VxToast.show(context, msg: e.toString());
                        controller.isloading(false);
                      }
                    }
                  },
                ).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                // wrap in gesture detector --velocity x
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                          text: alracc,
                          style: TextStyle(
                            fontFamily: bold,
                            color: fontGrey,
                          )),
                      TextSpan(
                          text: login,
                          style: TextStyle(
                            fontFamily: bold,
                            color: redColor,
                          )),
                    ],
                  ),
                ).onTap(() {
                  Get.back(); //to return login page
                }),
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
