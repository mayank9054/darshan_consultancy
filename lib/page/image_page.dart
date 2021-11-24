import 'package:darshan_consultancy/page/downloadimage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:darshan_consultancy/page/firebase_file.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final FirebaseFile file;
  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isImage = ['.jpeg', '.jpg', '.png'].any(file.name.contains);

    return Scaffold(
      appBar: AppBar(
        title: Text(file.name,
        style: TextStyle(
          color: Colors.black,
        ),),
        backgroundColor : Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              // await FirebaseApiDownload.downloadFile(file.ref);
              await FirebaseStorage.instance.refFromURL(file.url).delete();

              final snackBar = SnackBar(
                content: Text('Delete ${file.name}'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: isImage
          ? Center(
            child: Image.network(
                file.url,
                // height: double.infinity,
                fit: BoxFit.contain,
              ),
          )
          : Center(
              child: Text(
                'Cannot be displayed',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
    );
  }
}
