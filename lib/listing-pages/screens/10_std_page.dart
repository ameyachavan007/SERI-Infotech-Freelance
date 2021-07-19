import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/data/product_list.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/listing-pages/screens/combosCard.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';
import 'package:seri_flutter_app/homescreen/others/showView.dart';

import '../../constants.dart';

class ListingPage10Std extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  ListingPage10Std({this.loginResponse, this.cartData});

  @override
  _ListingPage10Std createState() =>
      _ListingPage10Std(loginResponse: loginResponse, cartData: cartData);
}

class _ListingPage10Std extends State<ListingPage10Std>
    with SingleTickerProviderStateMixin {
  final LoginResponse loginResponse;
  final CartData cartData;

  _ListingPage10Std({this.loginResponse, this.cartData});

  var productController;
  TabController _tabController;
  var wishlist = false;
  Future futureForEnglishComboProducts;
  Future futureForEnglishDigestProducts;
  Future futureForEnglishTextbooksProducts;
  Future futureForEnglishHelpingHandsProducts;
  Future futureForMarathiComboProducts;
  Future futureForMarathiDigestProducts;
  Future futureForMarathiTextbooksProducts;
  Future futureForMarathiHelpingHandsProducts;
  Future futureForHindiComboProducts;
  Future futureForHindiDigestProducts;
  Future futureForHindiTextbooksProducts;
  Future futureForHindiHelpingHandsProducts;
  Future futureForCart;
  bool search = false;
  var cartController;

  @override
  void initState() {
    productController = Provider.of<ProductController>(context, listen: false);
    cartController = Provider.of<CartController>(context, listen: false);
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    futureForEnglishComboProducts = productController.getProductBySubCategory(
        new ProductData(catId: "5", subCatId: "8", medium: "English"));
    futureForEnglishDigestProducts = productController.getProductBySubCategory(
        new ProductData(catId: "5", subCatId: "2", medium: "English"));
    futureForEnglishTextbooksProducts =
        productController.getProductBySubCategory(
            new ProductData(catId: "5", subCatId: "1", medium: "English"));
    futureForEnglishHelpingHandsProducts =
        productController.getProductBySubCategory(
            new ProductData(catId: "5", subCatId: "4", medium: "English"));
    futureForMarathiComboProducts = productController.getProductBySubCategory(
        new ProductData(catId: "5", subCatId: "8", medium: "Marathi"));
    futureForMarathiDigestProducts = productController.getProductBySubCategory(
        new ProductData(catId: "5", subCatId: "2", medium: "Marathi"));
    futureForMarathiTextbooksProducts =
        productController.getProductBySubCategory(
            new ProductData(catId: "5", subCatId: "1", medium: "Marathi"));
    futureForMarathiHelpingHandsProducts =
        productController.getProductBySubCategory(
            new ProductData(catId: "5", subCatId: "4", medium: "Marathi"));
    futureForHindiComboProducts = productController.getProductBySubCategory(
        new ProductData(catId: "5", subCatId: "8", medium: "Hindi"));
    futureForHindiDigestProducts = productController.getProductBySubCategory(
        new ProductData(catId: "5", subCatId: "2", medium: "Hindi"));
    futureForHindiTextbooksProducts = productController.getProductBySubCategory(
        new ProductData(catId: "5", subCatId: "1", medium: "Hindi"));
    futureForHindiHelpingHandsProducts =
        productController.getProductBySubCategory(
            new ProductData(catId: "5", subCatId: "4", medium: "Hindi"));
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int _counter = 0;
    return Scaffold(
      appBar:  search == false
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
                                  top: -10, end: -10),
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
      drawer: CustomDrawer(loginResponse, cartData),
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
                ],
              )
                  : Container(
                height: 0.0,
                width: 0.0,
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'lib/assets/icons/10th standard.gif',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, right: 3),
                child: TabBar(
                  indicatorColor: Color.fromARGB(255, 204, 0, 0),
                  indicatorWeight: 2,
                  labelColor: Color.fromARGB(255, 71, 54, 111),
                  labelStyle: TextStyle(
                      fontFamily: 'GothamMedium',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                  unselectedLabelColor: Color.fromARGB(255, 71, 54, 111),
                  labelPadding: EdgeInsets.all(0),
                  tabs: [
                    Tab(text: 'English Medium'),
                    Tab(text: 'Marathi Medium'),
                    Tab(text: 'Hindi Medium'),
                  ],
                  controller: _tabController,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                      children: [
                        FutureBuilder(
                            future: futureForEnglishComboProducts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductData> proList = snapshot.data;
                                if (proList.length > 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 4.w,
                                          left: 4.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Combos',
                                                style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              height: MediaQuery.of(context).size.height * 0.03 ,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: MaterialButton(
                                                minWidth: MediaQuery.of(context).size.width * 0.02,
                                                height: MediaQuery.of(context).size.height * 0.02,
                                                onPressed: () {
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ShowView(
                                                            loginResponse:
                                                            loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                            "Combos",
                                                          ));
                                                },
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Show all",
                                                  style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: proList.length,
                                          itemBuilder: (context, int index) {
                                            ProductData product =
                                            proList[index];
                                            return combosCard(
                                                context, index, product);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        FutureBuilder(
                            future: futureForEnglishTextbooksProducts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductData> proList = snapshot.data;
                                if (proList.length > 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 4.w,
                                          left: 4.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Textbooks',
                                                style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              height: MediaQuery.of(context).size.height * 0.03 ,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: MaterialButton(
                                                minWidth: MediaQuery.of(context).size.width * 0.02,
                                                height: MediaQuery.of(context).size.height * 0.02,
                                                onPressed: () {
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ShowView(
                                                            loginResponse:
                                                            loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                            "TextBooks",
                                                          ));
                                                },
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Show all",
                                                  style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: proList.length,
                                          itemBuilder: (context, int index) {
                                            ProductData product =
                                            proList[index];
                                            return ProductList(product,
                                                loginResponse, cartData);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        FutureBuilder(
                            future: futureForEnglishDigestProducts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductData> proList = snapshot.data;
                                if (proList.length > 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 4.w,
                                          left: 4.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Digests',
                                                style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              height: MediaQuery.of(context).size.height * 0.03 ,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: MaterialButton(
                                                minWidth: MediaQuery.of(context).size.width * 0.02,
                                                height: MediaQuery.of(context).size.height * 0.02,
                                                onPressed: () {
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ShowView(
                                                            loginResponse:
                                                            loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                            "Digests",
                                                          ));
                                                },
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Show all",
                                                  style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: proList.length,
                                          itemBuilder: (context, int index) {
                                            ProductData product =
                                            proList[index];
                                            return ProductList(product,
                                                loginResponse, cartData);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        FutureBuilder(
                            future: futureForEnglishHelpingHandsProducts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductData> proList = snapshot.data;
                                if (proList.length > 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 4.w,
                                          left: 4.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Helping Hands',
                                                style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              height: MediaQuery.of(context).size.height * 0.03 ,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: MaterialButton(
                                                minWidth: MediaQuery.of(context).size.width * 0.02,
                                                height: MediaQuery.of(context).size.height * 0.02,
                                                onPressed: () {
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ShowView(
                                                            loginResponse:
                                                            loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                            "Helping Hands",
                                                          ));
                                                },
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Show all",
                                                  style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: proList.length,
                                          itemBuilder: (context, int index) {
                                            ProductData product =
                                            proList[index];
                                            return ProductList(product,
                                                loginResponse, cartData);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        SizedBox(height: 14.h)
                      ],
                    ),
                    ListView(
                      children: [
                        FutureBuilder(
                            future: futureForMarathiComboProducts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductData> proList = snapshot.data;
                                if (proList.length > 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 4.w,
                                          left: 4.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Combos',
                                                style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              height: MediaQuery.of(context).size.height * 0.03 ,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: MaterialButton(
                                                minWidth: MediaQuery.of(context).size.width * 0.02,
                                                height: MediaQuery.of(context).size.height * 0.02,
                                                onPressed: () {
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ShowView(
                                                            loginResponse:
                                                            loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                            "Combos",
                                                          ));
                                                },
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Show all",
                                                  style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: proList.length,
                                          itemBuilder: (context, int index) {
                                            ProductData product =
                                            proList[index];
                                            return combosCard(
                                                context, index, product);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        FutureBuilder(
                            future: futureForMarathiTextbooksProducts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductData> proList = snapshot.data;
                                if (proList.length > 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 4.w,
                                          left: 4.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Textbooks',
                                                style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              height: MediaQuery.of(context).size.height * 0.03 ,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: MaterialButton(
                                                minWidth: MediaQuery.of(context).size.width * 0.02,
                                                height: MediaQuery.of(context).size.height * 0.02,
                                                onPressed: () {
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ShowView(
                                                            loginResponse:
                                                            loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                            "TextBooks",
                                                          ));
                                                },
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Show all",
                                                  style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: proList.length,
                                          itemBuilder: (context, int index) {
                                            ProductData product =
                                            proList[index];
                                            return ProductList(product,
                                                loginResponse, cartData);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        FutureBuilder(
                            future: futureForMarathiDigestProducts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductData> proList = snapshot.data;
                                if (proList.length > 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 4.w,
                                          left: 4.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Digests',
                                                style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              height: MediaQuery.of(context).size.height * 0.03 ,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: MaterialButton(
                                                minWidth: MediaQuery.of(context).size.width * 0.02,
                                                height: MediaQuery.of(context).size.height * 0.02,
                                                onPressed: () {
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ShowView(
                                                            loginResponse:
                                                            loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                            "Digests",
                                                          ));
                                                },
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Show all",
                                                  style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: proList.length,
                                          itemBuilder: (context, int index) {
                                            ProductData product =
                                            proList[index];
                                            return ProductList(product,
                                                loginResponse, cartData);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        FutureBuilder(
                            future: futureForMarathiHelpingHandsProducts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductData> proList = snapshot.data;
                                if (proList.length > 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 4.w,
                                          left: 4.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Helping Hands',
                                                style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              height: MediaQuery.of(context).size.height * 0.03 ,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: MaterialButton(
                                                minWidth: MediaQuery.of(context).size.width * 0.02,
                                                height: MediaQuery.of(context).size.height * 0.02,
                                                onPressed: () {
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ShowView(
                                                            loginResponse:
                                                            loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                            "Helping Hands",
                                                          ));
                                                },
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Show all",
                                                  style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: proList.length,
                                          itemBuilder: (context, int index) {
                                            ProductData product =
                                            proList[index];
                                            return ProductList(product,
                                                loginResponse, cartData);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        SizedBox(height: 14.h)
                      ],
                    ),
                    ListView(
                      children: [
                        FutureBuilder(
                            future: futureForHindiComboProducts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductData> proList = snapshot.data;
                                if (proList.length > 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 4.w,
                                          left: 4.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Combos',
                                                style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              height: MediaQuery.of(context).size.height * 0.03 ,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: MaterialButton(
                                                minWidth: MediaQuery.of(context).size.width * 0.02,
                                                height: MediaQuery.of(context).size.height * 0.02,
                                                onPressed: () {
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ShowView(
                                                            loginResponse:
                                                            loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                            "Combos",
                                                          ));
                                                },
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Show all",
                                                  style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: proList.length,
                                          itemBuilder: (context, int index) {
                                            ProductData product =
                                            proList[index];
                                            return combosCard(
                                                context, index, product);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        FutureBuilder(
                            future: futureForHindiTextbooksProducts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductData> proList = snapshot.data;
                                if (proList.length > 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 4.w,
                                          left: 4.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Textbooks',
                                                style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              height: MediaQuery.of(context).size.height * 0.03 ,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: MaterialButton(
                                                minWidth: MediaQuery.of(context).size.width * 0.02,
                                                height: MediaQuery.of(context).size.height * 0.02,
                                                onPressed: () {
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ShowView(
                                                            loginResponse:
                                                            loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                            "TextBooks",
                                                          ));
                                                },
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Show all",
                                                  style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: proList.length,
                                          itemBuilder: (context, int index) {
                                            ProductData product =
                                            proList[index];
                                            return ProductList(product,
                                                loginResponse, cartData);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        FutureBuilder(
                            future: futureForHindiDigestProducts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductData> proList = snapshot.data;
                                if (proList.length > 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 4.w,
                                          left: 4.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Digests',
                                                style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              height: MediaQuery.of(context).size.height * 0.03 ,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: MaterialButton(
                                                minWidth: MediaQuery.of(context).size.width * 0.02,
                                                height: MediaQuery.of(context).size.height * 0.02,
                                                onPressed: () {
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ShowView(
                                                            loginResponse:
                                                            loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                            "Digests",
                                                          ));
                                                },
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Show all",
                                                  style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: proList.length,
                                          itemBuilder: (context, int index) {
                                            ProductData product =
                                            proList[index];
                                            return ProductList(product,
                                                loginResponse, cartData);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        FutureBuilder(
                            future: futureForHindiHelpingHandsProducts,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<ProductData> proList = snapshot.data;
                                if (proList.length > 0) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 4.w,
                                          left: 4.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Helping Hands',
                                                style: TextStyle(
                                                  fontFamily: 'GothamMedium',
                                                  color: Color.fromARGB(
                                                      255, 71, 54, 111),
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Container(

                                              height: MediaQuery.of(context).size.height * 0.03 ,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.black),
                                                  top: BorderSide(color: Colors.black),
                                                  left: BorderSide(color: Colors.black),
                                                  right: BorderSide(color: Colors.black),
                                                ),
                                              ),
                                              child: MaterialButton(
                                                minWidth: MediaQuery.of(context).size.width * 0.02,
                                                height: MediaQuery.of(context).size.height * 0.02,
                                                onPressed: () {
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                      context) =>
                                                          ShowView(
                                                            loginResponse:
                                                            loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                            "Helping Hands",
                                                          ));
                                                },
                                                color: Color.fromARGB(255, 71, 54, 111),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Show all",
                                                  style: TextStyle(
                                                    fontFamily: 'GothamMedium',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 8.0.sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.4,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: proList.length,
                                          itemBuilder: (context, int index) {
                                            ProductData product =
                                            proList[index];
                                            return ProductList(product,
                                                loginResponse, cartData);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            }),
                        SizedBox(height: 14.h)
                      ],
                    ),
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