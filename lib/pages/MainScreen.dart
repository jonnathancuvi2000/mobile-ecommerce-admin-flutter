import 'package:ecommerce_admin/components/DrawerListTitle.dart';
import 'package:ecommerce_admin/conotrollers/MenuController.dart';
import 'package:ecommerce_admin/pages/DashBoard.dart';
import 'package:ecommerce_admin/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../components/SideMenu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
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
              child: DaschBoardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
