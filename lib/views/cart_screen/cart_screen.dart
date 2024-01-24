import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/cart_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/cart_screen/shipping_screen.dart';
import 'package:emart_app/widgets_common/button_widget.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
         height: 50,
          child: ourButton(
              bgcolor: redColor,
              onPress: () {
                Get.to(()=>const ShippingDetails());
              },
              textColor: whiteColor,
              title: "Proceed to shipping"),
        ),
        appBar: AppBar(
          // remove back arrow
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: StreamBuilder(
          stream: FireStoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Cart is Empty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network("${data[index]['img']}"),
                                title: "${data[index]['title']} (x${data[index]['qty']})"
                                    .text
                                    .size(16)
                                    .fontFamily(semibold)
                                    .make(),
                                subtitle: "${data[index]['tprice']}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .fontFamily(semibold)
                                    .make(),
                                trailing: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FireStoreServices.deleteDocument(
                                      data[index].id);
                                }),
                              );
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total price"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(
                          () => "${controller.totalP.value}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                        ),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .width(context.screenWidth - 60)
                        .roundedSM
                        .color(lightGolden)
                        .make(),
                    10.heightBox,
                               ],
                ),
              );
            }
          },
        ));
  }
}
