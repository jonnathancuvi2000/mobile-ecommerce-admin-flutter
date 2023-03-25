import 'package:ecommerce_admin/components/ProfileCard.dart';
import 'package:ecommerce_admin/conotrollers/MenuController.dart';
import 'package:ecommerce_admin/utils/constants.dart';
import 'package:ecommerce_admin/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderDashBoard extends StatelessWidget {
  const HeaderDashBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
              onPressed: context.read<MenuController>().controlMenu,
              icon: Icon(Icons.menu)),
        if (!Responsive.isMobile(context))
          Text(
            "DashBoard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(
            flex: Responsive.isDesktop(context) ? 2 : 1,
          ),
        Expanded(child: SearchFild()),
        ProfileCard() // este codigo estaba aqui antes
      ],
    );
  }
}

class SearchFild extends StatelessWidget {
  const SearchFild({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Buscar",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        suffix: Container(
          child: Icon(Icons.search_rounded),
        ),
      ),
    );
  }
}
