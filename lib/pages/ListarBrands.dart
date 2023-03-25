import 'package:ecommerce_admin/components/Brands.dart';
import 'package:ecommerce_admin/components/Products.dart';
import 'package:ecommerce_admin/utils/responsive.dart';
import 'package:flutter/material.dart';

import '../components/SideMenu.dart';

class ListarBrands extends StatefulWidget {
  const ListarBrands({super.key});

  @override
  State<ListarBrands> createState() => _ListarProductosState();
}

class _ListarProductosState extends State<ListarBrands> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // we want thsi side mane only for large
          if (Responsive.isDesktop(context))
            Expanded(
              child: SideMenu(),
            ),
          Expanded(
            flex: 5,
            child: Brands(),
          ),
        ],
      ),
    );
  }
}
