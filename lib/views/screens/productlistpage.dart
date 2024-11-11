import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketky/constant/app_color.dart';
import 'package:marketky/core/model/Category.dart';
import 'package:marketky/core/model/Product.dart';
import 'package:marketky/core/services/CategoryService.dart';
import 'package:marketky/core/services/ProductService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductlistPage extends StatefulWidget {
  @override
  _ProductlistPageState createState() => _ProductlistPageState();
}

class _ProductlistPageState extends State<ProductlistPage> {
  List<Category> categoryData = CategoryService.categoryData;
  List<Product> productData = ProductService.productData;
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
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (_) {
      setCountdown();
    });
  }

  void setCountdown() {
    if (this.mounted) {
      setState(() {
        final seconds = flashsaleCountdownDuration.inSeconds - 1;

        if (seconds < 1) {
          flashsaleCountdownTimer.cancel();
        } else {
          flashsaleCountdownDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  @override
  void dispose() {
    if (flashsaleCountdownTimer != null) {
      flashsaleCountdownTimer.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String seconds = flashsaleCountdownDuration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String minutes = flashsaleCountdownDuration.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    String hours = flashsaleCountdownDuration.inHours
        .remainder(24)
        .toString()
        .padLeft(2, '0');

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // Section 1
          Container(
            height: 100,
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
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sell your Products here...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                         
                        ),
                      ),
                      Spacer(),
                     
                       ],
                  ),
                ),
                ],
            ),
          ),
          // Section 2 - category
       
                                  
           StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('productlisttest')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      
                        final userSnapshot = snapshot.data?.docs;
                      
        return  Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(
                 userSnapshot!.length,
                (index) =>   GestureDetector(
      onTap: () {
     
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 16 - 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // item image
          
            Container(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                        '' + userSnapshot[index]["productname"],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primary ,
                    ),
                  ),
                
                  Text(
                        'Rs. ' + userSnapshot[index]["productmrp"],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),

                  SizedBox(height: 5,),
                   Text(
                        'Tax percentage : ' + userSnapshot[index]["tax"],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                   
                   InkWell(
                                                                      onTap:
                                                                          () {
                                                                           

                                                                            FirebaseFirestore.instance
                                  .collection('salecart')
                                  .add(
                                {
                                  
                                  'productname': userSnapshot[index]["productname"], 
                                 
                                  'mrp':  userSnapshot[index]["productmrp"],
                                  'tax': userSnapshot[index]["tax"],
                                   'usermob': struserid,

                                  
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
                                                  ' added to sale..!',
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
                             /*   Fluttertoast.showToast(
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
                        }
                     
                  
                

                                                                               //add to cart
                                                                               //product name, price, size, qty,clr,id,customerid, 

                                                                     
                                                                      ,
                                                                      child:
                                                                          Container(
                                                                          width: MediaQuery.of(context).size.width / 2 - 16 - 8,
            
                                                                        alignment:
                                                                            Alignment.center,
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                5,
                                                                            bottom:
                                                                                5),
                                                                        child:
                                                                            Text(
                                                                          "+",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        height:
                                                                            30,
                                                                        decoration: BoxDecoration(
                                                                            color: AppColor.primary,
                                                                            //  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                                            shape: BoxShape.rectangle,
                                                                            border: Border.all(
                                                                              color: AppColor.primary,
                                                                              width: 1,
                                                                            )),
                                                                      ))
                                                           
                  /*  Container(

                                                                  // padding: EdgeInsets.only(left: 80),
                                                                  child: Row(
                                                                children: [
                                                                  InkWell(
                                                                      onTap:
                                                                          () {
                                                              
                                                                      },
                                                                      child:
                                                                        
                                                                          Container(
                                                                        width:
                                                                            30,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                5,
                                                                            bottom:
                                                                                5),
                                                                        child:
                                                                            Text(
                                                                          "-",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        height:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              AppColor.primary,
                                                                          //  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                                          shape:
                                                                              BoxShape.rectangle,
                                                                          border:
                                                                              Border(
                                                                            top:
                                                                                BorderSide(width: 1.0, color: AppColor.primary),
                                                                            bottom:
                                                                                BorderSide(width: 1.0, color: AppColor.primary),
                                                                            left:
                                                                                BorderSide(width: 1.0, color: AppColor.primary),
                                                                            right:
                                                                                BorderSide(width: 0, color: AppColor.primary),
                                                                          ),
                                                                        ),
                                                                      )),
                                                                  InkWell(
                                                                      onTap:
                                                                          () {

                                                                            if((userSnapshot[index]["qty"])==0){

                                                                            }else{
                                                                             int newcount=userSnapshot[index]["qty"];
                                                                             newcount--;
                                                                            
                                                                            }
                                                                          },
                                                                      child: Container(
                                                                          alignment: Alignment.center,
                                                                          width: 50,
                                                                          padding: EdgeInsets.all(5),
                                                                          child: Text((userSnapshot[index]["qty"]).toString(),
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                color: AppColor.primary,
                                                                              
                                                                              )),
                                                                          //  margin: EdgeInsets.fromLTRB(20, 8, 8, 16),

                                                                          height: 30,
                                                                          decoration: BoxDecoration(
                                                                            // borderRadius: BorderRadius.all(Radius.circular(4)),
                                                                            // shape: BoxShape.rectangle,
                                                                            border:
                                                                                Border(
                                                                              top: BorderSide(width: 1.0, color: AppColor.primary),
                                                                              bottom: BorderSide(width: 1.0, color: AppColor.primary),
                                                                              left: BorderSide(width: 1.0, color: AppColor.primary),
                                                                              right: BorderSide(width: 0, color: AppColor.primary),
                                                                            ),
                                                                          ))),
                                                                  InkWell(
                                                                      onTap:
                                                                          () {


                                                                     
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            30,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                5,
                                                                            bottom:
                                                                                5),
                                                                        child:
                                                                            Text(
                                                                          "+",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        height:
                                                                            30,
                                                                        decoration: BoxDecoration(
                                                                            color: AppColor.primary,
                                                                            //  borderRadius: BorderRadius.all(Radius.circular(4)),
                                                                            shape: BoxShape.rectangle,
                                                                            border: Border.all(
                                                                              color: AppColor.primary,
                                                                              width: 1,
                                                                            )),
                                                                      ))
                                                                ],
                                                              ))
                  
               
               */
                ],
              ),
            )
          ],
        ),
      ),
    )
  
              ),
            ),
          );
             })
        ])    
    );
  }
  
  Future<void> getsharedpref() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     struserid=  prefs.getString('usermobile')!;
   
  }
}
