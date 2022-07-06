import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  var args= Get.arguments;
  @override
  Widget build(BuildContext context) {
    print(args.length);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
      ),
      body: ListView.builder(
          itemCount: args.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(args[index]['name'].toString()),
              leading: Text(args[index]['price'].toString()),
            );
          }),
    );
  }
}
