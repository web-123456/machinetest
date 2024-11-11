import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketky/views/screens/cart_page.dart';
import 'package:marketky/views/screens/productlistpage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //List<Category> categoryData = CategoryService.categoryData;
  //List<Product> productData = ProductService.productData;
  TextEditingController  taxcontroller= TextEditingController();
  TextEditingController pnamecontroller = TextEditingController();
  TextEditingController mrpcontroller = TextEditingController();
  TextEditingController storenamecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  String struserid="";
  late Timer flashsaleCountdownTimer;
  Duration flashsaleCountdownDuration = Duration(
    hours: 24 - DateTime.now().hour,
    minutes: 60 - DateTime.now().minute,
    seconds: 60 - DateTime.now().second,
  );

  @override
  void initState() {
    super.initState();
  getsharedpref();
   
  }



  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // Section 1
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 26,),
                Row(children: [
                  SizedBox(width: 10,),
                  Text(
                        'Welcome',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          height: 150 / 100,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                     Spacer(),
                    
                       SizedBox(width: 10,),
                ],),
             
              ],
            ),
          ),
          SizedBox(height: 50,),
           ElevatedButton(
        onPressed: () {
             showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add store details'),
                    content: SingleChildScrollView(child:
                     Column(children: [
                      
     
          
             TextField(
                      controller: storenamecontroller,
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: "Store name"),
                    ),
        TextField(
                      controller: locationcontroller,
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: "Location"),
                    ),
                  
     

                    ],)
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('Add'),
                        onPressed: () async {
                          

                          
                            
                             String storename=storenamecontroller.text;
                             String location=locationcontroller.text;
                            
                               
                           

                            
                                
                              
                              
                                 
                              FirebaseFirestore.instance
                                  .collection('storedetails')
                                  .add(
                                {
                                
                                  'storename': storename, 
                                  'location':location,
                                 
                                 
                                  
                                }, 
                              ).then((value) {
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Container(
                                            height: 100,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'store added successfully',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                   
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Icon(
                                                  Icons.check_circle,
                                                  color: Colors.red,
                                                  size: 40,
                                                )
                                              ],
                                            )),
                                        actions: <Widget>[
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                               
                                                
                                               
                                              },
                                              child: Text(
                                                'Continue',
                                                style: TextStyle(
                                                 
                                                    fontSize: 10,
                                                    color: Colors.black),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .red))))),
                                          ElevatedButton(
                                              onPressed: () {
                                                },
                                              child: Text(
                                                'view Products',
                                                style: TextStyle(
                                                  
                                                    fontSize: 10),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Color.fromARGB(
                                                              255, 227, 108, 99)),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  18.0),
                                                          side:
                                                              BorderSide(color: Color.fromARGB(255, 231, 118, 109))))))
                                        ],
                                      );
                                    });
                              }).onError((error, stackTrace) {
                              /*  Fluttertoast.showToast(
                                    textColor:
                                        Color.fromARGB(255, 242, 233, 233),
                                    msg: "Someting went wrong!",
                                    toastLength: Toast.LENGTH_LONG
                                    // fontSize: 25
                                    // gravity: ToastGravity.TOP,
                                    // text
                                    //Color: Colors.pink
                                    ); */
                              });
                                
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
      
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
              opacity: 0,
              child: Icon(Icons.arrow_forward),
            ),
            Text('Add Store'),
            Icon(Icons.store),
          ],
        ),
      ),
          SizedBox(height: 20),
             ElevatedButton(
        onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add Product'),
                    content: SingleChildScrollView(child:
                     Column(children: [
                      
     
          
             TextField(
                      controller: pnamecontroller,
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: "Product name"),
                    ),
        TextField(
                      controller: mrpcontroller,
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: "Product MRP"),
                    ),
                    TextField(
                      controller: taxcontroller,
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: "Tax percentage"),
                    ),
     

                    ],)
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('Add'),
                        onPressed: () async {
                          

                          
                            
                             String pname=pnamecontroller.text;
                             String tax=taxcontroller.text;
                             String pmrp=mrpcontroller.text;
                               
                           

                            
                                
                              
                              
                                 
                              FirebaseFirestore.instance
                                  .collection('productlisttest')
                                  .add(
                                {
                                
                                  'productname': pname, 
                                  'productmrp':pmrp,
                                  'tax':tax
                                 
                                  
                                }, 
                              ).then((value) {
                                return showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Container(
                                            height: 100,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'product added successfully',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                   
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Icon(
                                                  Icons.check_circle,
                                                  color: Colors.red,
                                                  size: 40,
                                                )
                                              ],
                                            )),
                                        actions: <Widget>[
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                               
                                                
                                               
                                              },
                                              child: Text(
                                                'Continue',
                                                style: TextStyle(
                                                 
                                                    fontSize: 10,
                                                    color: Colors.black),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  shape: MaterialStateProperty
                                                      .all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .red))))),
                                          ElevatedButton(
                                              onPressed: () {
                                              
                                              },
                                              child: Text(
                                                'view Data',
                                                style: TextStyle(
                                                  
                                                    fontSize: 10),
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Color.fromARGB(
                                                              255, 227, 108, 99)),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  18.0),
                                                          side:
                                                              BorderSide(color: Color.fromARGB(255, 231, 118, 109))))))
                                        ],
                                      );
                                    });
                              }).onError((error, stackTrace) {
                              /*  Fluttertoast.showToast(
                                    textColor:
                                        Color.fromARGB(255, 242, 233, 233),
                                    msg: "Someting went wrong!",
                                    toastLength: Toast.LENGTH_LONG
                                    // fontSize: 25
                                    // gravity: ToastGravity.TOP,
                                    // text
                                    //Color: Colors.pink
                                    ); */
                              });
                                
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
      
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
              opacity: 0,
              child: Icon(Icons.arrow_forward),
            ),
            Text('Add Product'),
            Icon(Icons.shopping_bag),
          ],
        ),
      ),
         SizedBox(height: 20),
  ElevatedButton(
        onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductlistPage()));
                                             
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
              opacity: 0,
              child: Icon(Icons.arrow_forward),
            ),
            Text('View products'),
            Icon(Icons.view_agenda),
          ],
        ),
      ),
       SizedBox(height: 20),
  ElevatedButton(
        onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage(struserid)));
                                             
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Opacity(
              opacity: 0,
              child: Icon(Icons.arrow_forward),
            ),
            Text('View cart'),
            Icon(Icons.shopping_basket),
          ],
        ),
      ),
        ],
      ),
    );
  }
  
  Future<void> getsharedpref() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     struserid=  prefs.getString('usermobile')!;
   
  }

}


