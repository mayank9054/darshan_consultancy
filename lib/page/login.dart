import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:darshan_consultancy/helper/phoneauth.dart';
import 'package:darshan_consultancy/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  var phonenumber;
  AuthClass authClass = AuthClass();
  String? smsCode;
  int start = 30;
  bool? wait;
  String sendandresend = "Send";

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          sendandresend = "Resend";
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: size.height * 0.03,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 2, 15, 5),
                        child: Image.asset('assets/images/darshan_logo1.jpg'),
                      ),
                      Text(
                        "DARSHAN \nCONSULTANCY\n",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 35.0),
                      )
                      // Padding(
                      //   padding: const EdgeInsets.all(1.0),
                      //   child: Image.asset('assets/images/darshan_logo.jpg'),
                      // ),
                    ],
                  )),
              SizedBox(
                height: size.height * .015,
              ),
              Stack(
                
                children: [
                
                  Center(
                    child: Container(
                      // color: Colors.black12,
                      height: size.height * 0.4,
                      width: size.width * .98,
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
                              Text("Login with mobile number",
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            // color: Color(0xFF0278AE),
                                            color: Colors.black),
                                      ),
                              //login with number and bottom text
                              // Padding(
                              //   padding: EdgeInsets.all(8.0),
                              //   child: RichText(
                              //     textAlign: TextAlign.center,
                              //     text: TextSpan(
                              //       style: TextStyle(
                              //         fontSize: 13.0,
                              //         color: Colors.black,
                              //         letterSpacing: 0.5,
                              //       ),
                              //       children: <TextSpan>[
                                      
                              //         TextSpan(
                              //           text: "We will send you an",
                              //           style: TextStyle(
                              //             color: Color(0xFF373A40),
                              //           ),
                              //         ),
                              //         TextSpan(
                              //           text: " One Time Password (OTP) ",
                              //           style: TextStyle(
                              //             color: Color(0xFF373A40),
                              //             fontWeight: FontWeight.bold,
                              //           ),
                              //         ),
                              //         TextSpan(text: "on this mobile number"),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              Form(
                                key: _key,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(4, 15, 4, 4),
                                  child: TextFormField(
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.black),
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      focusColor: Colors.black,
                                      hintText: "Phone Number",
                                      hintStyle: TextStyle(fontSize: 18.0),
                                      suffix: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.black,
                                          ),
                                          child: Text( sendandresend,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0),
                                          ),
                                          onPressed: () {
                                            if (_key.currentState!.validate()) {
                                              _key.currentState!.save();
                                              start = 30;
                                              startTimer();
                                              print(phonenumber);
                                              authClass.verifyPhoneNumber(
                                                  phonenumber, context);

                                            }
                                          },
                                        ),
                                      ),
                                    ),

                                    keyboardType: TextInputType.number,
                                    // autovalidateMode: AutovalidateMode.always,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Number ";
                                      } else if (!RegExp(r'(^[0-9]*$)')
                                              .hasMatch(value) ||
                                          value.length != 10) {
                                        return "Plase Enter Valid number";
                                      }
                                    },
                                    onSaved: (value) => phonenumber = "+91$value",
                                  ),
                                ),
                              ),
                              OtpTextField(
                              fillColor: Colors.blue,
                              focusedBorderColor: Colors.blue,
                              numberOfFields: 6,
                              showFieldAsBox: false,
                              borderWidth: 4.0,
                              //runs when a code is typed in
                              onCodeChanged: (String code) {
                                //handle validation or checks here if necessary
                              },
                              //runs when every textfield is filled
                              onSubmit: (String verificationCode) {
                                smsCode = verificationCode;
                                print("!!!!!!$smsCode");
                              },
                            ),
                              // OTPTextField(
                              //   length: 6,
                              //   width: MediaQuery.of(context).size.width - 36,
                              //   fieldWidth: 40,
                              //   otpFieldStyle: OtpFieldStyle(
                              //     backgroundColor: Colors.transparent,
                              //     borderColor: Colors.white,
                              //   ),
                              //   style:
                              //       TextStyle(fontSize: 17, color: Colors.black),
                              //   textFieldAlignment: MainAxisAlignment.spaceAround,
                              //   fieldStyle: FieldStyle.underline,
                              //   onCompleted: (pin) {
                              //     print("Completed: " + pin);
                              //     setState(() {
                              //       smsCode = pin;
                              //     });
                              //   },
                              // ),
                              SizedBox(
                                height: 15.0,
                              ),

                              // RichText(
                              //     text: TextSpan(
                              //   children: [
                              //     TextSpan(
                              //       text: "Send OTP again in ",
                              //       style: TextStyle(
                              //           fontSize: 18, color: Colors.black),
                              //     ),
                              //     TextSpan(
                              //       text: "00:$start",
                              //       style: TextStyle(
                              //           fontSize: 18, color: Colors.red),
                              //     ),
                              //     TextSpan(
                              //       text: " sec ",
                              //       style: TextStyle(
                              //           fontSize: 18, color: Colors.black),
                              //     ),
                              //   ],
                              // )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Button(
                      size: size,
                      // text: "Next",
                      press: () {
                        if (smsCode!.isNotEmpty) {
                          authClass.signInwithPhoneNumber(smsCode!, context);
                        } else {
                          print("NONONONONONONONONONONNO");
                        }
                      }),
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
