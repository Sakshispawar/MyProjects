import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;//for time

Widget senderBubble(DocumentSnapshot data) {
  var t=data['created_on']==null?DateTime.now():data['created_on'].toDate();
  var time=intl.DateFormat("h:mma").format(t);

  return Directionality(
    // textDirection: data['uid']==currentUser!.uid?TextDirection.ltr:TextDirection.rtl,
    textDirection: TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration:  BoxDecoration(
          color: data['uid']==currentUser!.uid?redColor:darkFontGrey,
          borderRadius:const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.white.size(16).make(),
          10.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).size(16).make(),
        ],
      ),
    ),
  );
}
