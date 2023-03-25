import 'package:ecommerce_admin/components/HeaderDashBoard.dart';
import 'package:ecommerce_admin/components/ProfileCard.dart';
import 'package:ecommerce_admin/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context)) Icon(Icons.menu),
        if (!Responsive.isDesktop(context))
          SizedBox(width: 20),
        Text(
          "$titulo",
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
