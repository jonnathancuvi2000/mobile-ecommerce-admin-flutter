import 'package:ecommerce_admin/pages/AddProduct.dart';
import 'package:ecommerce_admin/pages/ListarBrands.dart';
import 'package:ecommerce_admin/pages/ListarCategories.dart';
import 'package:ecommerce_admin/pages/ListarProductos.dart';
import 'package:flutter/material.dart';
import 'DrawerListTitle.dart';
import '../db/category.dart';
import '../db/brand.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  BrandService _brandService = BrandService();
  CategoryService _categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Container(
                child: FittedBox(
                  child: Icon(
                    Icons.admin_panel_settings,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            DrawerListTitle(
                title: "Home",
                press: (() {
                  // goint to the home page -> https://stackoverflow.com/questions/51556259/flutter-return-to-home-page
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }),
                icon: Icons.home),
            DrawerListTitle(
                title: "Agregar Producto",
                press: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddProduct()),
                  );
                }),
                icon: Icons.add),
            DrawerListTitle(
                title: "Lista de Productos",
                press: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ListarProductos()),
                  );
                }),
                icon: Icons.list_alt),
            DrawerListTitle(
                title: "Agregar Categoria",
                press: (() {
                  _categoryAlert();
                }),
                icon: Icons.add_box),
            DrawerListTitle(
                title: "Lista de Categorias",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ListarCategories()),
                  );
                },
                icon: Icons.list_sharp),
            DrawerListTitle(
                title: "Agragar Rama",
                press: () {
                  _branAlert();
                },
                icon: Icons.add_box_sharp),
            DrawerListTitle(
                title: "Lista Ramas",
                press: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ListarBrands()),
                  );
                }),
                icon: Icons.list_outlined),
          ],
        ),
      ),
    );
  }

  void _categoryAlert() {
    // ignore: unnecessary_new
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Porfavor ingrese texto';
            }
          },
          decoration: InputDecoration(hintText: "Agregar una Categoria"),
        ),
      ),
      actions: <Widget>[
        TextButton.icon(
            onPressed: () {
              if (categoryController.text.trim() != null) {
                print(categoryController.text.trim());
                _categoryService.createCategory(categoryController.text.trim());
              }
              Fluttertoast.showToast(msg: "Categoria Creada");
              Navigator.pop(context);
            },
            icon: Icon(Icons.add),
            label: Text("Agregar")),
        TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text("Cancelar")),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }

  void _branAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Porfavor ingrese la rama';
            }
          },
          decoration: InputDecoration(hintText: "Agregar una Rama"),
        ),
      ),
      actions: <Widget>[
        TextButton.icon(
            onPressed: () {
              if (brandController.text.trim() != null) {
                print(brandController.text.trim());
                _brandService.createBrand(brandController.text.trim());
              }
              Fluttertoast.showToast(msg: "Rama Creada");
              Navigator.pop(context);
            },
            icon: Icon(Icons.add),
            label: Text("Agregar")),
        TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
            label: Text("Cancelar")),
      ],
    );

    showDialog(context: context, builder: (_) => alert);
  }
}
