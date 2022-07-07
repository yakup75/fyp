import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).snapshots(),
        builder: (context,snapshot){

          if(snapshot.data==null){
            return Container();
          }
          name.text=snapshot.data!['name'].toString();
          email.text=snapshot.data!['email'].toString();
          print(snapshot.data!['name']);
          return Container(

            child: Column(
              children: [
                TextFormField(
                controller: name,
                ),
                TextFormField(
                controller: email,
                ),
                ElevatedButton(onPressed: () async{
                  UserModel userModel=  UserModel();
                 // userModel.userPhone='';
                  userModel.email=email.text;
                  userModel.userId= FirebaseAuth.instance.currentUser!.uid.toString();
                  //userModel.address='';
                  userModel.name=name.text;
                        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).update(userModel.asMap());
                }, child: Text('Save Data'))
              ],
            ),
          );
        },
      ),
    );
  }
}
