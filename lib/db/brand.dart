import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';

class BrandService {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference Brand = FirebaseFirestore.instance.collection('brands');

  void createBrand(String name) async {
    var id = Uuid();
    String BrandId = id.v1();
    print(BrandId);

    await Brand.add({'BrandName': name})
        .then((value) => print("Brand Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void getBrands() async {
    QuerySnapshot brands = await Brand.get();

    if (brands.docs.length != 0) {
      for (var doc in brands.docs) {
        print(doc.data());
      }
    } else {
      print('We could not get the data from FIRABASE');
    }
  }

  Future<List<DocumentSnapshot>> getRamas() async {
    QuerySnapshot brands = await Brand.get();
    print(brands.docs);
    return brands.docs;
  }
}
