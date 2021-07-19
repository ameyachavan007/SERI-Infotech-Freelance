import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:seri_flutter_app/homescreen/others/page_one.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';
import 'package:sizer/sizer.dart';

import '../../constants.dart';

class ProductList extends StatefulWidget {
  final ProductData myProduct;
  final LoginResponse loginResponse;
  final CartData cartData;

  const ProductList(this.myProduct, this.loginResponse, this.cartData);

  @override
  _ProductListState createState() =>
      _ProductListState(loginResponse, cartData, myProduct);
}

class _ProductListState extends State<ProductList> {
  final ProductData myProduct;
  final LoginResponse loginResponse;
  final CartData cartData;

  _ProductListState(this.loginResponse, this.cartData, this.myProduct);

  @override
  void initState() {
    super.initState();
  }

  bool wishlist = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                PageOne(myProduct, loginResponse, cartData)));
      },
      child: Container(
        // padding: EdgeInsets.only(bottom: kDefaultPadding),
        margin: EdgeInsets.only(
          top: kDefaultPadding,
          //  bottom: kDefaultPadding,
          left: kDefaultPadding,
        ),
       //  height: size.height * 2,
        width: size.width * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: kPrimaryColor.withOpacity(0.5),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: kDefaultPadding / 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(kDefaultPadding * 0.11),
                    height: 20,
                    decoration: BoxDecoration(
                      color: myProduct.slug == 'S' ? Colors.red : Colors.green,
                    ),
                    child: Center(
                      child: Text(
                        "Trending",
                        style: TextStyle(
                          fontSize: 8.0.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        wishlist = wishlist == false ? true : false;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: kDefaultPadding / 2.7),
                      child: wishlist == true
                          ? Image.asset(
                              'lib/assets/images/wishlisted.png',
                              width: MediaQuery.of(context).size.width * 0.06,
                            )
                          : Image.asset(
                              'lib/assets/images/wishlist.png',
                              width: MediaQuery.of(context).size.width * 0.06,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(height: size.height / 155),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
                 vertical: kDefaultPadding / 3
              ),
              child: Container(
                height: size.height * 0.23,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                ),
                // child: widget.myProduct.img != null? Image.asset(widget.myProduct.img, fit: BoxFit.fill,): Container()
                child: CachedNetworkImage(
                  imageUrl: myProduct.img,
                 height: size.height * 0.23,
                 width: size.width * 0.35,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
           // SizedBox(height: size.height / 95),
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: kDefaultPadding / 2,
            //   ),
            //  child:
            Container(
              width: MediaQuery.of(context).size.width /1.5,
              padding: EdgeInsets.fromLTRB(10, 0, 2, 0),
              child: Center(
                child: Text(
                  myProduct.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: size.width * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            //   ),
            // Text(
            //   myProduct.label,
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            //   style: TextStyle(
            //     color: kPrimaryColor,
            //     fontSize: size.width * 0.03,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            RichText(
              text: TextSpan(
                text: 'Rs. ',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.03,
                ),
                children: [
                  TextSpan(text: myProduct.price + " "),
                  TextSpan(
                    text: myProduct.mrp.toString() + " ",
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  TextSpan(
                    text: " " + myProduct.discount_per.toString() + '%',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            //  ),
          ],
        ),
      ),
    );
    //: Container(height: 0.0, width: 0.0,);
  }
}
