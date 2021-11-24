import 'dart:io';

import 'package:darshan_consultancy/page/downloadpdf.dart';
import 'package:darshan_consultancy/page/firebase_file.dart';
import 'package:darshan_consultancy/page/image_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class DownloadImage extends StatefulWidget {
  const DownloadImage({Key? key}) : super(key: key);

  @override
  _DownloadImageState createState() => _DownloadImageState();
}

class _DownloadImageState extends State<DownloadImage> {
  late Future<List<FirebaseFile>> futureFiles;
  DownloadPdf dwpdf = DownloadPdf();
  bool pdforphoto = true;
  String pdforphotostring = "photo";
  var photofuturefile;
  var pdffuturefile;
  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseApiDownload.listAll('files/$pdforphotostring/');
    if(pdforphotostring == "photo")
      photofuturefile = futureFiles;
  }

  getdata(){
    if(pdforphotostring == "photo"){
      if(photofuturefile != null){
          setState(() {
            futureFiles = photofuturefile;
          });
      }
      else{
          futureFiles = FirebaseApiDownload.listAll('files/$pdforphotostring/');
          photofuturefile = futureFiles;
      }
    }
    else{
      if(pdffuturefile != null){
        setState(() {
          futureFiles = pdffuturefile;
        });
      }else{
        futureFiles = FirebaseApiDownload.listAll('files/$pdforphotostring/');
        pdffuturefile = futureFiles;
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            "2021-22",
            style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.w900,
                fontSize: 25.0),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else if (snapshot.data!.length == 0) {
                  return Center(
                    child: Text(
                      "No Data Found",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else {
                  final files = snapshot.data!;
                  return
                      Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 15.0,
                      shrinkWrap: true,
                      childAspectRatio: .8,
                      children: List.generate(files.length,
                          (index) => buildFile(context, files[index])),
                    ),
                  );

                  // ],
                  // ),
                  // );
                }
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,

          onPressed: (){
            if(pdforphotostring == "photo")
              setState(() {
                pdforphotostring = "pdf";
                pdforphoto = false;
              });
            else
            setState(() {
              pdforphotostring = "photo";
              pdforphoto = true;
            });
            getdata();
          },
          child: pdforphotostring == "photo" ? Text("pdf")  : Text("photo"),
        ),
      );

  Widget buildFile(BuildContext context, FirebaseFile file) => GestureDetector(
        child: pdforphoto
            ? Image.network(
                file.url,
                // width: 100,
                height: 200,
                fit: BoxFit.cover,
              )
            : Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Icon(
                        Icons.file_copy_outlined,
                        size: 50,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SingleChildScrollView(
                        child: Text(
                          file.name,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                )),
        onTap: pdforphoto ? () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ImagePage(file: file),
        )) : () {
          dwpdf.downloadFile(file.url,file.name);
        }
      );
}

class FirebaseApiDownload {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();
    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);

          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static Future downloadFile(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');

    await ref.writeToFile(file);
  }
}
