import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.size,
    // required this.text,
    required this.press,
  }) : super(key: key);

  final Size size;
  // final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.36),
        child: SizedBox(
          width: size.width * 0.2,
          height: 50.0,
          
          child: ElevatedButton(
            onPressed: press,
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(50.0)
              // )
            ),
            child: Card(
              // color: Color(0xCDA3C5EC),
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              child: SizedBox(
                // width: 40.0,
                // height: 40.0,
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
