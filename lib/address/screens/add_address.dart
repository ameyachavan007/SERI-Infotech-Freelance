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
import 'address-book-page.dart';

class Address extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const Address(this.loginResponse, this.cartData);

  @override
  _AddressState createState() => _AddressState(loginResponse, cartData);
}

class _AddressState extends State<Address> {
  final LoginResponse loginResponse;
  final CartData cartData;
  Future futureForCart;

  var cartController = CartController();

  final formKey = GlobalKey<FormState>();
  bool search = false;

  @override
  void initState() {
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    super.initState();
  }

  TextEditingController nameTextEditingController = new TextEditingController();
  TextEditingController numberTextEditingController =
      new TextEditingController();
  TextEditingController pinCodeTextEditingController =
      new TextEditingController();
  TextEditingController cityTextEditingController = new TextEditingController();
  TextEditingController flatNoTextEditingController =
      new TextEditingController();
  TextEditingController areaTextEditingController = new TextEditingController();
  TextEditingController landmarkTextEditingController =
      new TextEditingController();
  TextEditingController districtTextEditingController =
      new TextEditingController();

  int _radioValue1 = 0;

  _AddressState(this.loginResponse, this.cartData);

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: search == false
            ? AppBar(
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
                  "Add Address",
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
                                                builder:
                                                    (BuildContext context) =>
                                                        EmptyCartPage(
                                                          loginResponse,
                                                          cartData,
                                                        )))
                                        : Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Cart(
                                                          loginResponse,
                                                          cartData,
                                                        )));
                                  },
                                  child: Badge(
                                      position: BadgePosition.topEnd(
                                          top: -8, end: -10),
                                      badgeColor: Colors.white,
                                      badgeContent: Text(
                                        cartData.cartProducts.length.toString(),
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                35),
                                      ),
                                      child: Image.asset(
                                        'lib/assets/icons/cart1.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
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
              )
            : null,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              search == true
                  ? StickyHeader(
                      header: Column(
                        children: [
                          Container(
                            height: 20,
                          ),
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
                                              color: kPrimaryColor
                                                  .withOpacity(0.5),
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
                        padding: const EdgeInsets.only(
                            left: 11.0, right: 11, top: 18, bottom: 18),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Contact Info",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontFamily: 'GothamMedium',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                controller: nameTextEditingController,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontFamily: 'GothamMedium',
                                  fontSize:
                                      MediaQuery.of(context).size.width / 19,
                                ),
                                validator: (val) {
                                  return val.length > 2
                                      ? null
                                      : "Please provide name";
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding,
                                      vertical: kDefaultPadding,
                                    ),
                                    labelText: 'Name',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontFamily: 'GothamMedium',
                                    )),
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                validator: (val) {
                                  return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                          .hasMatch(val)
                                      ? null
                                      : "Please provide valid number";
                                },
                                controller: numberTextEditingController,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontFamily: 'GothamMedium',
                                  fontSize:
                                      MediaQuery.of(context).size.width / 19,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    labelText: 'Phone Number',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontFamily: 'GothamMedium',
                                    )),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Address Info",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontFamily: 'GothamMedium',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        child: TextFormField(
                                          validator: (val) {
                                            return RegExp(r'(^[1-9][0-9]{5}$)')
                                                    .hasMatch(val)
                                                ? null
                                                : "Please provide valid PinCode";
                                          },
                                          controller:
                                              pinCodeTextEditingController,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 71, 54, 111),
                                            fontFamily: 'GothamMedium',
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                19,
                                          ),
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                gapPadding: 10,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                gapPadding: 10,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                gapPadding: 10,
                                              ),
                                              labelText: 'PinCode',
                                              labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 71, 54, 111),
                                                fontFamily: 'GothamMedium',
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                20,
                                      )
                                    ],
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: TextFormField(
                                      validator: (val) {
                                        return val.isEmpty || val.length < 2
                                            ? "Please Provide valid city"
                                            : null;
                                      },
                                      controller: cityTextEditingController,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontFamily: 'GothamMedium',
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                19,
                                      ),
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 71, 54, 111),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gapPadding: 10,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 71, 54, 111),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gapPadding: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 71, 54, 111),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gapPadding: 10,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: kDefaultPadding,
                                            vertical: kDefaultPadding,
                                          ),
                                          labelText: 'City',
                                          labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 71, 54, 111),
                                            fontFamily: 'GothamMedium',
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                validator: (val) {
                                  return val.isEmpty || val.length < 2
                                      ? "Please Provide valid District"
                                      : null;
                                },
                                controller: districtTextEditingController,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontFamily: 'GothamMedium',
                                  fontSize:
                                      MediaQuery.of(context).size.width / 19,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding,
                                      vertical: kDefaultPadding,
                                    ),
                                    labelText: 'District',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontFamily: 'GothamMedium',
                                    )),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                validator: (val) {
                                  return val.isEmpty
                                      ? "Please Provide Flat No / Building Name "
                                      : null;
                                },
                                controller: flatNoTextEditingController,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontFamily: 'GothamMedium',
                                  fontSize:
                                      MediaQuery.of(context).size.width / 19,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding,
                                      vertical: kDefaultPadding,
                                    ),
                                    labelText: 'Flat No / Building Name',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontFamily: 'GothamMedium',
                                    )),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                validator: (val) {
                                  return val.isEmpty
                                      ? "Please Provide Locality / Area / Street "
                                      : null;
                                },
                                controller: areaTextEditingController,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontFamily: 'GothamMedium',
                                  fontSize:
                                      MediaQuery.of(context).size.width / 19,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding,
                                      vertical: kDefaultPadding,
                                    ),
                                    labelText: 'Locality / Area / Street',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontFamily: 'GothamMedium',
                                    )),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                controller: landmarkTextEditingController,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 71, 54, 111),
                                  fontFamily: 'GothamMedium',
                                  fontSize:
                                      MediaQuery.of(context).size.width / 19,
                                ),
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                      gapPadding: 10,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding,
                                      vertical: kDefaultPadding,
                                    ),
                                    labelText: 'Landmark(Optional)',
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontFamily: 'GothamMedium',
                                    )),
                              ),
                              SizedBox(height: 8),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Type of Address",
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Radio(
                                    activeColor:
                                        Color.fromARGB(255, 71, 54, 111),
                                    value: 0,
                                    groupValue: _radioValue1,
                                    onChanged: _handleRadioValueChange1,
                                  ),
                                  new Text('Home',
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20)),
                                  new Radio(
                                    activeColor:
                                        Color.fromARGB(255, 71, 54, 111),
                                    value: 1,
                                    groupValue: _radioValue1,
                                    onChanged: _handleRadioValueChange1,
                                  ),
                                  new Text('Office',
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20)),
                                  new Radio(
                                    activeColor:
                                        Color.fromARGB(255, 71, 54, 111),
                                    value: 2,
                                    groupValue: _radioValue1,
                                    onChanged: _handleRadioValueChange1,
                                  ),
                                  new Text('Other',
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 3, top: 3.0),
                                      child: SizedBox(
                                        height: 8,
                                        width: 8,
                                        child: Transform.scale(
                                          scale: 1,
                                          child: Checkbox(
                                            value: checkValue,
                                            activeColor: Color.fromARGB(
                                                255, 71, 54, 111),
                                            onChanged: (newValue) {
                                              setState(() {
                                                checkValue = newValue;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text("Mark as default Address",
                                        style: TextStyle(
                                            fontFamily: 'GothamMedium',
                                            color: Color.fromARGB(
                                                255, 71, 54, 111),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                19)),
                                  ]),
                              SizedBox(
                                height: 18,
                              ),
                              ElevatedButton(
                                child: Text("Save Address",
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                19)),
                                onPressed: () {
                                  if (formKey.currentState.validate())
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddressBookPage(
                                                    loginResponse, cartData)));
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 71, 54, 111),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 0.0,
                      width: 0.0,
                    ),
              search != true
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 11.0, right: 11, top: 18, bottom: 18),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Contact Info",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontFamily: 'GothamMedium',
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: nameTextEditingController,
                              style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontSize:
                                    MediaQuery.of(context).size.width / 19,
                              ),
                              validator: (val) {
                                return val.length > 2
                                    ? null
                                    : "Please provide name";
                              },
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding,
                                  ),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 71, 54, 111),
                                    fontFamily: 'GothamMedium',
                                  )),
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              validator: (val) {
                                return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                        .hasMatch(val)
                                    ? null
                                    : "Please provide valid number";
                              },
                              controller: numberTextEditingController,
                              style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontSize:
                                    MediaQuery.of(context).size.width / 19,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  labelText: 'Phone Number',
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 71, 54, 111),
                                    fontFamily: 'GothamMedium',
                                  )),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Address Info",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontFamily: 'GothamMedium',
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      child: TextFormField(
                                        validator: (val) {
                                          return RegExp(r'(^[1-9][0-9]{5}$)')
                                                  .hasMatch(val)
                                              ? null
                                              : "Please provide valid PinCode";
                                        },
                                        controller:
                                            pinCodeTextEditingController,
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontFamily: 'GothamMedium',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              19,
                                        ),
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 71, 54, 111),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              gapPadding: 10,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 71, 54, 111),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              gapPadding: 10,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 71, 54, 111),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              gapPadding: 10,
                                            ),
                                            labelText: 'PinCode',
                                            labelStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 71, 54, 111),
                                              fontFamily: 'GothamMedium',
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          20,
                                    )
                                  ],
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: TextFormField(
                                    validator: (val) {
                                      return val.isEmpty || val.length < 2
                                          ? "Please Provide valid city"
                                          : null;
                                    },
                                    controller: cityTextEditingController,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      fontFamily: 'GothamMedium',
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              19,
                                    ),
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 71, 54, 111),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          gapPadding: 10,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 71, 54, 111),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          gapPadding: 10,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 71, 54, 111),
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          gapPadding: 10,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: kDefaultPadding,
                                          vertical: kDefaultPadding,
                                        ),
                                        labelText: 'City',
                                        labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontFamily: 'GothamMedium',
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty || val.length < 2
                                    ? "Please Provide valid District"
                                    : null;
                              },
                              controller: districtTextEditingController,
                              style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontSize:
                                    MediaQuery.of(context).size.width / 19,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding,
                                  ),
                                  labelText: 'District',
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 71, 54, 111),
                                    fontFamily: 'GothamMedium',
                                  )),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty
                                    ? "Please Provide Flat No / Building Name "
                                    : null;
                              },
                              controller: flatNoTextEditingController,
                              style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontSize:
                                    MediaQuery.of(context).size.width / 19,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding,
                                  ),
                                  labelText: 'Flat No / Building Name',
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 71, 54, 111),
                                    fontFamily: 'GothamMedium',
                                  )),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty
                                    ? "Please Provide Locality / Area / Street "
                                    : null;
                              },
                              controller: areaTextEditingController,
                              style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontSize:
                                    MediaQuery.of(context).size.width / 19,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding,
                                  ),
                                  labelText: 'Locality / Area / Street',
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 71, 54, 111),
                                    fontFamily: 'GothamMedium',
                                  )),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: landmarkTextEditingController,
                              style: TextStyle(
                                color: Color.fromARGB(255, 71, 54, 111),
                                fontFamily: 'GothamMedium',
                                fontSize:
                                    MediaQuery.of(context).size.width / 19,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 71, 54, 111),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    gapPadding: 10,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding,
                                    vertical: kDefaultPadding,
                                  ),
                                  labelText: 'Landmark(Optional)',
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 71, 54, 111),
                                    fontFamily: 'GothamMedium',
                                  )),
                            ),
                            SizedBox(height: 8),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Type of Address",
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Radio(
                                  activeColor: Color.fromARGB(255, 71, 54, 111),
                                  value: 0,
                                  groupValue: _radioValue1,
                                  onChanged: _handleRadioValueChange1,
                                ),
                                new Text('Home',
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20)),
                                new Radio(
                                  activeColor: Color.fromARGB(255, 71, 54, 111),
                                  value: 1,
                                  groupValue: _radioValue1,
                                  onChanged: _handleRadioValueChange1,
                                ),
                                new Text('Office',
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20)),
                                new Radio(
                                  activeColor: Color.fromARGB(255, 71, 54, 111),
                                  value: 2,
                                  groupValue: _radioValue1,
                                  onChanged: _handleRadioValueChange1,
                                ),
                                new Text('Other',
                                    style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Color.fromARGB(255, 71, 54, 111),
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, top: 3.0),
                                    child: SizedBox(
                                      height: 8,
                                      width: 8,
                                      child: Transform.scale(
                                        scale: 1,
                                        child: Checkbox(
                                          value: checkValue,
                                          activeColor:
                                              Color.fromARGB(255, 71, 54, 111),
                                          onChanged: (newValue) {
                                            setState(() {
                                              checkValue = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("Mark as default Address",
                                      style: TextStyle(
                                          fontFamily: 'GothamMedium',
                                          color:
                                              Color.fromARGB(255, 71, 54, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              19)),
                                ]),
                            SizedBox(
                              height: 18,
                            ),
                            ElevatedButton(
                              child: Text("Save Address",
                                  style: TextStyle(
                                      fontFamily: 'GothamMedium',
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              19)),
                              onPressed: () {
                                if (formKey.currentState.validate())
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddressBookPage(
                                              loginResponse, cartData)));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 71, 54, 111),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
