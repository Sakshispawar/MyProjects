import 'package:flutter/cupertino.dart';

import '../consts/consts.dart';

// parameterized
Widget bgWidget(
{  Widget?child}
    ){
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage(imgBackground),fit: BoxFit.fill)
    ),
    child: child,
  );
}