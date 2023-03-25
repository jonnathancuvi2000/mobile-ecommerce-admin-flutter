import 'package:ecommerce_admin/components/Grafic.dart';
import 'package:ecommerce_admin/components/Header.dart';
import 'package:ecommerce_admin/components/HeaderDashBoard.dart';
import 'package:ecommerce_admin/components/InfoItems.dart';
import 'package:ecommerce_admin/components/MyFiles.dart';
import 'package:ecommerce_admin/pages/UpdateProduct.dart';
import 'package:ecommerce_admin/utils/constants.dart';
import 'package:ecommerce_admin/utils/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/BarSideRight.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _ProductsState();
}

class _ProductsState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: bgColor,
      child: Column(
        children: const [
          // header
          Header(titulo: "Categorias"),
          SizedBox(
            height: 10,
          ),
          // container of Categories
          Expanded(
            flex: 5,
            child: Text(
              "Categories",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
