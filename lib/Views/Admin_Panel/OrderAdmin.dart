import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Views/Admin_Panel/AdminOrderDetailsPage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrderAdmin extends StatefulWidget {
  const OrderAdmin({Key? key}) : super(key: key);

  @override
  State<OrderAdmin> createState() => _OrderAdminState();
}

class _OrderAdminState extends State<OrderAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
        builder: (context,snapshot){
          if(snapshot.data==null){
            return Container();
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                List listOfOrders=doc['order'];
                print(listOfOrders.asMap());
                return InkWell(
                  onTap: (){
                    Get.to(()=> const AdminOrderDetailsPage(),arguments: [doc['userName'],doc['phoneNumber'],doc['orderDate'],doc['orderStatus'],doc['totalPrice'],doc['orderId'],doc['orderedBy']]);
                  },
                  child: ListTile(
                    title: Text(doc['userName']),
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
