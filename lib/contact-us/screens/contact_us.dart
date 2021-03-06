import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:intent/action.dart' as android_action;
import 'package:intent/intent.dart' as android_intent;
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class ContactUs extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const ContactUs(this.loginResponse, this.cartData);

  @override
  _ContactUsState createState() => _ContactUsState(loginResponse, cartData);
}

class _ContactUsState extends State<ContactUs> {
  final LoginResponse loginResponse;
  final CartData cartData;

  MediaQueryData queryData;

  _ContactUsState(this.loginResponse, this.cartData);

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
    queryData = MediaQuery.of(context);
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
          "Contact Us",
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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            search == true?
            StickyHeader(
              header: Column(
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
              ),
              content: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  //  height: MediaQuery.of(context).size.height,
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //  new Spacer(),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('lib/assets/icons/call.png',
                                width: (queryData.size.width / 10)),
                            SizedBox(width: queryData.size.width / 10),
                            TextButton(
                              style:
                                  TextButton.styleFrom(primary: Colors.transparent),
                              onPressed: () => android_intent.Intent()
                                ..setAction(android_action.Action.ACTION_VIEW)
                                ..setData(Uri(scheme: "tel", path: "+919960622176"))
                                ..startActivity().catchError((e) => print(e)),
                              child: Text(
                                '9960622176',
                                style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontSize: 13.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('lib/assets/icons/location.png',
                                width: (queryData.size.width / 10)),
                            SizedBox(width: queryData.size.width / 10),
                            TextButton(
                              style:
                                  TextButton.styleFrom(primary: Colors.transparent),
                              onPressed: () async => await launch(
                                  "https://www.google.com/maps/place/Dream+House/@19.2072,73.1765113,17z/data=!4m8!1m2!2m1!1sDream+House,+Kansai+section,+Ambernath+(E),+%5CnPincode+-+421501,+Dist-+Thane!3m4!1s0x3be7947e4907f4c3:0xfddd74faa60817e8!8m2!3d19.207164!4d73.1787409"),
                              child: Text(
                                '627, Dream House, Kansai\nsection, Ambernath (E), \nPincode - 421501, Dist- Thane',
                                style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontSize: 13.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('lib/assets/icons/mail.png',
                                width: (queryData.size.width / 10)),
                            SizedBox(width: queryData.size.width / 10),
                            TextButton(
                              style:
                                  TextButton.styleFrom(primary: Colors.transparent),
                              onPressed: () => android_intent.Intent()
                                ..setAction(android_action.Action.ACTION_VIEW)
                                ..setData(Uri(
                                    scheme: "mailto", path: "Pluscrown58@gmail.com"))
                                ..startActivity().catchError((e) => print(e)),
                              child: Text(
                                'Pluscrown58@gmail.com',
                                style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontSize: 13.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('lib/assets/icons/whatsapp icon.png',
                                width: (queryData.size.width / 10)),
                            SizedBox(width: queryData.size.width / 10),
                            TextButton(
                              style:
                                  TextButton.styleFrom(primary: Colors.transparent),
                              onPressed: () async => await launch(
                                  // Change to working number in Production
                                  "https://wa.me/+919021762183?text=Hello"),
                              child: Text(
                                '9960622176',
                                style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontSize: 13.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // new Spacer(),
                      SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 100.0, 10.0, 0.0),
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          'lib/assets/icons/contact_us_bottom_image.jpg',
                          height: (queryData.size.width / 2),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              alignment: Alignment.bottomRight,
                              child: Image.asset(
                                'lib/assets/images/bottom_logo.jpg',
                                width: (queryData.size.width / 3),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ): Container(),
            search != true?
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                //  height: MediaQuery.of(context).size.height,
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  new Spacer(),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('lib/assets/icons/call.png',
                              width: (queryData.size.width / 10)),
                          SizedBox(width: queryData.size.width / 10),
                          TextButton(
                            style:
                            TextButton.styleFrom(primary: Colors.transparent),
                            onPressed: () => android_intent.Intent()
                              ..setAction(android_action.Action.ACTION_VIEW)
                              ..setData(Uri(scheme: "tel", path: "+919960622176"))
                              ..startActivity().catchError((e) => print(e)),
                            child: Text(
                              '9960622176',
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontSize: 13.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('lib/assets/icons/location.png',
                              width: (queryData.size.width / 10)),
                          SizedBox(width: queryData.size.width / 10),
                          TextButton(
                            style:
                            TextButton.styleFrom(primary: Colors.transparent),
                            onPressed: () async => await launch(
                                "https://www.google.com/maps/place/Dream+House/@19.2072,73.1765113,17z/data=!4m8!1m2!2m1!1sDream+House,+Kansai+section,+Ambernath+(E),+%5CnPincode+-+421501,+Dist-+Thane!3m4!1s0x3be7947e4907f4c3:0xfddd74faa60817e8!8m2!3d19.207164!4d73.1787409"),
                            child: Text(
                              '627, Dream House, Kansai\nsection, Ambernath (E), \nPincode - 421501, Dist- Thane',
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontSize: 13.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('lib/assets/icons/mail.png',
                              width: (queryData.size.width / 10)),
                          SizedBox(width: queryData.size.width / 10),
                          TextButton(
                            style:
                            TextButton.styleFrom(primary: Colors.transparent),
                            onPressed: () => android_intent.Intent()
                              ..setAction(android_action.Action.ACTION_VIEW)
                              ..setData(Uri(
                                  scheme: "mailto", path: "Pluscrown58@gmail.com"))
                              ..startActivity().catchError((e) => print(e)),
                            child: Text(
                              'Pluscrown58@gmail.com',
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontSize: 13.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(0, 0.0, 0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('lib/assets/icons/whatsapp icon.png',
                              width: (queryData.size.width / 10)),
                          SizedBox(width: queryData.size.width / 10),
                          TextButton(
                            style:
                            TextButton.styleFrom(primary: Colors.transparent),
                            onPressed: () async => await launch(
                              // Change to working number in Production
                                "https://wa.me/+919021762183?text=Hello"),
                            child: Text(
                              '9960622176',
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontSize: 13.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // new Spacer(),
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 100.0, 10.0, 0.0),
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        'lib/assets/icons/contact_us_bottom_image.jpg',
                        height: (queryData.size.width / 2),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              'lib/assets/images/bottom_logo.jpg',
                              width: (queryData.size.width / 3),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ): Container()
          ],
        ),
      ),
    );
  }
}
