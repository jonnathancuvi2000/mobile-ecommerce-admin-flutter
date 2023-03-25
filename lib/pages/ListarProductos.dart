import 'package:ecommerce_admin/components/Products.dart';
import 'package:ecommerce_admin/utils/responsive.dart';
import 'package:flutter/material.dart';

import '../components/SideMenu.dart';

class ListarProductos extends StatefulWidget {
  const ListarProductos({super.key});

  @override
  State<ListarProductos> createState() => _ListarProductosState();
}

class _ListarProductosState extends State<ListarProductos> {
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
            child: Products(),
          ),
        ],
      ),
    );
  }
}
