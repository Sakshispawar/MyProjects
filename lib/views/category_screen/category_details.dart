import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

import '../../widgets_common/loading_indicator.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;

  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // subcategory controller find as initialized in screen
    var controller = Get.find<ProductController>();

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: title!.text.fontFamily(bold).white.make(),
            ),
            body: StreamBuilder(
              stream: FireStoreServices.getProducts(title),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                // loader
                if (!snapshot.hasData) {
                  return Center(
                    child: loadingIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  // no data of that category
                  return Center(
                    child: "No products found".text.color(darkFontGrey).make(),
                  );
                }
                // some data of category present
                else {
                  var data = snapshot.data!.docs;

                  return Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // to handle overflow
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                controller.subcat.length,
                                (index) => "${controller.subcat[index]}"
                                    .text
                                    .size(12)
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .makeCentered()
                                    .box
                                    .rounded
                                    .size(120, 60)
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .make()),
                          ),
                        ),
                        20.heightBox,
                        //   items container
                        Expanded(
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 250,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                              ),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // use network for img array containg img address
                                    Image.network(
                                      data[index]['p_imgs'][0],
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    "${data[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    // currency format
                                    "${data[index]['p_price']}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .size(16)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .outerShadowSm
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .padding(const EdgeInsets.all(12))
                                    .roundedSM
                                    .make()
                                    .onTap(() {
                                      controller.checkIfFav(data[index]);
                                  //     pass data of product we r seeing
                                  Get.to(() => ItemDetails(
                                        title: "${data[index]['p_name']}",
                                        data: data[index],
                                      ));
                                });
                              }),
                        ),
                      ],
                    ),
                  );
                }
              },
            )));
  }
}
