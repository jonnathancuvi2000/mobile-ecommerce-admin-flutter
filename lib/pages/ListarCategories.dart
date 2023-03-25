import 'package:ecommerce_admin/components/Categories.dart';
import 'package:ecommerce_admin/components/Products.dart';
import 'package:ecommerce_admin/utils/responsive.dart';
import 'package:flutter/material.dart';

import '../components/SideMenu.dart';

class ListarCategories extends StatefulWidget {
  const ListarCategories({super.key});

  @override
  State<ListarCategories> createState() => _ListarProductosState();
}

class _ListarProductosState extends State<ListarCategories> {
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
            child: Categories(),
          ),
        ],
      ),
    );
  }
}
