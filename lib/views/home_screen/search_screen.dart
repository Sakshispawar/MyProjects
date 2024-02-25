import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../category_screen/item_details.dart';

class SearchScreeen extends StatelessWidget {
  final String? title;

  const SearchScreeen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: title!.text.color(darkFontGrey).make(),
        ),
        // we are using future buider as we don't have to reuse it again
        body: FutureBuilder(
            future: FireStoreServices.searchProducts(title),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No such product found".text.makeCentered();
              } else {
                var data = snapshot.data!.docs;
                var filteredData = data.where((element) =>
                    element['p_name'].toString().toLowerCase().contains(
                        title!.toLowerCase())).toList();

                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: GridView(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 300,
                    ),
                    children: filteredData
                        .mapIndexed(
                          (currentValue, index) =>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                filteredData[index]['p_imgs'][0],
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              const Spacer(),
                              //to get all available space
                              "${filteredData[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${filteredData[index]['p_price']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .outerShadowMd
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(12))
                              .roundedSM
                              .make()
                              .onTap(() {
                            //     make changes as not loading initially that is needs time->use lazyput
                            Get.to(() =>
                                ItemDetails(
                                  title: "${filteredData[index]['p_name']}",
                                  data: filteredData[index],
                                ));
                          }),
                    )
                        .toList(),
                  ),
                );
              }
            }));
  }
}
