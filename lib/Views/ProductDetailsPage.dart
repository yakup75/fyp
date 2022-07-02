import 'package:flutter/material.dart';
import 'package:fyp/Controller/CartController.dart';
import 'package:fyp/Controller/ProductController.dart';
import 'package:fyp/Widgets/ModelView.dart';
import 'package:get/get.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  ProductController product=Get.find();
  CartController cart=Get.find();
  var arguments=Get.arguments;
  @override
  void initState() {
    super.initState();
    product.prodName.value=arguments[0];
    product.prodDesc.value=arguments[1];
    product.prodModelUrl.value=arguments[2];
    product.prodPrice.value=arguments[3];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                height: MediaQuery.of(context).size.height*0.41,
                // child: ModelView(
                //   url: '${product.prodModelUrl.value}',
                // ),
          
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),

                      topRight: Radius.circular(30.0)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${product.prodName.value}',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,

                          ),),
                          Text('${product.prodPrice.value}',style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                              color: Colors.green
                          ),),

                        ],

                      ),
                    ),

                Padding(
                  padding: const EdgeInsets.only(top:20.0,left: 20.0,right: 20.0,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Desciption:',style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,

                      ),),
                      SizedBox(height: 10,),
                      Container(
                        height: MediaQuery.of(context).size.height*0.32,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text('${product.prodDesc}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                 Row(

                   mainAxisAlignment: MainAxisAlignment.center,

                   children: [
                     Container(
                       height: 60,
                       width: 110,
                       child: Card(
                         color: Colors.red,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.only(
                             bottomLeft: Radius.circular(20.0),
                               topLeft: Radius.circular(20.0),
                               topRight: Radius.circular(40.0)),
                           side: BorderSide(color: Colors.grey, width: 0.7),
                         ),
                         elevation: 5,
                         margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                         child: Center(child: Text('ADD TO CART')),
                       ),
                     ),
                     Container(
                       height: 60,
                       width: 110,
                       child: Card(
                         color: Colors.green,
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.only(
                               bottomLeft: Radius.circular(40.0),
                               bottomRight: Radius.circular(20.0),
                               topRight: Radius.circular(20.0)),
                           side: BorderSide(color: Colors.grey, width: 0.7),
                         ),
                         elevation: 5,
                         margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                         child: Center(child: Text('BUY IT NOW!!')),
                       ),
                     ),
                   ],
                 ),
            ],
          ),
              ),
            ],
          ),),
      ),
    );
  }
}
