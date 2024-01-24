import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget ourButton({onPress,bgcolor,textColor,title}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: bgcolor,padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: title.toString().text.color(textColor).fontFamily(bold).make(),
  );
}
