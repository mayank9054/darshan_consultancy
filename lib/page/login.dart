import 'package:darshan_consultancy/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:lottie/lottie.dart';

/// Helllo

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  var phonenumber;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: size.height * 0.05,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset('assets/images/darshan_logo.jpg'),
                )
              ),
              SizedBox(
                height: size.height * .05,
              ),
              Stack(
                children: [
                  Container(
                    // color: Colors.black12,
                    height: size.height * 0.45,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                          offset: Offset(2.0, 5.0),
                        ),
                      ],
                    ),
                    child: Card(
                      // color: Colors.black54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      margin: EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            //login with number and bottom text
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black,
                                    letterSpacing: 0.5,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Login with mobile number\n\n\n",
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        // color: Color(0xFF0278AE),
                                        color: Colors.black
                                      ),
                                    ),
                                    TextSpan(
                                      text: "We will send you an",
                                      style: TextStyle(
                                        color: Color(0xFF373A40),
                                      ),
                                    ),
                                    TextSpan(
                                      text: " One Time Password (OTP) ",
                                      style: TextStyle(
                                        color: Color(0xFF373A40),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(text: "on this mobile number"),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: size.height*.1,
                              color: Colors.black,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                            // phonenumber field
                            Container(
                              margin: EdgeInsets.only(top: size.height * 0.045),
                              child: Form(
                                key: _key,
                                child: Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Phone Number",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please Enter Number ";
                                        } else if (!RegExp(r'(^[0-9]*$)').hasMatch(value) || value.length != 10) {
                                          return "Plase Enter Valid number";
                                        }
                                      },
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Button(
                    size: size,
                    text: "Next",
                    
                    press: () {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        print(phonenumber);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (BuildContext context) => VerifyOtpScreen(
                        //           phoneNo: phonenumber,
                        //         )));
                      }
                    },
                  ),
                  SizedBox(height: 10)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
