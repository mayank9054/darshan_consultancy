import 'package:flutter/material.dart';


class Gst extends StatefulWidget {
  const Gst({ Key? key }) : super(key: key);

  @override
  _GstState createState() => _GstState();
}

class _GstState extends State<Gst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: Text("Financial Year"),),
      body: Center(
        child: Text("hi"),
      ),
    );
  }
}