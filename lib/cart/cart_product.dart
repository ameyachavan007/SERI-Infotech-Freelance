import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seri_flutter_app/cart/counter_box.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/my-order-detail-page/screens/myOrderDetailPage.dart';
import 'package:sizer/sizer.dart';

import '../empty-wishlist/wishlist/WishListPage.dart';
import 'models/CartData.dart';

class CartList extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const CartList(this.loginResponse, this.cartData);

  @override
  _CartListState createState() => _CartListState(loginResponse, cartData);
}

class _CartListState extends State<CartList> {
  final LoginResponse loginResponse;
  final CartData cartData;

  bool productsLoaded = false;
  List cartList = [];

  _CartListState(this.loginResponse, this.cartData);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      //cartList == null?
      //Container(width: 0.0, height: 0.0,):
      ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        //cartList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return SingleOffer(
            prodName:
            "CRAFT CLUB Love Printed diary in euro binding A5 Diaries (Multicolor)",
            image: "lib/assets/images/first_page.png",
            percentOff: "30",
            actual_price: "1600",
            final_price: "999",
            available: true,
            loginResponse: loginResponse,
            cartData: cartData,
          );
        },
      );
    // Container(height: 0, width: 0,);
  }
}

class SingleOffer extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  final String prodName;
  final image;
  final String percentOff;
  final String actual_price;
  final String final_price;
  final available;

  SingleOffer(
      {this.prodName,
        this.image,
        this.percentOff,
        this.actual_price,
        this.final_price,
        this.available,
        this.loginResponse,
        this.cartData});

  @override
  _SingleOfferState createState() => _SingleOfferState(loginResponse, cartData);
}

class _SingleOfferState extends State<SingleOffer> {
  final LoginResponse loginResponse;
  final CartData cartData;

  var productController;

  bool productDeleted = false;
  bool checkedValue = false;

  _SingleOfferState(this.loginResponse, this.cartData);

