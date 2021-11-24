import 'dart:io';
import 'dart:typed_data';
import 'package:darshan_consultancy/page/downloadpdf.dart';
import 'package:darshan_consultancy/page/firebase_file.dart';
import 'package:darshan_consultancy/page/image_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

class UploadAndDownloadFile extends StatefulWidget {
  const UploadAndDownloadFile({Key? key}) : super(key: key);

  @override
  _UploadAndDownloadFileState createState() => _UploadAndDownloadFileState();
}

class _UploadAndDownloadFileState extends State<UploadAndDownloadFile> {
  late Future<List<FirebaseFile>> futureFiles;
  UploadTask? task;
  int filelen = 0;
  List<File>? files = [];
  // File? file;
  List<bool> isSelected = [false, false, false];
  bool uploadpdfphoto = true;
  String pagepdfphoto = "photo";
  var photofuturefile = null;
  var pdffuturefile = null;
  DownloadPdf dwpdf = DownloadPdf();
  bool loading = false;
  String remainingitem = "";

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseApiDownload.listAll('files/$pagepdfphoto/');
    if (pagepdfphoto == "photo") photofuturefile = futureFiles;
  }


  // Get Data From Firebase Stroge 
  getdata() { // Data From Firebase
    if (pagepdfphoto == "photo") {
      if (photofuturefile != null) {
        setState(() {
          futureFiles = photofuturefile;
        });
      } else {
        futureFiles = FirebaseApiDownload.listAll('files/$pagepdfphoto/');
        photofuturefile = futureFiles;
      }
    } else {
      if (pdffuturefile != null) {
        setState(() {
          futureFiles = pdffuturefile;
        });
      } else {
        futureFiles = FirebaseApiDownload.listAll('files/$pagepdfphoto/');
        pdffuturefile = futureFiles;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: loading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitPouringHourGlassRefined(
                  color: Colors.black,
                  size: 100.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  remainingitem,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : FutureBuilder<List<FirebaseFile>>(
              future: futureFiles,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return SpinKitPouringHourGlassRefined(
                      color: Colors.black,
                      size: 100.0,
                    );
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
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

      // Floating Action Button
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: true, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Upload Document',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: ToggleButtons(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.photo,
                            size: 40,
                            color: Colors.grey[800],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.picture_as_pdf,
                            size: 40,
                            color: Colors.grey[800],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          isSelected[index] = !isSelected[index];
                          if (index == 1 || index == 0) {
                            if (index == 1) {
                              setState(() {
                                uploadpdfphoto = false;
                              });
                            } else {
                              setState(() {
                                uploadpdfphoto = true;
                              });
                            }
                            selectFile();
                          } else {
                            pickImage();
                          }
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                  );
                },
              );
            },
            child: Icon(
              Icons.upload,
              size: 30,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Colors.black,
            onPressed: () {
              if (pagepdfphoto == "photo")
                setState(() {
                  pagepdfphoto = "pdf";
                  // pdforphoto = false;
                });
              else
                setState(() {
                  pagepdfphoto = "photo";
                  // pdforphoto = true;
                });
              getdata();
            },
            child: pagepdfphoto == "photo" ? Text("pdf") : Text("photo"),
          ),
        ],
      ),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => GestureDetector(
      child: pagepdfphoto == "photo"
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
                        file.name.length < 35
                            ? file.name
                            : "${file.name.substring(0, 35)}...",
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
      onTap: pagepdfphoto == "photo"
          ? () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ImagePage(file: file),
              ))
          : () {
              dwpdf.downloadFile(file.url, file.name);
            });

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: uploadpdfphoto ? ['png', 'jpg', 'jpeg'] : ['pdf'],
    );
    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
      filelen = files!.length;
      print(filelen);
      uploadFile();
    } else {
      return;
    }
  }

  Future uploadFile() async {
    if (files == null) return;
    setState(() {
      loading = true;
    });
    for (int i = 0; i < filelen; i++) {
      setState(() {
        remainingitem =
            "Your file is uploading please wait ... \n ${filelen - i} files remaining...";
      });
      final fileName = basename(files![i].path);
      final destination = 'files/${uploadpdfphoto ? "photo" : "pdf"}/$fileName';

      print(destination);
      task = FirebaseApiUpload.uploadFile(destination, files![i]);
      print(destination);
      setState(() {});

      if (task == null) return;

      final snapshot = await task!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      print('Download-Link: $urlDownload');
    }
    setState(() {
      if (uploadpdfphoto)
        photofuturefile = null;
      else
        pdffuturefile = null;

      loading = false;
      remainingitem = "";
      getdata();
    });
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final file = File(image.path);
      // file = File(image.path);
      print("${image.path} !!!!!!! ${image.name}");
      setState(() {
        loading = true;
        remainingitem = "Your file is uploading please wait ...";
      });
      final fileName = basename(file.path);
      final destination = 'files/photo/$fileName';

      print(destination);
      task = FirebaseApiUpload.uploadFile(destination, file);
      print(destination);
      setState(() {});

      if (task == null) return;

      final snapshot = await task!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      print('Download-Link: $urlDownload');
      setState(() {
        photofuturefile = null;
        loading = false;
        remainingitem = "";
        getdata();
      });

      // file = imagetempath;

    } on PlatformException catch (e) {
      print("Failed to pick Image : $e");
    }
  }
}

class FirebaseApiUpload {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
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
