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

class Brands extends StatefulWidget {
  const Brands({super.key});

  @override
  State<Brands> createState() => _ProductsState();
}

class _ProductsState extends State<Brands> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: bgColor,
      child: Column(
        children: const [
          // header
          Header(titulo: "Ramas",),
          SizedBox(
            height: 10,
          ),
          // container of Brands
          Expanded(
            flex: 5,
            child: Text(
              "Brands",
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
