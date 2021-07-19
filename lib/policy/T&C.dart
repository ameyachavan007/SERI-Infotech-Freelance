import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';

class Terms extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const Terms(this.loginResponse, this.cartData);

  @override
  _TermsState createState() => _TermsState(loginResponse: loginResponse, cartData: cartData);
}

class _TermsState extends State<Terms> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _TermsState({this.loginResponse, this.cartData});

  Future futureForCart;
  bool search = false;
  var cartController = CartController();

  @override
  void initState() {
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: search == false? AppBar(
          backgroundColor: Color.fromARGB(255, 71, 54, 111),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'lib/assets/icons/leftarrowwhite.png',
                width: MediaQuery.of(context).size.width * 0.07,
              ),
            ),
          ),
          title: Text(
            "Terms & Conditions",
            style: TextStyle(fontFamily: 'GothamMedium', fontSize: 16.sp),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        search = true;
                      });
                    },
                    child: Image.asset(
                      'lib/assets/icons/search3.png',
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FutureBuilder(
                      future: futureForCart,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          CartData cartData = snapshot.data;
                          return GestureDetector(
                            onTap: () {
                              cartData.cartProducts.length == 0
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              EmptyCartPage(
                                                loginResponse,
                                                cartData,
                                              )))
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Cart(
                                                loginResponse,
                                                cartData,
                                              )));
                            },
                            child: Badge(
                                position:
                                    BadgePosition.topEnd(top: -8, end: -10),
                                badgeColor: Colors.white,
                                badgeContent: Text(
                                  cartData.cartProducts.length.toString(),
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              35),
                                ),
                                child: Image.asset(
                                  'lib/assets/icons/cart1.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                )),
                          );
                        } else {
                          return Container();
                        }
                      }),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ],
        ): null,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
              children: [
                search == true
                    ? Column(
                      children: [
                        Container(height: 15, decoration: BoxDecoration(color: kPrimaryColor ),),
                        Stack(
                  children: <Widget>[
                        Container(
                          height: size.height * 0.1,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                          ),
                        ),
                        Positioned(
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                              vertical: kDefaultPadding * 0.8,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding * 0.5,
                            ),
                            height: size.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: kDefaultPadding,
                                  ),
                                  child: Image.asset(
                                    'lib/assets/images/search.png',
                                    width: size.width * 0.06,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      // contentPadding:
                                      //     EdgeInsets.only(top: kDefaultPadding * 0.05),
                                      hintText: "SEARCH PRODUCTS",
                                      hintStyle: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: kPrimaryColor.withOpacity(0.5),
                                      ),
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      search = false;
                                    });
                                  },
                                  child: Image.asset(
                                    'lib/assets/images/cross_purple.png',
                                    width: size.width * 0.06,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                  ],
                ),
                      ],
                    )
                    : Container(
                  height: 0.0,
                  width: 0.0,
                ),
                Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
                children: [
                  SizedBox(height: 15),
                  Container(
                    child: Text(
                      "-- Welcome to Pluscrown --",
                      style: TextStyle(
                          fontFamily: 'GothamMedium',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 22,
                          color: Color.fromARGB(255, 71, 54, 111)),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: Text(
                      '''• All applicable terms and regulations are according to information technology act 2000.
                          
• By accessing this website you agree to be bound by these Web Terms and Conditions.
 
• We request you to read this carefully.

• You can visit websites and services. However, downloading or modifying any portion of the website is strictly prohibited, And you can not duplicate or copy.

• All rights, including copyright and the trademark "Pluscrown" in this website are owned by or licensed to Pluscrown PRIVATE LIMITED.

• All our communication would be conducted by e-mails or by posting notices and messages on the website.

• If you believe that your intellectual property rights have been unfairly used which gives rise to security concerns, please contact us for the correct information or inquiry.

• The website is available only to those who can legally contract under applicable law. If you are under 18, you are prohibited from using purchasing contracting from this website.

                          ''',
                      style: TextStyle(
                          fontFamily: 'GothamMedium',
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width / 22,
                          color: Color.fromARGB(255, 71, 54, 111)),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        alignment: Alignment.bottomRight,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Image.asset("lib/assets/images/PlusCrown.png"),
                      ))
                ],
          ),
        ),
              ],
            )));
  }
}
