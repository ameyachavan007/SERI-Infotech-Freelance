import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seri_flutter_app/address/models/AddressData.dart';
import 'package:seri_flutter_app/cart/models/CartData.dart';
import 'package:seri_flutter_app/login&signup/models/LoginResponse.dart';

class AddressBook extends StatefulWidget {
  final LoginResponse loginResponse;
  final CartData cartData;

  AddressBook(this.loginResponse, this.cartData);

  @override
  _AddressBookState createState() => _AddressBookState(loginResponse, cartData);
}

class _AddressBookState extends State<AddressBook> {
  final LoginResponse loginResponse;
  final CartData cartData;

  bool addressLoaded = false;

  var addressList = [];

  _AddressBookState(this.loginResponse, this.cartData);

  var addressController;
  Future futureForAddress;

  // Add controller and get Address details

  String getType(String addType) {
    // DO changes from here
    if(addType == "Home") {

    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureForAddress,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<AddressData> addList = snapshot.data;
            if (addList.length > 0) {
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: addList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleAddress(
                        name: addList[index].name,
                        phoneNo: "3087280934",
                        pinCode: addList[index].addpincode,
                        city: addList[index].city,
                        district: addList[index].city,
                        flatNo: addList[index].line1,
                        area: addList[index].line2,
                        landmark: addList[index].line3,
                        type: "default");
                  });
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        });
  }
}

class SingleAddress extends StatefulWidget {
  final String name;
  final String phoneNo;
  final String pinCode;
  final String city;
  final flatNo;
  final String area;
  final String landmark;
  final type;
  final district;

  SingleAddress(
      {this.name,
      this.phoneNo,
      this.pinCode,
      this.city,
      this.district,
      this.area,
      this.landmark,
      this.type,
      this.flatNo});

  @override
  _SingleAddressState createState() => _SingleAddressState();
}

class _SingleAddressState extends State<SingleAddress> {
  final LoginResponse loginResponse;

  _SingleAddressState({this.loginResponse});

  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      width: MediaQuery.of(context).size.width - 15,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color.fromARGB(255, 71, 54, 111)),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  SizedBox(
                    height: 8,
                    width: 8,
                    child: Transform.scale(
                      scale: 1,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            checkValue = true;
                            setState(() {
                              checkValue= false;
                            });
                          });
                        },
                        child: Checkbox(
                          activeColor: Color.fromARGB(255, 71, 54, 111),
                          value: checkValue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(widget.name,
                      style: TextStyle(
                          fontFamily: 'GothamMedium',
                          color: Color.fromARGB(255, 71, 54, 111),
                          fontSize: MediaQuery.of(context).size.width / 18))
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Align(
                  // alignment: Alignment.topRight,
                  child: PopupMenuButton(
                    itemBuilder: (BuildContext bc) => [
                      PopupMenuItem(
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 71, 54, 111)),
                          ),
                          value: "1"),
                      PopupMenuItem(
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                fontFamily: 'GothamMedium',
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 71, 54, 111)),
                          ),
                          value: "2"),
                    ],
                    onSelected: (value) {},
                    // onSelected: (route) {
                    //   Navigator.pushNamed(context, route);
                    // },
                  ),
                ),
              ),
            ]),
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.type == "default")
                    Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Default Address",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontFamily: 'GothamMedium',
                                  fontSize:
                                      MediaQuery.of(context).size.width / 26,
                                ))),
                        SizedBox(height: 6),
                      ],
                    ),
                  Row(
                    children: [
                      Text("Plot no. ",
                          //  textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'GothamMedium',
                              fontSize:
                                  MediaQuery.of(context).size.width / 27)),
                      Text(widget.flatNo + ", ",
                          //   textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'GothamMedium',
                              fontSize:
                                  MediaQuery.of(context).size.width / 27)),
                      Text(widget.area + ",",
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'GothamMedium',
                              fontSize:
                                  MediaQuery.of(context).size.width / 27)),
                    ],
                  ),
                  if (widget.landmark != null)
                    Text(widget.landmark + ", ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: Color.fromARGB(255, 71, 54, 111),
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width / 27)),
                  Row(
                    children: [
                      Text("City - ",
                          //  textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.width / 27)),
                      Text(widget.city + ", ",
                          //   textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.width / 27)),
                      Text("Dist - ",
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.width / 27)),
                      Text(widget.district + ", ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'GothamMedium',
                              fontSize:
                                  MediaQuery.of(context).size.width / 27)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("PinCode - ",
                          //  textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.width / 27)),
                      Text(widget.pinCode,
                          style: TextStyle(
                              fontFamily: 'GothamMedium',
                              color: Color.fromARGB(255, 71, 54, 111),
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.width / 27)),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(children: [
                    Text("Phone Number - ",
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: Color.fromARGB(255, 71, 54, 111),
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width / 27)),
                    Text(widget.phoneNo,
                        style: TextStyle(
                            fontFamily: 'GothamMedium',
                            color: Color.fromARGB(255, 71, 54, 111),
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width / 27)),
                  ])
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
