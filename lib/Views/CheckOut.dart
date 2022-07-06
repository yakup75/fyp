import 'package:flutter/material.dart';
import 'package:fyp/Controller/CartController.dart';
import 'package:fyp/Controller/PaymentController.dart';
import 'package:fyp/Views/MainPage.dart';
import 'package:get/get.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  PaymentController payment=Get.find();
  CartController cart=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: payment.name,
                decoration: InputDecoration(
                  labelText: 'Name'
                ),
              ),
              TextFormField(
                controller: payment.number,
                decoration: InputDecoration(
                    labelText: 'Phone Number'
                ),
              ),
              TextFormField(
                controller: payment.address,
                decoration: InputDecoration(
                    labelText: 'Address'
                ),
              ),
              TextFormField(
                controller: payment.city,
                decoration: InputDecoration(
                    labelText: 'City'
                ),
              ),
              TextFormField(
                controller: payment.state,
                decoration: InputDecoration(
                    labelText: 'State'
                ),
              ),
              ElevatedButton(onPressed: (){
                var total=cart.totalAmount.value.toInt();
                //var send=await payment.makePayment(amount: '$total', currency: 'PKR');
                print(total);
               cart.uploadUserSpecificCart(userName: payment.name.text,address: payment.address.text,phone: payment.number.text,city: payment.city.text,state: payment.state.text);

               cart.uploadOverAllCart(userName: payment.name.text,address: payment.address.text,phone: payment.number.text,city: payment.city.text,state: payment.state.text);
                setState((){ cart.cartList.value.clear();
                });
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=> const MainPage()), (route) => false);
                // Get.off(()=> const MainPage());

              }, child: Text('Pay Now'))
            ],
          ),
        ),
      ),
    );
  }
}
