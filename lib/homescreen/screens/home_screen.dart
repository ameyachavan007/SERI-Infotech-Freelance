import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seri_flutter_app/cart/carts.dart';
import 'package:seri_flutter_app/cart/controller/CartController.dart';
import 'package:seri_flutter_app/cart/models/AddToCartData.dart';
import 'package:seri_flutter_app/common/components/CustomDrawer.dart';
import 'package:seri_flutter_app/common/screens/empty-cart/emptyCartPage.dart';
import 'package:seri_flutter_app/homescreen/screens/body.dart';
import 'package:seri_flutter_app/login&signup/controller/login_controller.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

import '../../cart/models/CartData.dart';
import '../../constants.dart';

class HomePage extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  const HomePage({this.loginResponse, this.cartData});

  @override
  _HomePageState createState() => _HomePageState(loginResponse, cartData);
}

class _HomePageState extends State<HomePage> {
  final LoginResponse loginResponse;
  final CartData cartData;

  _HomePageState(this.loginResponse, this.cartData);

  var loginController = LoginController();
  LoginResponse loginResponseAfterDetails;
  Future futureForCart;

  var cartController;

  getDetails() async {
    loginResponseAfterDetails = await loginController.getSavedUserDetails();
  }

  @override
  void initState() {
    cartController = Provider.of<CartController>(context, listen: false);
    futureForCart = cartController.getCartDetails(AddToCartData(
      customerId: loginResponse.id,
    ));
    if (loginResponse == null) {
      getDetails();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loginController = Provider.of<LoginController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: kDefaultPadding),
            child: FutureBuilder(
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
                          position: BadgePosition.topEnd(top: 3, end: -10),
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
          ),
        ],
        titleSpacing: 0,
        title: Image.asset(
          'lib/assets/images/Logo.png',
          height: MediaQuery.of(context).size.height * 0.08,
        ),
      ),
      drawer: CustomDrawer(
          loginResponse == null ? loginResponseAfterDetails : loginResponse,
          cartData),
      //drawer: MyDrawer(),
      body: Body(
          loginResponse == null ? loginResponseAfterDetails : loginResponse,
          cartData),
    );
  }
}
