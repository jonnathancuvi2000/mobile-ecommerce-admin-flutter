import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ProductService {
  CollectionReference Product =
      FirebaseFirestore.instance.collection('products');

  void uploadProduct({
    required String productName,
    required double price,
    required int quantity,
    required String description,
    required String category,
    required String brand,
    required String urlImage,
  }) async {
    await Product.add({
      'name': productName,
      'price': price,
      'quantity': quantity,
      'description': description,
      'category': category,
      'brand': brand,
      'imageUrl': urlImage,
    })
        .then((value) => print("Product Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<List<DocumentSnapshot>> getProducts() async {
    QuerySnapshot products = await Product.get();
    return products.docs;
  }

  void updateProduct({
    required String idProduct,
    required String productName,
    required double price,
    required int quantity,
    required String description,
    required String category,
    required String brand,
    required String urlImage,
  }) async {
    await Product.doc(idProduct)
        .update({
          'name': productName,
          'price': price,
          'quantity': quantity,
          'description': description,
          'category': category,
          'brand': brand,
          'imageUrl': urlImage,
        })
        .then((value) => print("Product Updated"))
        .catchError((error) => print("Failed to UDATE the data: $error"));
  }

  void deleteProduct({required String id}) async {
    await Product.doc(id).delete();
  }
}
