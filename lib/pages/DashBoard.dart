import 'package:ecommerce_admin/components/Grafic.dart';
import 'package:ecommerce_admin/components/HeaderDashBoard.dart';
import 'package:ecommerce_admin/components/InfoItems.dart';
import 'package:ecommerce_admin/components/MyFiles.dart';
import 'package:ecommerce_admin/utils/constants.dart';
import 'package:ecommerce_admin/utils/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/BarSideRight.dart';

class DaschBoardScreen extends StatelessWidget {
  const DaschBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            HeaderDashBoard(),
            SizedBox(
              height: defaultPadding,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: MyFiles(),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(
                    width: defaultPadding,
                  ),
                // if (!Responsive.isMobile(context))
                //   BarSideRight(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

