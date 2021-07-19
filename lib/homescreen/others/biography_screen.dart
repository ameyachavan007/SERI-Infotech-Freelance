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
import 'package:seri_flutter_app/homescreen/data/title.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';
import '../../constants.dart';
import 'package:seri_flutter_app/homescreen/others/showView.dart';

class Biography extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Biography({this.loginResponse, this.cartData});

  @override
  _BiographyState createState() =>
      _BiographyState(loginResponse: loginResponse, cartData: cartData);
}

class _BiographyState extends State<Biography> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _BiographyState({this.loginResponse, this.cartData});

  var productController;
  Future futureForComboProducts;
  Future futureForDigestProducts;
  Future futureForTextbooksProducts;
  Future futureForHelpingHandsProducts;

  Future futureForCart;
  bool search = false;
  var cartController;

  @override
  void initState() {
    productController = Provider.of<ProductController>(context, listen: false);
    cartController = Provider.of<CartController>(context, listen: false);
    futureForComboProducts = productController
        .getProductBySubCategory(new ProductData(catId: "4", subCatId: "8"));
    futureForDigestProducts = productController
        .getProductBySubCategory(new ProductData(catId: "4", subCatId: "2"));
    futureForTextbooksProducts = productController
        .getProductBySubCategory(new ProductData(catId: "4", subCatId: "1"));
    futureForHelpingHandsProducts = productController
        .getProductBySubCategory(new ProductData(catId: "4", subCatId: "4"));
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Color.fromARGB(255, 71, 54, 111),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
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
                                          cartData.cartProducts.length
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  35),
                                        ),
                                        child: Image.asset(
                                          'lib/assets/icons/cart1.png',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
              SizedBox(
                height: 3,
              ),
              Container(
                // margin: EdgeInsets.only(top: 0.5),
                height: size.height * 0.15,
                child: Image.asset('lib/assets/images/biography.png'),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView(
                  children: [
                    FutureBuilder(
                        future: futureForTextbooksProducts,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<ProductData> proList = snapshot.data;
                            if (proList.length > 0) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: TitleHome(
                                            title:
                                                'Biography about Entertainers',
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.23,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 71, 54, 111),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              top: BorderSide(
                                                  color: Colors.black),
                                              left: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ShowView(
                                                            loginResponse:
                                                                loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                                "Biography about Entertainers",
                                                          )));
                                            },
                                            color: Color.fromARGB(
                                                255, 71, 54, 111),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              "Show all",
                                              style: TextStyle(
                                                fontFamily: 'GothamMedium',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10.0.sp,
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
                                        ProductData product = proList[index];
                                        return ProductList(
                                            product, loginResponse, cartData);
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
                    SizedBox(height: 15),
                    FutureBuilder(
                        future: futureForTextbooksProducts,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<ProductData> proList = snapshot.data;
                            if (proList.length > 0) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: TitleHome(
                                            title: 'Biography about Activists',
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.23,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 71, 54, 111),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              top: BorderSide(
                                                  color: Colors.black),
                                              left: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ShowView(
                                                            loginResponse:
                                                                loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                                "Biography about Activists",
                                                          )));
                                            },
                                            color: Color.fromARGB(
                                                255, 71, 54, 111),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              "Show all",
                                              style: TextStyle(
                                                fontFamily: 'GothamMedium',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10.0.sp,
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
                                        ProductData product = proList[index];
                                        return ProductList(
                                            product, loginResponse, cartData);
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
                    SizedBox(height: 15),
                    FutureBuilder(
                        future: futureForTextbooksProducts,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<ProductData> proList = snapshot.data;
                            if (proList.length > 0) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 4.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: TitleHome(
                                            title: 'Biography about Actors',
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.23,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 71, 54, 111),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black),
                                              top: BorderSide(
                                                  color: Colors.black),
                                              left: BorderSide(
                                                  color: Colors.black),
                                              right: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          ShowView(
                                                            loginResponse:
                                                                loginResponse,
                                                            cartData: cartData,
                                                            title:
                                                                "Biography about Actors",
                                                          )));
                                            },
                                            color: Color.fromARGB(
                                                255, 71, 54, 111),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              "Show all",
                                              style: TextStyle(
                                                fontFamily: 'GothamMedium',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10.0.sp,
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
                                        ProductData product = proList[index];
                                        return ProductList(
                                            product, loginResponse, cartData);
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
                    SizedBox(
                      height: 5,
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
