import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Views/order_detail_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .collection('orders')
            .snapshots(),
        builder: (context,snapshot){
          if(snapshot.data==null){
            return  Center(
              child: Container(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                List listOfOrders=doc['order'];
                print(listOfOrders.asMap());
                return InkWell(
                  onTap: (){
                    Get.to(()=> OrderDetailPage(),arguments: listOfOrders);
                  },
                  child: ListTile(
                    title: Text(doc['totalPrice']),
                    trailing: Text(doc['orderStatus']),
                    leading: Text(doc['orderDate']),
                  ),
                );
              });
        },
      ),
    );
  }
}
