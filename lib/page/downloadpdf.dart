import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';


class DownloadPdf{
  var progressString = "";
  String downloadURL = "";
  Future<void> downloadFile(String url,String filename) async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();

      await dio.download(url, "${dir.path}/$filename",onReceiveProgress: (rec, total) {
        print('${dir.path}');
        print("Rec: $rec , Total: $total");

        // setState(() {
          // downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        // });
      });
      downloadURL = "${dir.path}/$filename";
      print(dir.path);
    } catch (e) {
      print(e);
    }
    // setState(() {
    //   downloading = false;
    //   progressString = "Completed";
    // });
    print("DOWNLOADURL  DOWNONONWODO$downloadURL");
    print("Download completed");
    openFile(downloadURL);
  }



  Future<void> openFile(String down) async {
    // var filePath = r'/storage/emulated/0/Pan Card.pdf';
    // FilePickerResult? result = await FilePicker.platform.pickFiles();

    // if (result != null) {
    //   filePath = result.files.single.path!;
    //   print(filePath);
    // } else {
    //   // User canceled the picker
    // }
    final _result = await OpenFile.open(down);
    print(_result.message);

    // setState(() {
    //   _openResult = "type=${_result.type}  message=${_result.message}";
    // });
  }
}