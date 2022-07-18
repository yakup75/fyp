import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Controller/ProductController.dart';
import 'package:fyp/Views/Admin_Panel/ProductsAdmin.dart';
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
                        return "Field Required";
                      }
                    },
                  ),
                  // DropdownButton<String>(
                  //   focusColor: Colors.white,
                  //   value: product.category.text,
                  //   //elevation: 5,
                  //
                  //
                  //   items: <String>[product.categories.value.toString()]
                  //       .map<DropdownMenuItem<String>>((String value) {
                  //     return DropdownMenuItem<String>(
                  //       value: value,
                  //       child: Text(
                  //         value,
                  //         style: const  TextStyle(fontSize: 18),
                  //       ),
                  //     );
                  //   }).toList(),
                  //   onChanged: (String? value) {
                  //     setState(() {
                  //       product.category.text = value.toString();
                  //     });
                  //   },
                  // ),
                  // DropdownButtonFormField(
                  //
                  //   decoration: InputDecoration(
                  //
                  //     border: OutlineInputBorder(
                  //       borderRadius: const BorderRadius.all(
                  //         const Radius.circular(10.0),
                  //       ),
                  //     ),
                  //     filled: true,
                  //     hintStyle: TextStyle(color: Colors.grey[800]),
                  //     labelText: "Customer",
                  //   ),
                  //
                  //   items: product.categories.value.map((itms) {
                  //     return new DropdownMenuItem(
                  //       onTap: () {
                  //         product.category.text = itms;
                  //         print(product.category.text);
                  //       },
                  //       child: new Text(itms,
                  //       ),
                  //       value: itms.toString(),
                  //     );
                  //   }).toList(),
                  //   onChanged: (itm) {
                  //     setState(() {
                  //       product.category.text = itm as String;
                  //
                  //       print(product.category.text);
                  //     });
                  //   },
                  //   value: product.category.text,
                  //
                  // ),
                  CustomTextField(
                    controllers: product.category,
                    labelText: 'Category', validator: (val) {
                    if (val!.isEmpty) {
                      return "Field Required";
                    }
                  },
                  ),
                  CustomTextField(
                    controllers: product.modelUrl,
                    labelText: 'Model Url', validator: (val) {
                    if (val!.isEmpty) {
                      return "Field Required";
                    }
                  },
                  ),
                  CustomTextField(
                    controllers: product.price,
                    labelText: 'Price', validator: (val) {
                    if (val!.isEmpty) {
                      return "Field Required";
                    }
                  },
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
                    height: 20,
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
                          Get.snackbar('Successful', 'Product Updated Successfully',duration: const Duration(seconds: 2),backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM);

                        } else {
                          product.addProduct();
                          Get.snackbar('Successful', 'Product Added Successfully',duration: const Duration(seconds: 2),backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM);

                        }
                        Get.off(ProductsAdmin());
                      }
                    },
                  ),

                  Builder(
                    builder: (context) {
                      if(isEditing){
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                        ),
                          onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('products')
                            .doc(productId)
                            .delete();
                        Get.off(ProductsAdmin());
                      }, child: Text('Delete'));
                    }
                      else{
                        return Text('');
                      }
                    }
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
