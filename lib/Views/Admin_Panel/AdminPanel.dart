
import 'package:flutter/material.dart';
import 'package:fyp/Views/Admin_Panel/OrderAdmin.dart';
import 'package:fyp/Views/Admin_Panel/ProductsAdmin.dart';
import 'package:get/get.dart';

import 'UserAdmin.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(onTap: (){Get.to(()=>UserAdmin());},
                  child: Card(
                    child: Text('Users'),
                  ),
                ),
                InkWell(onTap: (){Get.to(()=>ProductsAdmin());},
                  child: Card(
                    child: Text('Products'),
                  ),
                ),
                InkWell(
                  onTap: (){Get.to(()=>OrderAdmin());},
                  child: Card(
                    child: Text('Orders'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
