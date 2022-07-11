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
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
      ),
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

                return InkWell(
                  onTap: (){
                    Get.to(()=> OrderDetailPage(),arguments: listOfOrders);
                  },
                  child:Card(elevation: 8,shadowColor: Get.isDarkMode?Colors.black45:Colors.black45,margin: EdgeInsets.all(6),
                      shape:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black26)
                      ),
                      child:Column(
                          children:[
                            Container(
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(doc['orderDate']),
                                    Text(doc['totalPrice']),
                                    Text(doc['orderStatus'],style: TextStyle(fontWeight: FontWeight.bold,
                                      color: doc['orderStatus']=='Processing'?Colors.yellow:doc['orderStatus']=='Cancelled'?Colors.red:Colors.green,
                                    ),),
                                  ],
                                ),
                              ),
                            ),

                          ])),
                  // ListTile(
                  //   title: Text(doc['userName']),
                  //   trailing: Text(doc['orderStatus']),
                  //   leading: Text(doc['orderDate']),
                  // ),
                );
              });



        },
      ),
    );
  }
}
