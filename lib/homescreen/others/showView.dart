import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';
import 'package:seri_flutter_app/constants.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/homescreen/data/product_data.dart';
import 'package:seri_flutter_app/homescreen/data/product_list.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';

class ShowView extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;
  final String title;
  final String catId;
  final String subcatId;
  const ShowView({ this.title, this.cartData, this.loginResponse, this.catId, this.subcatId}) ;

  @override
  _ShowViewState createState() => _ShowViewState(loginResponse: loginResponse, cartData: cartData);
}

class _ShowViewState extends State<ShowView> {
  final LoginResponse loginResponse;
  final CartData cartData;
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
  //  productController = Provider.of<ProductController>(context, listen: false);
  //  cartController = Provider.of<CartController>(context, listen: false);
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

  _ShowViewState({this.loginResponse, this.cartData});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(5.w, 5.w, 2.5.w, 5.w),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'GothamMedium',
                    ),
                  ),
                  Wrap(
                    children: getProducts(context,loginResponse, cartData ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> getProducts(BuildContext context, loginResponse, cartData) {
  List<Widget> products = [];
  for (ProductData product in productList) {
    products.add(ProductList(product, loginResponse, cartData));
  }
  return products;
}
