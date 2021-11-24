import 'package:darshan_consultancy/page/uploadanddownloaddata.dart';
import 'package:flutter/material.dart';

class IncomeTex extends StatefulWidget {
  const IncomeTex({Key? key}) : super(key: key);

  @override
  _IncomeTexState createState() => _IncomeTexState();
}

class _IncomeTexState extends State<IncomeTex> {
  int sizeoflist = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Financial Year",
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Column(
            children: List.generate(
              sizeoflist,
              (index) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    onTap : (){
                       Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UploadAndDownloadFile(),
                ));
                    },
                    leading: Icon(
                      Icons.date_range_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                    title: Text(
                      '2021 - 22',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    // subtitle: Text('Icream is good for health'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}
