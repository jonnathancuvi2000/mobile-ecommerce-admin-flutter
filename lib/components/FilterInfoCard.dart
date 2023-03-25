import 'package:ecommerce_admin/utils/constants.dart';
import 'package:flutter/material.dart';

class FilterInfoCard extends StatelessWidget {
  const FilterInfoCard({
    Key? key, required this.titulo,
  }) : super(key: key);

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // padding: EdgeInsets.all(defaultPadding * 0.15),
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.blue[400]?.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(Icons.add),
              ),
              Icon(
                Icons.more_vert,
                color: Colors.white54,
              )
            ],
          ),
          Container(
            alignment: Alignment.center,
            // padding: EdgeInsets.all(defaultPadding),
            // height: 75,
            width: double.infinity,
            // color: Colors.blue,
            child: Text(titulo,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}
