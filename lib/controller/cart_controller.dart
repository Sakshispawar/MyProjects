import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  // text controllers fro shipping info
  var addressController=TextEditingController();
  var cityController=TextEditingController();
  var stateController=TextEditingController();
  var postalController=TextEditingController();
  var phoneController=TextEditingController();



  calculate(data) {
    totalP.value = 0; //instantiate whenever called
    for (int i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }
}
