import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/data/product_data.dart';
import 'package:seri_flutter_app/homescreen/data/product_list.dart';
import 'package:seri_flutter_app/homescreen/data/title.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/listing-pages/screens/8_std_page.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

final List<String> imgList = [
  'lib/assets/icons/banner.png',
  'lib/assets/icons/banner.png',
  'lib/assets/icons/banner.png',
  'lib/assets/icons/banner.png',
  'lib/assets/icons/banner.png'
];

class Body extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  Body(this.loginResponse, this.cartData);

  @override
  _BodyState createState() => _BodyState(cartData, loginResponse);
}

class _BodyState extends State<Body> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _BodyState(this.cartData, this.loginResponse);

  var productController;
  Future futureForProducts;

  @override
  void initState() {
    productController = Provider.of<ProductController>(context, listen: false);
    futureForProducts = productController
        .getProductBySubCategory(new ProductData(catId: "1", subCatId: "1"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
     // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: size.height * 0.06,
          decoration: BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
              //  alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  // vertical: kDefaultPadding * 0.8,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.5,
                ),
                height: size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
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
                    Image.asset(
                      'lib/assets/images/mic.png',
                      width: size.width * 0.06,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Stack(children: [
                Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                    vertical: kDefaultPadding,
                  ),
                  child: Container(
                      // margin: EdgeInsets.symmetric(
                      //   horizontal: kDefaultPadding,
                      //   vertical: kDefaultPadding,
                      // ),
                      height: size.height * 0.2,
                      width: size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                      ),
                      child: CarouselSlider(
                        options: CarouselOptions(),
                        items: imgList
                            .map((item) => Container(
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.fill,
                                  ),
                                ))
                            .toList(),
                      )),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width / 14,
                  bottom: MediaQuery.of(context).size.height / 20,
                  // right: 28,
                  // bottom: 28,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ListingPage1(
                                loginResponse: loginResponse,
                                cartData: cartData,
                              )));
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kPrimaryColor,
                      ),
                      child: Center(
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              FutureBuilder(
                  future: futureForProducts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ProductData> proList = snapshot.data;
                      if (proList.length > 0) {
                        return Column(
                          children: [
                            Padding(
                        padding: EdgeInsets.only(
                        right: 4.w,
                          left: 4.w,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'New Arrivals',
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
                                  ProductData product = proList[index];
                                  return ProductList(
                                      product, loginResponse, cartData);
                                },
                              ),
                            ),
                            SizedBox(height: 15),
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
                  future: futureForProducts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      int dealCount = 0;
                      List<ProductData> proList = snapshot.data;
                      for (ProductData prod in proList) {
                        if (prod.isDealoftheday == true) {
                          dealCount++;
                        }
                      }
                      if (dealCount > 0) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: 4.w,
                                left: 4.w,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Deal of the Day',
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
                                  ProductData product = proList[index];
                                  return product.isDealoftheday == true
                                      ? ProductList(
                                      product, loginResponse, cartData)
                                      : Container(height: 0.0, width: 0.0);
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  }),
              // SizedBox(height: 15),
              FutureBuilder(
                  future: futureForProducts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      int bestSell = 0;
                      List<ProductData> proList = snapshot.data;
                      for (ProductData prod in proList) {
                        if (prod.isBestSeller == true) {
                          bestSell++;
                        }
                      }
                      if (bestSell > 0) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: 4.w,
                                left: 4.w,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Best Sellers',
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
                                  ProductData product = proList[index];
                                  return product.isBestSeller == true
                                      ? ProductList(
                                      product, loginResponse, cartData)
                                      : Container(height: 0.0, width: 0.0);
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  }),
              // SizedBox(height: 15),
              FutureBuilder(
                  future: futureForProducts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ProductData> proList = snapshot.data;
                      if (proList.length > 0) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: 4.w,
                                left: 4.w,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Recently Viewed',
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
                                  ProductData product = proList[index];
                                  return product.isReturnable == true
                                      ? ProductList(
                                      product, loginResponse, cartData)
                                      : Container(height: 0.0, width: 0.0);
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  }),
             // SizedBox(height: 15),
              TitleHome(
                title: 'Shop By Brand',
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: size.height * 0.06,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: brands.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          // top: kDefaultPadding,
                          // bottom: kDefaultPadding,
                            right: kDefaultPadding,
                            left: kDefaultPadding),
                        child: Image.asset(
                          brands[index],
                          // width: size.width * 0.3,
                          fit: BoxFit.fitHeight,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 2,
                ),
                height: 2,
                color: kPrimaryColor,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding,
                ),
                child: Center(
                  child: Text(
                    '" An Investment in knowledge pays best interest "',
                    style: TextStyle(
                      fontFamily: 'GothamMedium',
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
