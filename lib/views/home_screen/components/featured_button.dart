import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .roundedSM
      .shadowSm
      .white
      .padding(const EdgeInsets.all(4))
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .make()
      .onTap(() {
            Get.to(() => CategoryDetails(title: title));
  });
}
