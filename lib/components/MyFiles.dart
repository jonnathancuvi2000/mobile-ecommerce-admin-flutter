import 'package:ecommerce_admin/components/BarSideRight.dart';
import 'package:ecommerce_admin/components/FilterInfoCard.dart';
import 'package:ecommerce_admin/utils/constants.dart';
import 'package:ecommerce_admin/utils/responsive.dart';
import 'package:flutter/material.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  var lista = [
    {"titulo": "Usuarios"},
    {"titulo": "Categorias"},
    {"titulo": "Categoras"},
    {"titulo": "Productos"},
    {"titulo": "Vendidos"},
    {"titulo": "Ordenes"},
    {"titulo": "Regresado"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Informacion",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical: defaultPadding,
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text('Agregar Nuevo'),
            ),
          ],
        ),
        SizedBox(
          height: defaultPadding,
        ),
        FIleInfoCardWidget(lista: lista),
      ],
    );
  }
}

class FIleInfoCardWidget extends StatelessWidget {
  const FIleInfoCardWidget({
    Key? key,
    required this.lista,
    this.crossAxisCount = 4,
    this.childAspectRatio = 2,
  }) : super(key: key);

  final List<Map<String, String>> lista;

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: lista.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        // childAspectRatio: childAspectRatio,
        mainAxisSpacing: defaultPadding,
      ),
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          FilterInfoCard(titulo: "${lista[index]['titulo']}"),
    );
  }
}
