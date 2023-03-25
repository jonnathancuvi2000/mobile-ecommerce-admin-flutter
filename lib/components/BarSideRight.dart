import 'package:ecommerce_admin/components/Grafic.dart';
import 'package:ecommerce_admin/components/InfoItems.dart';
import 'package:ecommerce_admin/utils/constants.dart';
import 'package:flutter/material.dart';

// https://firebase.google.com/docs/storage/flutter/create-reference
class BarSideRight extends StatelessWidget {
  const BarSideRight({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        height: 500,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Text(
              "Detalles",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            SizedBox(
              height: 200,
              child: Grafic(),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InfoItems(
                        title: "Datos Productos",
                        numData: 20,
                        icon: Icons.file_copy_outlined),
                    InfoItems(
                        title: "Datos Productos",
                        numData: 20,
                        icon: Icons.file_copy_outlined),
                    InfoItems(
                        title: "Datos Productos",
                        numData: 20,
                        icon: Icons.file_copy_outlined),
                    InfoItems(
                        title: "Datos Productos",
                        numData: 20,
                        icon: Icons.file_copy_outlined),
                    InfoItems(
                        title: "Datos Productos",
                        numData: 20,
                        icon: Icons.file_copy_outlined),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
