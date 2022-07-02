
import 'package:flutter/material.dart';
import 'package:fyp/Views/UploadData.dart';
import 'package:get/get.dart';

import '../Helper/ThemeToggle.dart';
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // key:MainPage().drawerscaffoldkey,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              // image: DecorationImage(
              //     fit: BoxFit.fill,
              //image: AssetImage('images/erp-gold.png')
              // )
            ),
          ),
          Builder(
              builder: (context) {

                return ListTile(
                  leading: Get.isDarkMode?Icon(Icons.light_mode):Icon(Icons.dark_mode),
                  title:  Get.isDarkMode?Text('Light Mode'):Text('Dark Mode'),
                  trailing: Container(height:30,
                      width:40,child: themeToggle()),
                );
              }
          ),
          ListTile(
          leading: Icon(Icons.add_circle_outline_outlined),
    title: Text('Add Product'),
    onTap: () async{
  Get.to(()=>UploadData());
    },),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async{
              // SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
              // sharedPreferences.remove('email');
              // Get.to(LoginPage());
            },
          ),
        ],
      ),
    );
  }
}