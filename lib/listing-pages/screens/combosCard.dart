import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/homescreen/models/product_class.dart';
import 'package:sizer/sizer.dart';

Widget combosCard(BuildContext context, int index, ProductData productData) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(20),
      ),
      width: 200,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                productData.label != null
                    ? Container(
                        decoration: BoxDecoration(
                            color: productData.label == 'P'
                                ? Colors.green
                                : Colors.red),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.5, horizontal: 5),
                          child: Text(
                            productData.label,
                            style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Colors.white,
                              fontSize: 7.sp,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Spacer(),
                Container(
                  height: 3.h,
                  child: Image.asset('lib/assets/icons/wishlist.png'),
                ),
              ],
            ),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black26)),
              height: 100,
              width: 165,
              child: CachedNetworkImage(
                imageUrl: productData.img,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Text(
              productData.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'GothamMedium',
                color: Color.fromARGB(255, 71, 54, 111),
              ),
            ),
            Text.rich(
              productData.discount_per != ""
                  ? TextSpan(
                      children: [
                        TextSpan(
                            text: 'Rs. ${productData.price}  ',
                            style: TextStyle(
                              fontFamily: 'GothamMedium',
                            )),
                        TextSpan(
                          text: '${productData.mrp}',
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              decoration: TextDecoration.lineThrough),
                        ),
                        TextSpan(
                          text: '  ${productData.discount_per}%',
                          style: TextStyle(
                              fontFamily: 'GothamMedium', color: Colors.green),
                        ),
                      ],
                    )
                  : TextSpan(text: 'Rs. ${productData.price}'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'GothamMedium',
                color: Color.fromARGB(255, 71, 54, 111),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
