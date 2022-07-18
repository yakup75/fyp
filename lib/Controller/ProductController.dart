import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../Models/ProductModel.dart';

class ProductController extends GetxController{
  FirebaseFirestore fireStore=FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  TextEditingController name=new TextEditingController();
  TextEditingController category=new TextEditingController();
  TextEditingController modelUrl=new TextEditingController();
  TextEditingController description=new TextEditingController();
  TextEditingController price=new TextEditingController();
  RxList<ProductModel> products=RxList<ProductModel>([]);
  var prodName=''.obs;
  var prodDesc=''.obs;
  var prodModelUrl=''.obs;
  var prodPrice=''.obs;
  RxList categories=[].obs;

  
  @override
  void onInit(){
    super.onInit();
    collectionReference=fireStore.collection('products');
    products.bindStream(getAllProducts());

  }
  Stream<List<ProductModel>> getAllProducts()=>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item)).toList());
// Future getData(String collection) async{
//     QuerySnapshot snapshot=
//         await fireStore.collection(collection).get();
//     return snapshot.docs;
// }


  Future<void> addProduct() {
    // Calling the collection to add a new user
    var productId=const Uuid().v1();
    final data = {
      'name': name.text,
      'description': description.text,
      'modelUrl': modelUrl.text,
      'category':category.text,
      'price':price.text,
      'productId': productId
    };
    return collectionReference.doc(productId)
    //adding to firebase collection
        .set(data)
        .then((value) => Get.snackbar('Success', 'Product Added Successfully',backgroundColor: Colors.green))
        .catchError((error) =>Get.snackbar('Error', '$error',backgroundColor: Colors.red));
  }

//For setting a specific document ID use .set instead of .add
//   users.doc(documentId).set({
//   //Data added in the form of a dictionary into the document.
//   'full_name': fullName,
//   'grade': grade,
//   'age': age
// });


//For updating docs, you can use this function.
// Future<void> updateUser() {
//   return collectionReference
//   //referring to document ID, this can be queried or named when added accordingly
//       .doc(documentId)
//   //updating grade value of a specific student
//       .update({'grade': newGrade})
//       .then((value) => print("Student data Updated"))
//       .catchError((error) => print("Failed to update data"));
// }
}