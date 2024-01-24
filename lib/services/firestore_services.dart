import 'package:emart_app/consts/consts.dart';


class FireStoreServices {
  // get users data
  static getUSer(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

//   get products according to category
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

// get cart
  static getCart(uid) {
    return firestore
        .collection(cardCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  //delete document
  static deleteDocument(docId) {
    firestore.collection(cardCollection).doc(docId).delete();
  }

//get all chat messages
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }
}
