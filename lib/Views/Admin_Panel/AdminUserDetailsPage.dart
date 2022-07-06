import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Widgets/Constants.dart';

class AdminUserDetailsPage extends StatefulWidget {
  const AdminUserDetailsPage({Key? key}) : super(key: key);

  @override
  State<AdminUserDetailsPage> createState() => _AdminUserDetailsPageState();
}

class _AdminUserDetailsPageState extends State<AdminUserDetailsPage> {
  var args = Get.arguments;
  late String userName;
  late String phoneNumber;
  late String userId;
  late String email;
  late String address;

  @override
  void initState() {
    super.initState();
    userName = args[0].toString();
    email = args[1].toString();
    address = args[2].toString();
    userId = args[3].toString();
    phoneNumber = args[4].toString();
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
                  Text('Email'),
                  Text(email),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('User Id'),
                  Text(userId),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                child: Text(' Delete this user'),
                onPressed: ()async{
                  try{
                   try{
                     List<String> orderIds=[];
                     QuerySnapshot snapshot= await FirebaseFirestore.instance.collection('Orders').get();
                     for (var element in snapshot.docs) {
                       if(element.get('orderedBy')==userId){
                         setState((){
                           orderIds.add(element['orderId']);
                         });
                         print(orderIds);
                       }
                     }
                     for (int i =0; i<orderIds.length; i++){
                       await FirebaseFirestore.instance.collection('Orders').doc(orderIds[i]).delete();
                     }
                   }
                   on FirebaseException catch(e){
                     print(e.message);
                   }

                   try{
                     QuerySnapshot snapshot= await FirebaseFirestore.instance.collection('users').doc(userId).collection('orders').get();
                     for (DocumentSnapshot ds in snapshot.docs) {
                       ds.reference.delete();
                     }
                   }
                   on FirebaseException catch(e){
                     print(e.message);
                   }
                   await FirebaseFirestore.instance.collection('users').doc(userId).delete();
                    Get.back();
                  }
                  on FirebaseException catch(e){
                    print(e.message);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
