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

class EmptyWishListPage extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  EmptyWishListPage(this.loginResponse, this.cartData);

  @override
  _EmptyWishListPageState createState() =>
      _EmptyWishListPageState(loginResponse, cartData);
}

class _EmptyWishListPageState extends State<EmptyWishListPage> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _EmptyWishListPageState(this.loginResponse, this.cartData);

  MediaQueryData queryData;
  bool search = false;
  Future futureForCart;

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
    queryData = MediaQuery.of(context);
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
          "Wishlist",
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
                                ? Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        EmptyCartPage(
                                          loginResponse,
                                          cartData,
                                        )))
                                : Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => Cart(
                                          loginResponse,
                                          cartData,
                                        )));
                          },
                          child: Badge(
                              position: BadgePosition.topEnd(top: -8, end: -10),
                              badgeColor: Colors.white,
                              badgeContent: Text(
                                cartData.cartProducts.length.toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 35),
                              ),
                              child: Image.asset(
                                'lib/assets/icons/cart1.png',
                                width: MediaQuery.of(context).size.width * 0.07,
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
          ]
                  )
                  : Container(
                height: 0.0,
                width: 0.0,
              ),
              Center(
                child: Column(
                 // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height /4),
                    Container(
                      height: 15.h,
                      child: Image.asset('lib/assets/icons/wishlist empty.png'),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'You have no items in the wishlist',
                      style: TextStyle(
                        fontFamily: 'GothamMedium',
                        color: Color.fromARGB(255, 71, 54, 111),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 71, 54, 111),
                        shape: const BeveledRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        minimumSize: Size((queryData.size.width / 3),
                            (queryData.size.height / 20)),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Continue Shopping',
                        style: TextStyle(
                          fontFamily: 'GothamMedium',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
