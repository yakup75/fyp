import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CartController extends GetxController{

  RxMap cartMap={}.obs;
  RxDouble totalAmount=0.0.obs;
  RxList cartList=[].obs;
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
  }
}