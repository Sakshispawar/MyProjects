import 'package:emart_app/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget detailsCard({ String? count, String? title,width}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .height(60)
      .padding(const EdgeInsets.all(4))
      .make();
}
