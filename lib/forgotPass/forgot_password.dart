import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';


class Forgot_Pass extends StatefulWidget {
  const Forgot_Pass({Key key}) : super(key: key);

  @override
  _Forgot_PassState createState() => _Forgot_PassState();
}

class _Forgot_PassState extends State<Forgot_Pass> {
  @override

  String password;
  String checkPass;
  bool _obscureText = false;

  Widget build(BuildContext context) {
    return Scaffold(

        body:



        Column(

        children: <Widget> [
        Container(
          margin: EdgeInsets.only(top: 10.h, left: 5.w),

        alignment: Alignment.centerLeft,
        child: Text(
        'RESET PASSWORD',

        style: TextStyle(
        color: Color.fromARGB(255, 71, 54, 111),
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
          letterSpacing: 0.5.w,
    ),
    ),
    ),

          Container(
            margin: EdgeInsets.only(top: 1.6.h, left: 5.w),

            alignment: Alignment.centerLeft,
            child: Text(
              'Create new password',

              style: TextStyle(
                color: Color.fromARGB(255, 71, 54, 111),
                fontSize: 15.sp,
                fontWeight: FontWeight.normal,

              ),
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 3.h, 0, 10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 65,
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              child: TextFormField(
                validator: (val) {
                  return RegExp(
                      "^(?=.{8,32}\$)(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).*")
                      .hasMatch(val)
                      ? null
                      : "Input Valid Password";
                },
                obscureText: !_obscureText,
                onChanged: (value) => password = value,
                cursorColor: Color.fromARGB(255, 71, 54, 111),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 71, 54, 111),
                      width: 1,
                    ),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        !_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: !_obscureText
                            ? Color.fromARGB(255, 71, 54, 111)
                            : Colors.grey[500],
                      )),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    fontFamily: 'GothamMedium',
                    fontSize: 10.0.sp,
                    color: Color.fromARGB(255, 71, 54, 111),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 65,
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              child: TextFormField(
                cursorColor: Color.fromARGB(255, 71, 54, 111),
                validator: (val){
                  return checkPass == password? null : "Password not matched";
                },
                obscureText: !_obscureText,
                onChanged: (value) => checkPass = value,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 71, 54, 111),
                      width: 1,
                    ),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        !_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: !_obscureText
                            ? Color.fromARGB(255, 71, 54, 111)
                            : Colors.grey[500],
                      )),
                  labelText: "Retype Password",
                  labelStyle: TextStyle(
                    fontFamily: 'GothamMedium',
                    fontSize: 10.0.sp,
                    color: Color.fromARGB(255, 71, 54, 111),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
            padding: EdgeInsets.only(top: 0, left: 0),
            height: MediaQuery.of(context).size.height / 24,
            width: MediaQuery.of(context).size.width / 1.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  bottom: BorderSide(color: Colors.black),
                  top: BorderSide(color: Colors.black),
                  left: BorderSide(color: Colors.black),
                  right: BorderSide(color: Colors.black),
                )),
            child: MaterialButton(
              onPressed: () {
                null;
              },
              color: Color.fromARGB(255, 71, 54, 111),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Reset Password",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),


        ]

    ),
    );
  }
}
