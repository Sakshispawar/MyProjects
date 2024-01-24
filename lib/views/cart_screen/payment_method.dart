import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

import '../../widgets_common/button_widget.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: ourButton(
          bgcolor: redColor,
          onPress: () {},
          title: "Place my order",
          textColor: whiteColor),
      appBar: AppBar(
        title: "Choose a Payment method"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding:EdgeInsets.all(12) ,
          child: Column(
            // children: List.generate(length, (index) => null)
          ),),
    );
  }
}
