import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var totalPrice = 0.obs;

  // color chose
  var colorIndex = 0.obs;
  var subcat = [];

  // wishlist
  var isFav = false.obs;

  getSubCategories(title) async {
    subcat.clear(); //to initialize for every category
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = dmartCategoryModelFromJson(data);
    // to filter by title
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e); //add all subcat under title
    }
  }

  changeColorIndex(index) {
    colorIndex(index);
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) quantity.value++;
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, sellerName, color, qty, tprice, context}) async {
    await firestore.collection(cardCollection).doc().set({
      'title': title,
      'img': img,
      'sellerName': sellerName,
      'color': color,
      'qty': qty,
      'tprice': tprice,
      'added_by': currentUser!.uid,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  addToWishList(docId,context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to Wishlist");
  }

  removeFromWishList(docId,context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from Wishlist");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
