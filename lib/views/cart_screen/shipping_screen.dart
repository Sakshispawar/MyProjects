import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/cart_screen/payment_method.dart';
import 'package:emart_app/widgets_common/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../widgets_common/custom_textfield.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child:
        ourButton(
            bgcolor: redColor,
            onPress: () {
              if (controller.addressController.text.length > 10 ||
                  controller.phoneController.text.length > 10 ||
                  controller.postalController.text.length ==6) {
              // pass to payment screen only if conditions fulfilled
Get.to(()=>const PaymentMethods());
              }else
              {
                VxToast.show(context, msg: "Please fill form");
              }
            },
            title: "Continue",
            textColor: whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                hint: "Address",
                isPass: false,
                title: "Address(min 10 characters)",
                controller: controller.addressController),
            customTextField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            customTextField(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code(6 digit)",
                controller: controller.postalController),
            customTextField(
                hint: "Phone",
                isPass: false,
                title: "Phone(10 digit)",
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
