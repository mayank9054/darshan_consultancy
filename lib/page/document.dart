import 'package:darshan_consultancy/page/downloadimage.dart';
import 'package:darshan_consultancy/page/gst.dart';
import 'package:darshan_consultancy/page/incometax.dart';
import 'package:flutter/material.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Document",
          style: TextStyle(
              color: Colors.grey[900],
              fontWeight: FontWeight.bold,
              fontSize: 25.0),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          // SizedBox(
          //   height: 20,
          // ),
          // Text("GST "),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => IncomeTex(),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // width: MediaQuery.of(context).size.width / 2,
                height: 200,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage("assets/images/incometax_poster.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DownloadImage(),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // width: MediaQuery.of(context).size.width / 2,
                height: 200,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage("assets/images/gst_poster.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // GestureDetector(
          //   onTap: (){},
          //   child: Padding(
          //     padding: const EdgeInsets.all(20.0),
          //     child: Container(
          //       // width: MediaQuery.of(context).size.width / 2,
          //       height: 200,
          //       // color: Colors.black,
          //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0),color: Colors.grey[900]),
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Image(
          //           image: AssetImage("assets/images/gst_poster.jpg"),
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // documentuploadanddownload(context),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Visibility(
          //       visible: false,
          //       child: documentuploadanddownload(context)),
          //     documentuploadanddownload(context),
          //   ],
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          // Text("Tax File"),
          // SizedBox(
          //   height: 20,
          // ),
          // Container(
          //   margin: EdgeInsets.all(1.0),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(8.0),
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/2.jpeg'),
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     documentuploadanddownload(context),
          //     documentuploadanddownload(context),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget documentuploadanddownload(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage('assets/images/1.jpeg'),
          fit: BoxFit.contain,
        ),
      ),
    );
    // Container(
    //   width: MediaQuery.of(context).size.width / 2 - 20,
    //   height: MediaQuery.of(context).size.height / 4,
    //   color: Colors.black,
    //   child: Column(
    //     children: [],
    //   ),
    // );
  }
}
