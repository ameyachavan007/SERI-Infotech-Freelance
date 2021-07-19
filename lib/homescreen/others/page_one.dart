import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/homescreen/controller/products_controller.dart';
import 'package:seri_flutter_app/homescreen/data/product_list.dart';
import 'package:seri_flutter_app/homescreen/data/title.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:seri_flutter_app/return&exchange/screens/return_and_exchange_policy.dart';
import 'package:sizer/sizer.dart';

class PageOne extends StatefulWidget {
  final ProductData myProduct;
  final LoginResponse loginResponse;
  final CartData cartData;

  PageOne(this.myProduct, this.loginResponse, this.cartData);

  @override
  _PageOneState createState() => _PageOneState(
      myProduct: myProduct, loginResponse: loginResponse, cartData: cartData);
}

class _PageOneState extends State<PageOne> {
  final ProductData myProduct;
  final LoginResponse loginResponse;
  final CartData cartData;

  _PageOneState({this.loginResponse, this.cartData, this.myProduct});

  bool _btn1 = true;
  bool _btn2 = false;
  bool wishlist = false;
  String _currentImage = "";

  var productController;
  Future futureForProducts;
  Future futureForCart;
  var cartController;
  bool search = false;

  @override
  void initState() {
    productController = Provider.of<ProductController>(context, listen: false);
    cartController = Provider.of<CartController>(context, listen: false);
    futureForProducts = productController
        .getProductBySubCategory(new ProductData(catId: "1", subCatId: "1"));
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> _image_list = [
      myProduct.img,
      myProduct.img1,
      myProduct.img2,
      myProduct.img3
    ];

    addProductToCart(AddToCartData addToCartData) async {
      bool response = await cartController.addToCart(addToCartData);
      print(response);
      if (response) {
        Flushbar(
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          message: "Added Successfully",
          icon: Icon(
            Icons.info_outline,
            size: 20,
            color: Colors.lightBlue[800],
          ),
          duration: Duration(seconds: 2),
        )..show(context);
      } else {
        Flushbar(
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          message: "Error adding to Cart",
          icon: Icon(
            Icons.info_outline,
            size: 20,
            color: Colors.lightBlue[800],
          ),
          duration: Duration(seconds: 2),
        )..show(context);
      }
    }

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
      drawer: CustomDrawer(loginResponse, cartData),
      backgroundColor: Colors.white,
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
                    myProduct.title,
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
                          // height: size.height * 0.065,
                          // width: size.width * 0.065,
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              0.1,
                          height: MediaQuery.of(context)
                              .size
                              .width *
                              0.1,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              myProduct.discount_per + "%",
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
                              child: PinchZoom(
                                image: CachedNetworkImage(
                                  imageUrl: _currentImage == ""
                                      ? myProduct.img
                                      : _currentImage,
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                zoomedBackgroundColor: Colors.black.withOpacity(0.5),
                                resetDuration: const Duration(milliseconds: 100),
                                maxScale: 2.5,
                              ),
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
                                horizontal: kDefaultPadding/2),
                            height: size.height * 0.2,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: myProduct.img,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
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
                                horizontal: kDefaultPadding/2),
                            height: size.height * 0.2,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: myProduct.img1,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
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
                                horizontal: kDefaultPadding/2),
                            height: size.height * 0.2,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: myProduct.img2,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentImage = _image_list[3];
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding/2),
                            height: size.height * 0.2,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor.withOpacity(0.5),
                              ),
                            ),
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: myProduct.img3,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                            color: kPrimaryColor,
                            fontFamily: 'GothamMedium',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(text: myProduct.price),
                            TextSpan(text: " "),
                            TextSpan(
                              text: myProduct.mrp,
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(text: " "),
                            TextSpan(
                              text: myProduct.discount_per + '%' + "Off",
                              style: TextStyle(
                                fontFamily: 'GothamMedium',
                                color: Colors.green,
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
                            fontFamily: 'GothamMedium',
                            color: kPrimaryColor,
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
                                  fontFamily: 'GothamMedium',
                                  fontSize: 15,
                                  color: kPrimaryColor),
                            ),
                            Text(
                              "Pages",
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontSize: 15,
                                  color: kPrimaryColor),
                            ),
                            Text(
                              "Back Cover",
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontSize: 15,
                                  color: kPrimaryColor),
                            ),
                            Text(
                              "Posters",
                              style: TextStyle(
                                  fontFamily: 'GothamMedium',
                                  fontSize: 15,
                                  color: kPrimaryColor),
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
                            color: kPrimaryColor,
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
                          myProduct.desp,
                          style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: kPrimaryColor,
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
                            color: kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding / 2,
                          vertical: kDefaultPadding / 2,
                        ),
                        child: myProduct.isReturnable == true
                            ? RichText(
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
                                        ..onTap = () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      ReturnAndExchangePolicy()));
                                        },
                                      style: TextStyle(
                                        fontFamily: 'GothamMedium',
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  text:
                                      'No Returns available on this Product',
                                  style: TextStyle(
                                    fontFamily: 'GothamMedium',
                                    color: kPrimaryColor,
                                    fontSize: 15,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Click Here",
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      ReturnAndExchangePolicy()));
                                        },
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
                FutureBuilder(
                    future: futureForProducts,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ProductData> proList = snapshot.data;
                        return Container(
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
                        );
                      } else {
                        return Container();
                      }
                    }),
                Divider(
                  height: kDefaultPadding,
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                ),
                TitleHome(
                  title: 'Similar Products',
                ),
                FutureBuilder(
                    future: futureForProducts,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ProductData> proList = snapshot.data;
                        return Container(
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
                        );
                      } else {
                        return Container();
                      }
                    }),
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
                  AddToCartData add = new AddToCartData(
                    customerId: loginResponse.id,
                    productId: myProduct.id,
                  );
                  addProductToCart(add);
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 2, right: 2, bottom: 2),
                padding: EdgeInsets.all(1.0),
                height: MediaQuery.of(context).size.height * 0.045,
                width: MediaQuery.of(context).size.width * 0.35,

                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 0.2.w),
                      borderRadius: BorderRadius.circular(5)),
                  textColor: Colors.white,
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                      color: Color.fromARGB(255, 71, 54, 111),
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {});
              },
              child:Container(
                padding: EdgeInsets.all(1.0),
                height: MediaQuery.of(context).size.height * 0.045,
                width: MediaQuery.of(context).size.width * 0.35,

                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {},
                  color: Color.fromARGB(255, 71, 54, 111),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Color.fromARGB(255, 71, 54, 111),
                          width: 0.2.w),
                      borderRadius: BorderRadius.circular(5)),
                  textColor: Colors.white,
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
