import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Controller/ProductController.dart';
import 'package:fyp/Views/ProductDetailsPage.dart';
import 'package:fyp/Views/cartPage.dart';
import 'package:fyp/Widgets/ProductCard.dart';
import 'package:get/get.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../Widgets/NavDrawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ProductController product=Get.find();
  // initializeFirebase() async{
  //   FirebaseApp app=await Firebase.initializeApp();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Welcome',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600
          ),
        ),
        actions: [
          //
          IconButton(onPressed: (){
            Get.to(()=>Cart());
          }, icon: Icon(Icons.add_shopping_cart)),
          Builder(
              builder: (context) {
                return IconButton( icon: Icon(Icons.settings),onPressed: (){
                  Scaffold.of(context).openEndDrawer();
                },   tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,);

              }
          )
        ],
      ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(()=>
          ListView.builder(
            itemCount: product.products.length,
            itemBuilder: (context,index)=>
                InkWell(
                  onTap: (){
                    Get.to(()=>ProductDetails(),
                        arguments: ['${product.products[index].name}','${product.products[index].description}','${product.products[index].modelUrl}','${product.products[index].price}']);
                  },
                  child: Card(elevation: 8,shadowColor: Get.isDarkMode?Colors.black45:Colors.black45,margin: EdgeInsets.all(6),
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black26)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 110,
                            width: 110,
                            // child: ModelViewer(
                            //       src: '${product.products[index].modelUrl}', // a bundled asset file
                            //
                            //   ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${product.products[index].name!} \n',
                                style: TextStyle(fontSize: 16),),
                              Text('\Rs ${product.products[index].price.toString() } \t',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),),

                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
          )),
        ),
        // body: Column(
        //   children: [
        //     // Container(
        //     //   height: MediaQuery.of(context).size.height*0.4,
        //     //
        //     //   child: ModelViewer(
        //     //     //backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
        //     //     src: 'https://dl.dropbox.com/s/i0t6u3fs2aw0ss4/ChairModel.glb', // a bundled asset file
        //     //     alt: "A 3D model of an astronaut",
        //     //     ar: true,
        //     //     arModes: ['scene-viewer', 'webxr', 'quick-look'],
        //     //     autoRotate: true,
        //     //     cameraControls: true,
        //     //     //iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
        //     //   ),
        //     // ),
        //     // Container(
        //     //   height: MediaQuery.of(context).size.height*0.4,
        //     //
        //     //   child: ModelViewer(
        //     //     //backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
        //     //     src: 'https://dl.dropbox.com/s/p7rv012d69zdqhz/CouchModel.glb', // a bundled asset file
        //     //     alt: "A 3D model of an astronaut",
        //     //     ar: true,
        //     //     arModes: ['scene-viewer', 'webxr', 'quick-look'],
        //     //     autoRotate: true,
        //     //     cameraControls: true,
        //     //     //iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
        //     //   ),
        //     // ),
        //
        //   ],
        // ),

    );
  }
}
