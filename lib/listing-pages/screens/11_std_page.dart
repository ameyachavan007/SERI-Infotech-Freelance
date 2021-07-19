import 'package:badges/badges.dart';
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
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';
import 'package:seri_flutter_app/homescreen/others/showView.dart';

import '../../constants.dart';
import 'combosCard.dart';

class ListingPage11Std extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  ListingPage11Std({this.loginResponse, this.cartData});

  @override
  _ListingPage11Std createState() =>
      _ListingPage11Std(loginResponse: loginResponse, cartData: cartData);
}

class _ListingPage11Std extends State<ListingPage11Std>
    with SingleTickerProviderStateMixin {
  final LoginResponse loginResponse;
  final CartData cartData;

  _ListingPage11Std({this.loginResponse, this.cartData});

  var productController;
  TabController _tabController;
  Future futureForScienceComboProducts;
  Future futureForScienceDigestProducts;
  Future futureForScienceTextbooksProducts;
  Future futureForScienceHelpingHandsProducts;
  Future futureForCommerceComboProducts;
  Future futureForCommerceDigestProducts;
  Future futureForCommerceTextbooksProducts;
  Future futureForCommerceHelpingHandsProducts;
  Future futureForArtsComboProducts;
  Future futureForArtsDigestProducts;
  Future futureForArtsTextbooksProducts;
  Future futureForArtsHelpingHandsProducts;
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
    futureForScienceComboProducts = productController
        .getProductBySubCategory(new ProductData(catId: "3", subCatId: "8"));
    futureForScienceDigestProducts = productController
        .getProductBySubCategory(new ProductData(catId: "3", subCatId: "2"));
    futureForScienceTextbooksProducts = productController
        .getProductBySubCategory(new ProductData(catId: "3", subCatId: "1"));
    futureForScienceHelpingHandsProducts = productController
        .getProductBySubCategory(new ProductData(catId: "3", subCatId: "4"));
    futureForCommerceComboProducts = productController
        .getProductBySubCategory(new ProductData(catId: "3", subCatId: "8"));
    futureForCommerceDigestProducts = productController
        .getProductBySubCategory(new ProductData(catId: "3", subCatId: "2"));
    futureForCommerceTextbooksProducts = productController
        .getProductBySubCategory(new ProductData(catId: "3", subCatId: "1"));
    futureForCommerceHelpingHandsProducts = productController
        .getProductBySubCategory(new ProductData(catId: "3", subCatId: "4"));
    futureForArtsComboProducts = productController
        .getProductBySubCategory(new ProductData(catId: "3", subCatId: "8"));
    futureForArtsDigestProducts = productController
        .getProductBySubCategory(new ProductData(catId: "3", subCatId: "2"));
    futureForArtsTextbooksProducts = productController
        .getProductBySubCategory(new ProductData(catId: "3", subCatId: "1"));
    futureForArtsHelpingHandsProducts = productController
        .getProductBySubCategory(new ProductData(catId: "3", subCatId: "4"));
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  showViewNavigator(title, catId, subcatId) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ShowView(
            title: title,
            loginResponse: loginResponse,
            cartData: cartData,
            catId: catId,
            subcatId: subcatId)));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  'lib/assets/icons/11th Standard.png',
                  fit: BoxFit.fill,
                ),
              ),
              TabBar(
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
                  Tab(text: 'Science'),
                  Tab(text: 'Commerce'),
                  Tab(text: 'Arts'),
                ],
                controller: _tabController,
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView(
                      children: [
                        FutureBuilder(
                            future: futureForScienceComboProducts,
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
                                                  showViewNavigator("Combos", "3","13");
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
                            future: futureForScienceTextbooksProducts,
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
                                                  showViewNavigator("TextBooks", "3","1");
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
                            future: futureForScienceDigestProducts,
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
                                                  showViewNavigator("Digests", "3","2");
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
                            future: futureForScienceHelpingHandsProducts,
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
                                                  showViewNavigator("Helping Hands", "3","4");
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
                            future: futureForCommerceComboProducts,
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
                                                  showViewNavigator("Combos", "3","13");
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
                            future: futureForCommerceTextbooksProducts,
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
                                                  showViewNavigator("TextBooks", "3","1");
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
                            future: futureForCommerceDigestProducts,
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
                                                  showViewNavigator("Digests", "3","2");
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
                            future: futureForCommerceHelpingHandsProducts,
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
                                                  null;
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
                            future: futureForArtsComboProducts,
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
                                                  showViewNavigator("Combos", "3","13");
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
                            future: futureForArtsTextbooksProducts,
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
                                                  showViewNavigator("TextBooks", "3","1");
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
                            future: futureForArtsDigestProducts,
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
                                                  showViewNavigator("Digests", "3","2");
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
                            future: futureForArtsHelpingHandsProducts,
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
                                                  showViewNavigator("Helping Hands", "3","4");
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