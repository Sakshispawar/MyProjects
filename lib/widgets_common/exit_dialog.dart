import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm ".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure u want to exit?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(bgcolor: redColor,onPress: (){
              SystemNavigator.pop();//exit
            },textColor: whiteColor,title: "Yes"),
            ourButton(bgcolor: redColor,onPress: (){
              Navigator.pop(context);
            },textColor: whiteColor,title: "No")
          ],
        ),
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
