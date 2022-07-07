import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Controller/ProductController.dart';
import 'package:get/get.dart';

import '../../Widgets/Button.dart';
import '../../Widgets/TextField.dart';

class UploadData extends StatefulWidget {
  const UploadData({Key? key}) : super(key: key);

  @override
  State<UploadData> createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  ProductController product = Get.find();
  var args = Get.arguments;
  var index;
  var name;
  var price;
  var modelUrl;
  var category;
  var productId;
  var description;

  bool get isEditing => index != 'null';

  @override
  void initState() {
    super.initState();
    index = args[0];
    if (isEditing) {
      name = args[1];
      price = args[2];
      productId = args[3];
      modelUrl = args[4];
      category = args[5];
      description = args[6];
      product.name.text = name;
      product.category.text = category;
      product.modelUrl.text = modelUrl;
      product.price.text = price;
      product.description.text = description;
    } else {
      product.name.text = '';
      product.category.text = '';
      product.modelUrl.text = '';
      product.price.text = '';
      product.description.text = '';
    }
  }

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isEditing ? 'Update Product' : 'Add Product',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  CustomTextField(
                    controllers: product.name,
                    labelText: 'Product Name',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Value cant be null";
                      }
                    },
                  ),
                  CustomTextField(
                    controllers: product.category,
                    labelText: 'Category',
                  ),
                  CustomTextField(
                    controllers: product.modelUrl,
                    labelText: 'Model Url',
                  ),
                  CustomTextField(
                    controllers: product.price,
                    labelText: 'Price',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      controller: product.description,
                      maxLines: 3,
                      style: TextStyle(),
                      decoration: InputDecoration(
                        labelText: 'Product Description',
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  UploadDataButton(
                    text: 'Upload',
                    onPressed: () async {
                      if (key.currentState!.validate()) {
                        if (isEditing) {
                          final data = {
                            'name': product.name.text,
                            'description': product.description.text,
                            'modelUrl': product.modelUrl.text,
                            'category': product.category.text,
                            'price': product.price.text,
                            'productId': productId
                          };
                          await FirebaseFirestore.instance
                              .collection('products')
                              .doc(productId)
                              .update(data);
                        } else {
                          product.addProduct();
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  UploadDataButton(
                      text: 'Delete',
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('products')
                            .doc(productId)
                            .delete();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
