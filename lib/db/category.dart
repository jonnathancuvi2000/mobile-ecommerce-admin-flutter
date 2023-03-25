import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';

class CategoryService {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference category =
      FirebaseFirestore.instance.collection('categories');

  // this is was nont eorking, I just updated and worked -> link Totorial: https://stackoverflow.com/questions/71521564/chromeproxyservice-failed-to-evaluate-expression-handleprimarypointerinterna
  void createCategory(String name) async {
    var id = Uuid();
    String categoryId = id.v1();
    print("catory ID: " + categoryId);

    await category
        .add({'categoryName': name})
        .then((value) => print("Category Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // this is working too, but I am not using it -> link Totorial: https://www.youtube.com/watch?v=ErP_xomHKTw
  void addNewCategory(String name) async {
    var id = Uuid();
    String categoryId = id.v1();
    final docCategory =
        FirebaseFirestore.instance.collection("categories").doc(categoryId);
    await docCategory.set({
      'categoryName': name,
    });
  }

  void getCategories() async {
    QuerySnapshot categories = await category.get();

    if (categories.docs.length != 0) {
      for (var doc in categories.docs) {
        print(doc.data());
      }
    } else {
      print('We could not get the data from FIRABASE');
    }
  }

  Future<List<DocumentSnapshot>> getCategorias() async {
    QuerySnapshot categories = await category.get();
    return categories.docs;
  }
}
