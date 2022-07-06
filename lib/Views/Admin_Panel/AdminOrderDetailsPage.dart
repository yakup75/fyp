import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Widgets/Constants.dart';

class AdminOrderDetailsPage extends StatefulWidget {
  const AdminOrderDetailsPage({Key? key}) : super(key: key);

  @override
  State<AdminOrderDetailsPage> createState() => _AdminOrderDetailsPageState();
}

class _AdminOrderDetailsPageState extends State<AdminOrderDetailsPage> {
  var args = Get.arguments;
  late String userName;
  late String phoneNumber;
  late String orderDate;
  late String orderStatus;
  late String totalPrice;
  late String userId;
  late String orderId;

  @override
  void initState() {
    super.initState();
    userName = args[0].toString();
    phoneNumber = args[1].toString();
    orderDate = args[2].toString();
    orderStatus = args[3].toString();
    totalPrice = args[4].toString();
    orderId=args[5].toString();
    userId=args[6].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('User Name'),
                  Text(userName),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Phone Number'),
                  Text(phoneNumber),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Date'),
                  Text(orderDate),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Price'),
                  Text(totalPrice),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Order Status',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    value: orderStatus,
                    //elevation: 5,
                    style: const TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[kProcessing, kCompleted, kCancelled]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        orderStatus = value.toString();
                      });
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text('Update Status'),
                onPressed: ()async{
                  await FirebaseFirestore.instance.collection('Orders').doc(orderId).update({
                    'orderStatus': orderStatus,
                  });
                  await FirebaseFirestore.instance.collection('users').doc(userId).collection('orders').doc(orderId).update({
                    'orderStatus': orderStatus,
                  });

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
