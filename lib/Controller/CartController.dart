import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fyp/Widgets/Constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


class CartController extends GetxController{

  RxMap cartMap={}.obs;
  RxDouble totalAmount=0.0.obs;
  RxList cartList=[].obs;
  var cartLen=0.obs;
  var orderId="";
  List<TextEditingController> quantity =[];
  @override
  void onInit(){
    super.onInit();
    print('this is cart $cartList');
  }
  addToCart(String name,double price,String modelUrl){
    cartMap.value={
      'name':name,
      'price':price,
      'modelUrl':modelUrl
    };cartList.value.add(cartMap.value);
    cartLen.value=cartList.length;

  }

  uploadUserSpecificCart({required String userName, required String address,required String phone,required String city,required String state,required String email})async{
    try{
      var date= DateTime.now();
      orderId=  const Uuid().v1();
      var formattedDate = DateFormat('yyyy-MM-dd').format(date);
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection('orders').doc(orderId).set({
        'orderId': orderId,
        'orderDate': formattedDate.toString(),
        'order':cartList.value.toList(),
        'orderStatus': kProcessing,
        'totalPrice': totalAmount.toString(),
        'orderedBy':FirebaseAuth.instance.currentUser!.uid.toString(),
        'userName':userName,
        'address':'${address},${city},${state},Pakistan',
        'phoneNumber':phone,
        'email':email
      });


    }
    on FirebaseException catch(e){
      print(e.message);
    }
  }
  uploadOverAllCart({required String userName, required String address,required String phone,required String city,required String state,required String email})async{
    try{
      var date= DateTime.now();
      var formattedDate = DateFormat('yyyy-MM-dd').format(date);
      await FirebaseFirestore.instance.collection('Orders').doc(orderId).set({
        'orderId': orderId,
        'orderDate': formattedDate.toString(),
        'order':cartList.value.toList(),
        'orderStatus': kProcessing,
        'totalPrice': totalAmount.toString(),
        'orderedBy':FirebaseAuth.instance.currentUser!.uid.toString(),
        'userName':userName,
        'address':'${address},${city},${state},Pakistan',
        'phoneNumber':phone,
        'email':email
      });

    }
    on FirebaseException catch(e){
      print(e.message);
    }
  }
}