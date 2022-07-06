import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Views/Admin_Panel/AdminUserDetailsPage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UserAdmin extends StatefulWidget {
  const UserAdmin({Key? key}) : super(key: key);

  @override
  State<UserAdmin> createState() => _UserAdminState();
}

class _UserAdminState extends State<UserAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
                    Get.to(()=> const AdminUserDetailsPage(),arguments: [doc['name'],doc['email'],doc['address'],doc['userId'],doc['userPhone']]);
                  },
                  child: ListTile(
                    title: Text(doc['name']),
                    trailing: Text(doc['email']),
                  ),
                );
              });
        },
      ),
    );
  }
}