  @override
  Widget build(BuildContext context) {
    return productDeleted
        ? Container(
      height: 0,
      width: 0,
    )
        : Padding(
      padding:  EdgeInsets.only(bottom: 1.h),
      child: Card(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyOrdersDetailPage()));
          },
          child: Container(

            // height: 179,
            width: MediaQuery.of(context).size.width - 15,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 8, bottom: 5),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 0.01.w, top: 0.3.h),
                            alignment: Alignment.topLeft,
                            height: 108,
                            width: MediaQuery.of(context).size.width / 4,
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                //  borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.black),
                                image: DecorationImage(
                                    image: AssetImage(widget.image),
                                    fit: BoxFit.fill)),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 5.0, left: 14),
                            child: Column(
                              children: [
                                Container(
                                  //   alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width /
                                      1.7,
                                  child: Text(
                                    widget.prodName,
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        fontWeight: FontWeight.w800,
                                        fontSize: MediaQuery.of(context)
                                            .size
                                            .width /
                                            25,
                                        color: Color.fromARGB(
                                            255, 71, 54, 111)),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (widget.available == true)
                                  Container(
                                    // alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                  text: "Rs ",
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'GothamMedium',
                                                      fontSize: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .width /
                                                          27,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255,
                                                          71,
                                                          54,
                                                          111)),
                                                  children: [
                                                    TextSpan(
                                                      text: widget
                                                          .final_price,
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'GothamMedium',
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              27,
                                                          color: Color
                                                              .fromARGB(
                                                              255,
                                                              71,
                                                              54,
                                                              111)),
                                                    )
                                                  ]),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: "Rs ",
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'GothamMedium',
                                                      fontSize: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .width /
                                                          27,
                                                      decoration:
                                                      TextDecoration
                                                          .lineThrough,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255,
                                                          71,
                                                          54,
                                                          111)),
                                                  children: [
                                                    TextSpan(
                                                      text: widget
                                                          .actual_price,
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'GothamMedium',
                                                          decoration:
                                                          TextDecoration
                                                              .lineThrough,
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              27,
                                                          color: Color
                                                              .fromARGB(
                                                              255,
                                                              71,
                                                              54,
                                                              111)),
                                                    )
                                                  ]),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: widget.percentOff,
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'GothamMedium',
                                                      fontSize: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .width /
                                                          27,
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.green),
                                                  children: [
                                                    TextSpan(
                                                      text: "% Off",
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'GothamMedium',
                                                          fontSize: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              27,
                                                          color:
                                                          Colors.green),
                                                    )
                                                  ]),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Price inclusive of all taxes",
                                          style: TextStyle(
                                              fontFamily: 'GothamMedium',
                                              fontSize:
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  29,
                                              color: Colors.red),
                                        ),
                                        // SizedBox(width: MediaQuery.of(context).size.width *0.2),
                                      ],
                                    ),
                                  ),
                                if (widget.available == false)
                                  Container(
                                    //  width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.red[200],
                                        border: Border.all(
                                            color: Colors.grey[200]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "  Unavailable  ",
                                        style: TextStyle(
                                            fontFamily: 'GothamMedium',
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .width /
                                                22,
                                            color: Colors.red),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                widget.available == true
                    ? Row(
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 1.h,),
                        Row(

                          children: [
                            SizedBox(
                              height: 10,
                              width: 24,
                              child: Transform.scale(
                                scale: 0.8,
                                child: Checkbox(
                                  activeColor:
                                  Color.fromARGB(255, 71, 54, 111),
                                  value: checkedValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      checkedValue = newValue;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Text(
                              "Send this item as a Gift",
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontSize: 13,
                                  color:
                                  Color.fromARGB(255, 71, 54, 111)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CountButtonView(
                          initialCount: 1,
                          onChange: (count) {},
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    )
                  ],
                )
                    : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(

                      children: [
                        SizedBox(height: 1.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                              width: 24,
                              child: Transform.scale(
                                scale: 0.8,
                                child: Checkbox(
                                  value: checkedValue,
                                  activeColor:
                                  Color.fromARGB(255, 71, 54, 111),
                                  onChanged: (newValue) {
                                    setState(() {
                                      checkedValue = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Text(
                              "Send this item as a Gift",
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontSize: 13,
                                  color: Colors.grey[400]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: SizedBox(
                            height: 25,
                            width: MediaQuery.of(context).size.width *
                                0.25,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xddFFFFFF),
                                  border: Border.all(
                                      color: Colors.grey[400],
                                      width: 1.0),
                                  borderRadius:
                                  BorderRadius.circular(5.0)),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                      width: (MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.25) /
                                          3,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            bottom: 2.0),
                                        child: Container(
                                            width: (MediaQuery.of(
                                                context)
                                                .size
                                                .width *
                                                0.25) /
                                                3,
                                            child: Center(
                                                child: Icon(
                                                    Icons.remove,
                                                    color: Colors
                                                        .grey[400]))),
                                      )),
                                  Text("|",
                                      style: TextStyle(
                                          color: Colors.grey[400])),
                                  Container(
                                    child: Center(
                                        child: Text(
                                          '1',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[400],
                                              decoration:
                                              TextDecoration.none),
                                        )),
                                  ),
                                  Text("|",
                                      style: TextStyle(
                                          color: Colors.grey[400])),
                                  Container(
                                      width: (MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.25) /
                                          3,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            bottom: 2.0),
                                        child: Container(
                                            width: (MediaQuery.of(
                                                context)
                                                .size
                                                .width *
                                                0.25) /
                                                3,
                                            child: Center(
                                                child: Icon(Icons.add,
                                                    color: Colors
                                                        .grey[400]))),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  color: Color.fromARGB(255, 71, 54, 111),
                  height: 10,
                  thickness: 1,
                ),
                //  SizedBox(height: 1.5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 7.0, bottom: 4),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WishListPage(
                                      loginResponse, cartData)));
                        },
                        child: Text(
                          "Add to WishList",
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 71, 54, 111)),

                        ),
                      ),
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width ,),
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0, bottom: 6),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: 20,
                            child: Icon(
                              Icons.delete,
                              color: Color.fromARGB(255, 71, 54, 111),
                              size: 25,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}