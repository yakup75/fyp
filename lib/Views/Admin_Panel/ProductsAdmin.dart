import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Views/Admin_Panel/UploadData.dart';
import 'package:fyp/Widgets/ModelView.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ProductsAdmin extends StatefulWidget {
  const ProductsAdmin({Key? key}) : super(key: key);

  @override
  State<ProductsAdmin> createState() => _ProductsAdminState();
}

class _ProductsAdminState extends State<ProductsAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(onPressed: (){
            Get.to(()=>const UploadData(),arguments: ['null']);
          }, icon: const Icon(Icons.add_circle))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context,snapshot){
          if(snapshot.data==null){
            return Container();
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                return InkWell(
                  onTap: (){
                    Get.to(()=>UploadData(),arguments: [index,doc['name'],doc['price'],doc['productId'],doc['modelUrl'],doc['category'],doc['description']]);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                        //child: ModelViewer(src: doc['modelUrl'],ar: false,)
                    ),
                    title: Text(doc['name']),
                    trailing: Text(doc['price'].toString()),
                  ),
                );
              });
      },
      ),
    );
  }
}
