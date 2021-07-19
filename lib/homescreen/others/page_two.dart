import 'package:badges/badges.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/data/product_data.dart';
import 'package:seri_flutter_app/homescreen/data/product_list.dart';
import 'package:seri_flutter_app/homescreen/data/title.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

class PageTwo extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const PageTwo(this.loginResponse, this.cartData);

  @override
  _PageTwoState createState() => _PageTwoState(loginResponse, cartData);
}

List _image_list = ['text1', 'text2', 'text3'];

String _currentImage = "main";

bool _btn1 = true;
bool _btn2 = false;
bool wishlist = false;

class _PageTwoState extends State<PageTwo> {
  final LoginResponse loginResponse;
  final CartData cartData;
  String email_add;
  bool _obscureText = false;
  bool valuefirst = false;
  bool search = false;
  int cart_length;


  _PageTwoState(this.loginResponse, this.cartData);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(loginResponse, cartData),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          search == true
              ? Stack(
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
          )
              : Container(
            height: 0.0,
            width: 0.0,
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding, vertical: kDefaultPadding),
                  child: Text(
                    "Craft Club Printed Diary In euro Binding A5 Diary Unruled 200 Pages (multicolor)",
                    style: TextStyle(
                        fontFamily: 'GothamMedium',
                        color: kPrimaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.065,
                          width: size.height * 0.065,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              "30%\noff",
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            height: size.height * 0.3,
                            width: size.width * 0.6,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: Text(_currentImage),
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.3,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    wishlist =
                                        wishlist == false ? true : false;
                                  });
                                },
                                child: Container(
                                  child: wishlist == true
                                      ? Image.asset(
                                          'lib/assets/images/wishlisted.png',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                        )
                                      : Image.asset(
                                          'lib/assets/images/wishlist.png',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                        ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  'lib/assets/icons/share.png',
                                  width: size.width * 0.07,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentImage = _image_list[0];
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            height: size.height * 0.2,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: Text('text1'),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentImage = _image_list[1];
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            height: size.height * 0.2,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: Text('text2'),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentImage = _image_list[2];
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            height: size.height * 0.2,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: Text('text3'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: kDefaultPadding),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: kDefaultPadding, right: size.width * 0.5),
                    width: size.width * 0.5,
                    height: size.height * 0.04,
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      border: Border.all(
                        color: kPrimaryColor.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Center(
                      child: Text(
                        'Currently Unavailable',
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: kDefaultPadding,
                  ),
                  width: size.width,
                  height: size.height * 0.31,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kPrimaryColor.withOpacity(0.5),
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: kDefaultPadding / 2,
                        left: kDefaultPadding / 2,
                        child: RichText(
                          text: TextSpan(
                            text: "Notify me when the product is back ",
                            style: TextStyle(
                              fontFamily: 'GothamMedium',
                              fontSize: 13,
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'in Stock',
                                style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: kDefaultPadding + kDefaultPadding * 0.3,
                        left: kDefaultPadding / 2,
                        child: Text(
                          'Enter your Email address, we will notify you when it comes\nback in stock',
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            fontSize: 11,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Positioned(
                        height: size.height * 0.08,
                        width: size.width * 0.8,
                        top: (size.height * 0.3) * 0.3,
                        left: kDefaultPadding / 2,
                        child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          child: TextFormField(
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                          r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                                          r"{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(val)
                                  ? null
                                  : "Please provide valid number or Email ID";
                            },
                            onChanged: (value) => email_add = value,
                            cursorColor: kPrimaryColor,
                            style: TextStyle(
                              fontFamily: 'GothamMedium',
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: kPrimaryColor,
                                  width: 1,
                                ),
                              ),
                              labelText: "Email ",
                              labelStyle: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontSize: 12,
                                color: kPrimaryColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: kDefaultPadding / 2,
                        top: (size.height * 0.3) * 0.6,
                        child: MaterialButton(
                          minWidth: size.width * 0.30,
                          height: size.height * 0.05,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => null));
                          },
                          color: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      Positioned(
                        top: (size.height * 0.3) * 0.8,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  activeColor: kPrimaryColor,
                                  value: this.valuefirst,
                                  onChanged: (bool value) {
                                    setState(() {
                                      this.valuefirst = value;
                                    });
                                  },
                                ),
                              ),
                              Text(
                                'Receive Exclusive Offers.Terms and Conditions & \nPrivacy and Policy',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontFamily: 'GothamMedium',
                                  // fontSize: 8.0.sp,
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Rs. ',
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(text: "400 "),
                            TextSpan(
                              text: "Rs 600",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontFamily: 'GothamMedium',
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: " 30" + '%' + "Off",
                              style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'GothamMedium',
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Price inclusive of all taxes",
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: Colors.red,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: kDefaultPadding,
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Details",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontFamily: 'GothamMedium',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2,
                            vertical: kDefaultPadding / 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Best quality product",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontFamily: 'GothamMedium',
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Pages",
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Back Cover",
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Posters",
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: kDefaultPadding,
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Description",
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: kDefaultPadding / 2,
                          left: kDefaultPadding / 2,
                          right: kDefaultPadding / 2,
                        ),
                        child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: kDefaultPadding,
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Returns",
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding / 2,
                          vertical: kDefaultPadding / 2,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text:
                                'Easy 10 days return and exchange. Return policies may vary based on products, for complete details on our Return policies, please ',
                            style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: kPrimaryColor,
                              fontSize: 15,
                            ),
                            children: [
                              TextSpan(
                                text: "Click Here",
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () => {},
                                style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: kDefaultPadding,
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                ),
                TitleHome(
                  title: 'You may also Like',
                ),
                Container(
                  height: size.height * 0.35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productList.length,
                    itemBuilder: (context, int index) {
                      ProductData product = productList[index];
                      return ProductList(product, loginResponse, cartData);
                    },
                  ),
                ),
                Divider(
                  height: kDefaultPadding,
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                ),
                TitleHome(
                  title: 'Similar Products',
                ),
                Container(
                  height: size.height * 0.35,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: productList.length,
                    itemBuilder: (context, int index) {
                      ProductData product = productList[index];
                      return ProductList(product, loginResponse, cartData);
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: size.width,
        height: size.height * 0.08,
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryColor.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _btn1 = !_btn1;
                  _btn2 = !_btn2;
                });
              },
              child: Container(
                margin: EdgeInsets.all(10),
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  color: _btn1 ? kPrimaryColor : Colors.white,
                  border: Border.all(
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Add to cart",
                    style: TextStyle(
                        color: _btn1 ? Colors.white : kPrimaryColor),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _btn2 = !_btn2;
                  _btn1 = !_btn1;
                });
              },
              child: Container(
                margin: EdgeInsets.all(10),
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  color: _btn2 ? kPrimaryColor : Colors.white,
                  border: Border.all(
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Buy Now",
                    style: TextStyle(
                        color: _btn2 ? Colors.white : kPrimaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: search == false
          ? AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromARGB(255, 71, 54, 111),
        title: Image.asset(
          'lib/assets/Logo/Plus Crown 1.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.07,
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

                GestureDetector(
                  onTap: () {
                    cart_length == 0
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
                        "4",
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
                ),

                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        ],
      )
          : null,
    );
  }
}
