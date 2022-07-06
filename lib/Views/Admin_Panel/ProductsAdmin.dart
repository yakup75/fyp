import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsAdmin extends StatefulWidget {
  const ProductsAdmin({Key? key}) : super(key: key);

  @override
  State<ProductsAdmin> createState() => _ProductsAdminState();
}

class _ProductsAdminState extends State<ProductsAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
    );
  }
}
