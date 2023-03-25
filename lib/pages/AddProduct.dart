import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/components/loanding.dart';
import 'package:ecommerce_admin/db/product.dart';
import 'package:ecommerce_admin/pages/ListarProductos.dart';
import 'package:ecommerce_admin/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../db/category.dart';
import '../db/brand.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPrecioController = TextEditingController();
  TextEditingController productCantidadController = TextEditingController();
  List<DocumentSnapshot> brands =
      <DocumentSnapshot>[]; // we get the data forn the DB and seve here
  List<DocumentSnapshot> categories =
      <DocumentSnapshot>[]; // we get the data forn the DB and seve here
  // this will contain teh list dropdown
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currenteCategory = 'state';
  String _currenteBrand = 'state';
  // we instantiate the categories and brands DB (SERVICES)
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();
  ProductService _productService = ProductService();
  // image
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  String imageUrlString = '';
  // loanding
  bool isLoanding = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategories().then((result) {
      setState(() {
        categories = result;
        categoriesDropDown = getCategoriesDropDown();
        _currenteCategory = categories[0][
            'categoryName']; // we save tha first element that we have in "categories" to show it in the "dropdown"
      });
    });
    // link -> https://www.youtube.com/watch?v=yhjDTxH9a4g&list=PLmnT6naTGy2SC82FMSCrvZNogg5T1H7iF&index=34
    // in the minute 42 he fix the mistake that I had a in the video of the link up
    _getBrands().then((resultBrands) {
      setState(() {
        brands = resultBrands;
        brandsDropDown = getBrandsDropDown();
        _currenteBrand = brands[0][
            'BrandName']; // we save tha first element that we have in "categories" to show it in the "dropdown"
      });
    });
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    for (int i = 0; i < categories.length; i++) {
      items.insert(
        0,
        DropdownMenuItem(
          child: Text(categories[i]['categoryName']),
          value: categories[i]['categoryName'],
        ),
      );
    }
    // for (DocumentSnapshot category in categories) {
    //   // print(category['categoryName']);
    //   items.add(
    //     new DropdownMenuItem(
    //       child: Text(category['categoryName']),
    //       value: category['categoryName'],
    //     ),
    //   );
    // }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = <DropdownMenuItem<String>>[];
    for (int i = 0; i < brands.length; i++) {
      items.insert(
        0,
        DropdownMenuItem(
          child: Text(brands[i]['BrandName']),
          value: brands[i]['BrandName'],
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    // size of the screen
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: secondaryColor,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Agregar Producto"),
      ),
      body: isLoanding
          ? Loanding()
          : ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: defaultPadding,
                      horizontal: MediaQuery.of(context).size.width / 3.5),
                  padding: EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // image
                      GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: size.width > 640 ? 120 : size.width * 0.45,
                            width: size.width > 640 ? 120 : size.width * 0.45,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1.5,
                                color: Colors.white,
                              ),
                            ),
                            child: _pickedImage == null
                                ? Icon(Icons.add_a_photo)
                                : kIsWeb
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.memory(webImage,
                                            fit: BoxFit.fill),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          _pickedImage!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                          ),
                        ),
                      ),
                      // name
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          controller: productNameController,
                          decoration: InputDecoration(
                            hintText: "Nombre del Producto",
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Porfavor ingrese el nombre del producto';
                            }
                          },
                        ),
                      ),
                      // price and quantity
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // quantity
                          Container(
                            width: MediaQuery.of(context).size.width / 5,
                            margin: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: productCantidadController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Cantidad',
                                hintText: "Cantidad",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.blueAccent),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Porfavor ingrese el nombre del producto';
                                }
                              },
                            ),
                          ),
                          // price
                          Container(
                            width: MediaQuery.of(context).size.width / 5,
                            margin: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: productPrecioController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Precio',
                                hintText: "Precio",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.blueAccent),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Porfavor ingrese el nombre del producto';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      // description
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          maxLines: 4,
                          controller: productDescriptionController,
                          decoration: InputDecoration(
                            hintText: "Descripcion del Producto",
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Porfavor ingrese el nombre del producto';
                            }
                          },
                        ),
                      ),
                      // dropDwon:category and brand
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(0.8),
                                  child: Text(
                                    "Categoria:",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: defaultPadding),
                                  child: DropdownButton(
                                    value: _currenteCategory,
                                    items: categoriesDropDown,
                                    onChanged: (value) {
                                      changeSelectedCategory(value!);
                                    },
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(0.8),
                                  child: Text(
                                    "Ramas:",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: defaultPadding),
                                  child: DropdownButton(
                                    value: _currenteBrand,
                                    items: brandsDropDown,
                                    onChanged: (value) {
                                      changeSelectedBrand(value!);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // button
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: ElevatedButton.icon(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: defaultPadding * 1.5,
                              vertical: defaultPadding,
                            ),
                          ),
                          onPressed: () {
                            saveProduct();
                          },
                          icon: Icon(Icons.add),
                          label: Text('Agregar Producto'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // image Picker
  Future<void> _pickImage() async {
    if (!kIsWeb) {
      // if is not web
      final ImagePicker _piker = ImagePicker();
      XFile? image = await _piker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        // we get the image path
        var selected = File(image.path);
        setState(() {
          imageUrlString = image.path; // we save the url file in a string
          _pickedImage = selected;
        });
      } else {
        print('No image MOBILE has been picked');
      }
    } else if (kIsWeb) {
      // if is web
      final ImagePicker _piker = ImagePicker();
      XFile? image = await _piker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          imageUrlString = image.path; // we save the url file in a string
          webImage = f;
          // we add this to aboid error, because the vaiable is going to be empty
          _pickedImage = File(image.path);
        });
      } else {
        print('No image WEB has been picked');
      }
    } else {
      print('Something went wrong trying to get the IMAGE');
    }
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategorias();
    // for (var doc in data) {
    //   print(doc.data());
    // }
    return data;
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getRamas();
    // for (var doc in data) {
    //   print(doc.data());
    // }
    return data;
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currenteCategory = selectedCategory);
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() => _currenteBrand = selectedBrand);
  }

  void saveProduct() async {
    setState(() {
      isLoanding = true;
    });
    // I found the solution to upload images here -> https://stackoverflow.com/questions/59716944/flutter-web-upload-image-file-to-firebase-storage
    try {
      String fileName = imageUrlString.split('/').last;
      FirebaseStorage fs = await FirebaseStorage.instance;
      var snapshot = await fs
          .ref()
          .child("documents/images/$fileName.png")
          .putData(webImage);
      var dowloandUrl = await snapshot.ref.getDownloadURL();

      _productService.uploadProduct(
        productName: productNameController.text.trim(),
        price: double.parse(productPrecioController.text.trim()),
        quantity: int.parse(productCantidadController.text.trim()),
        description: productDescriptionController.text.trim(),
        brand: _currenteBrand,
        category: _currenteCategory,
        urlImage: dowloandUrl,
      );

      setState(() {
        isLoanding = false;
      });

      Fluttertoast.showToast(msg: "Producto Agregado Correctamente");
      // Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ListarProductos()),
      );
    } catch (e) {
      setState(() {
        isLoanding = false;
      });
      print(e);
      Fluttertoast.showToast(msg: "Algo salio mal: $e");
    }
  }
}
