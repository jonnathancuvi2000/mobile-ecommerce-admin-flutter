import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/components/Grafic.dart';
import 'package:ecommerce_admin/components/Header.dart';
import 'package:ecommerce_admin/components/HeaderDashBoard.dart';
import 'package:ecommerce_admin/components/InfoItems.dart';
import 'package:ecommerce_admin/components/MyFiles.dart';
import 'package:ecommerce_admin/components/loanding.dart';
import 'package:ecommerce_admin/db/product.dart';
import 'package:ecommerce_admin/pages/UpdateProduct.dart';
import 'package:ecommerce_admin/utils/constants.dart';
import 'package:ecommerce_admin/utils/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/BarSideRight.dart';
import '../pages/ListarProductos.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  // services, getting data from Data Base
  ProductService _productService = ProductService();

  // saving the data from DB
  var products = [];

  // loanding
  bool isLoanding = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProducts().then((result) {
      setState(() {
        products = result;
        isLoanding = false;
        // print(products.length);
        // for (var doc in products) {
        //   // print(doc.reference.id);
        //   print(doc.reference.id);
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: bgColor,
      child: Column(
        children: [
          // header
          Header(
            titulo: "Productos",
          ),
          SizedBox(
            height: 10,
          ),
          // container of products
          isLoanding
              ? Loanding()
              : Expanded(
                  flex: 5,
                  child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          // images
                          Container(
                            height: 90,
                            width: 100,
                            margin: EdgeInsets.only(top: 20, bottom: 15),
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                width: 1.5,
                                color: Colors.white,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                products[index]['imageUrl'].toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          // name product
                          Container(
                            alignment: Alignment.center,
                            width: 200,
                            margin: EdgeInsets.all(5),
                            child: Text(
                              "${products[index]['name']}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 40,
                            margin: EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              child: Text(
                                "${products[index]['description']}",
                                // overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          // update and delete
                          Container(
                            width: 200,
                            margin: EdgeInsets.only(top: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => UpdateProduct(
                                              id: "${products[index].reference.id}",
                                              product: products[index]),
                                        ));
                                  },
                                  child: Icon(
                                    CupertinoIcons.cloud_upload,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _deleteProduct(
                                        products[index].reference.id);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  _getProducts() async {
    List<DocumentSnapshot> dataProducts = await _productService.getProducts();
    return dataProducts;
  }

  void _deleteProduct(id) {
    var alert = AlertDialog(
      content: Form(
        child: Text(
            // ignore: prefer_interpolation_to_compose_strings
            'Esta seguro de que desea eleminar el producto con el siguinete ID: ' +
                id),
      ),
      actions: <Widget>[
        TextButton.icon(
          onPressed: () {
            _productService.deleteProduct(id: id);
            Fluttertoast.showToast(msg: "Producto Actualizado Correctamente");
            // // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ListarProductos()),
            );
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => const ListarProductos()),
            //   (Route<dynamic> route) => false,
            // );
          },
          icon: const Icon(Icons.delete),
          label: const Text('Eliminar Producto'),
        ),
        TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.cancel),
          label: const Text("Cancelar"),
        ),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }
}
