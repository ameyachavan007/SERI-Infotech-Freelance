import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../constants.dart';
import 'add_address.dart';
import 'address-book.dart';

class AddressBookPage extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  AddressBookPage(this.loginResponse, this.cartData);

  @override
  _AddressBookPageState createState() =>
      _AddressBookPageState(loginResponse: loginResponse, cartData: cartData);
}

class _AddressBookPageState extends State<AddressBookPage> {
  final LoginResponse loginResponse;
  final CartData cartData;

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

  _AddressBookPageState({this.loginResponse, this.cartData});

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
          "Address Book",
          style: TextStyle(fontFamily: 'GothamMedium', fontSize: 16.sp),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            search == true
                ?
            StickyHeader(
              header: Stack(
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
              ) ,
              content: Padding(
                  padding: const EdgeInsets.only(
                      left: 11.0, right: 11, top: 18, bottom: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: AddressBook(loginResponse, cartData),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Address(loginResponse, cartData)));
                        },
                        child: Row(
                          children: [
                            Container(
                                child: Icon(
                              Icons.add,
                              color: Color.fromARGB(255, 71, 54, 111),
                              size: MediaQuery.of(context).size.width / 23,
                            )),
                            SizedBox(width: 4),
                            Text("Add new Address",
                                style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontSize: MediaQuery.of(context).size.width / 23,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                    ],
                  )),
            ): Container(
              height: 0.0,
              width: 0.0,
            ),
            search != true?
            Padding(
                padding: const EdgeInsets.only(
                    left: 11.0, right: 11, top: 18, bottom: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: AddressBook(loginResponse, cartData),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Address(loginResponse, cartData)));
                      },
                      child: Row(
                        children: [
                          Container(
                              child: Icon(
                                Icons.add,
                                color: Color.fromARGB(255, 71, 54, 111),
                                size: MediaQuery.of(context).size.width / 23,
                              )),
                          SizedBox(width: 4),
                          Text("Add new Address",
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontSize: MediaQuery.of(context).size.width / 23,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                )):Container()
          ],
        ),
      ),
    );
  }
}
