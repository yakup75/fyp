import 'package:flutter/material.dart';
import 'package:fyp/Controller/ProductController.dart';
import 'package:get/get.dart';

import '../Widgets/Button.dart';
import '../Widgets/TextField.dart';

class UploadData extends StatefulWidget {
  const UploadData({Key? key}) : super(key: key);

  @override
  State<UploadData> createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  ProductController product=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Upload Data',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              CustomTextField(
                controllers: product.name,
                labelText: 'Product Name',
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
                  decoration: InputDecoration(labelText: 'Product Description',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                  ),

                ),
              ),
              SizedBox(height: 50,),
            UploadDataButton(text: 'Upload Data',
        onPressed: (){
              product.addProduct();
        },)
            ],
          ),
        ),
      ),
    );
  }
}
