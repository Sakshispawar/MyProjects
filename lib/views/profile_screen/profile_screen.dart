import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controller/Profile_controller.dart';
import 'package:emart_app/controller/auth_contoller.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/chat_screen/messaging_screen.dart';
import 'package:emart_app/views/orders_screen/orders_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/loading_indicator.dart';
import 'package:emart_app/wishlist_screen/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/firestore_services.dart';
import 'components/details_card.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FireStoreServices.getUSer(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: "Empty Profile".text.color(darkFontGrey).make(),
                    );
                  } else {
                    // to save received data of single user
                    var data = snapshot.data!.docs[0];
                    print(snapshot.data!.docs.length);
                    return SafeArea(
                        child: Column(
                      children: [
                        // edit profile btn
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.edit,
                                color: whiteColor,
                              )).onTap(() {
                            // to save changes ignoring same data by rebuilt widget in profile
                            controller.nameController.text = data['name'];

                            Get.to(() => EditProfileScreen(data: data));
                          }),
                        ),
                        // users details section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              data["imageUrl"] == ''
                                  ? Image.asset(
                                      manProfile,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make()
                                  : Image.network(
                                      data['imageUrl'],
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make(),
                              10.widthBox,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make(),
                                  "${data['name']}".text.white.make(),
                                ],
                              )),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: whiteColor,
                                  ),
                                ),
                                onPressed: () async {
                                  await Get.put(AuthController())
                                      .signoutMethod(context: context);
                                  Get.offAll(() => const LoginScreen());
                                },
                                child: logout.text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                              ),
                            ],
                          ),
                        ),
                        20.heightBox,
                        FutureBuilder(
                            future: FireStoreServices.getCounts(),
                            builder: (BuildContext context,
                                AsyncSnapshot snapshot) {
                              if(!snapshot.hasData){
                                return Center(child:loadingIndicator());
                              }
                              else
                              {
                                var countData=snapshot.data;
                                return Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    detailsCard(
                                        count: countData[0].toString(),
                                        title: "in your cart",
                                        width: context.screenWidth / 3.4),
                                    detailsCard(
                                        count: countData[1].toString(),
                                        title: "in your wishlist",
                                        width: context.screenWidth / 3.2),
                                    detailsCard(
                                        count: countData[2].toString(),
                                        title: "your orders",
                                        width: context.screenWidth / 3.4),
                                  ],
                                );
                              }
                            }),

                        // btns section
                        ListView.separated(
                                itemCount: profileButtonsList.length,
                                shrinkWrap: true, //as in column
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: lightGrey,
                                  );
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    onTap: () {
                                      //   open tabs according to index using switch
                                      switch (index) {
                                        case 0:
                                          Get.to(() => const OrdersScreen());
                                          break;
                                        case 1:
                                          Get.to(() => const WishlistScreen());
                                          break;
                                        case 2:
                                          Get.to(() => const MessagesScreen());
                                          break;
                                      }
                                    },
                                    leading: Image.asset(
                                      profileButtonsIcon[index],
                                      width: 20,
                                    ),
                                    title: profileButtonsList[index]
                                        .text
                                        .color(darkFontGrey)
                                        .fontFamily(bold)
                                        .make(),
                                  );
                                })
                            .box
                            .white
                            .rounded
                            .margin(const EdgeInsets.all(12))
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .shadowSm
                            .make()
                            .box
                            .color(redColor)
                            .make(),
                      ],
                    ));
                  }
                })));
  }
}
