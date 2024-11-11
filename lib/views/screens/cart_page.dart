import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketky/constant/app_color.dart';
import 'package:marketky/core/model/Cart.dart';
import 'package:marketky/core/services/CartService.dart';


class CartPage extends StatefulWidget {
  final String struserid;
  CartPage(this.struserid);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  num totalPriceFinal=0;
  List<Cart> cartData = CartService.cartData;
   @override
  void initState() {
    super.initState();
  calculateTotal();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Text('Your Cart',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
           
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset('assets/icons/Arrow-left.svg'),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: AppColor.primarySoft,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      // Checkout Button
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: AppColor.border, width: 1))),
        child: ElevatedButton(
          onPressed: () {
          
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 6,
                child: Text(
                  'Checkout',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'poppins'),
                ),
              ),
              Container(
                width: 2,
                height: 26,
                color: Colors.white.withOpacity(0.5),
              ),
              Flexible(
                flex: 6,
                child: Text(
                  'Rs :'+totalPriceFinal.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'poppins'),
                ),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
            backgroundColor: AppColor.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
        ),
      ),
      body: 
      
      ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(16),
        children: [
 StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('salecart')
                          .where('usermob', isEqualTo:widget.struserid)
                          .snapshots()
                          ,
                          
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      
                        final userSnapshot = snapshot.data?.docs;
       return   ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
               
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.border, width: 1),
      ),
      child: Row(
        children: [
          // Image
          
          // Info
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  '${userSnapshot![index]['productname']}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'poppins',
                      color: AppColor.secondary),
                ),
                // Product Price - Increment Decrement Button
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Product Price
                      Expanded(
                        child: Text(
                          'Rs.'+userSnapshot![index]['mrp'],
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: 'poppins',
                              color: AppColor.primary),
                        ),
                      ),
                      // Increment Decrement Button
                     ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
 
            },
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemCount: userSnapshot!.length,
          );
                          }),
          // Section 2 - Shipping Information
          Container(
            margin: EdgeInsets.only(top: 24),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20),
            decoration: BoxDecoration(
              color: AppColor.primarySoft,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColor.border, width: 1),
            ),
            child: Column(
              children: [
                // header
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shipping information',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w600,
                            color: AppColor.secondary),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: SvgPicture.asset(
                          'assets/icons/Pencil.svg',
                          width: 16,
                          color: AppColor.secondary,
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColor.primary,
                          shape: CircleBorder(),
                          backgroundColor: AppColor.border,
                          elevation: 0,
                          padding: EdgeInsets.all(0),
                        ),
                      ),
                    ],
                  ),
                ),
                // Name
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        child: SvgPicture.asset('assets/icons/Profile.svg',
                            width: 18),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Name'),
                          style: TextStyle(
                            color: AppColor.secondary.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Address
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        child: SvgPicture.asset('assets/icons/Home.svg',
                            width: 18),
                      ),
                      Expanded(
                        child: TextField(
                         
                          style: TextStyle(
                            color: AppColor.secondary.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Phone Number
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        child: Icon(Icons.phone),
                            width: 18),
                      
                      Expanded(
                        child: TextField(
                         
                          style: TextStyle(
                            color: AppColor.secondary.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        
        ],
      ),
    );
  }
  
  Future<void> calculateTotal() async {
    num totalPrice = 0;
    final firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestoreInstance
        .collection("salecart")
        .where('usermob', isEqualTo:widget.struserid)
        .get();

    for (int i = 0; i < qn.docs.length; i++) {
      totalPrice = totalPrice +( num.parse(qn.docs[i]["mrp"])+ num.parse(qn.docs[i]["mrp"])*(num.parse(qn.docs[i]["tax"])/100));
      totalPriceFinal = totalPrice;          
    }
    setState(() {});
  }
}
