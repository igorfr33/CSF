import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter/material.dart';

class Folheto extends StatefulWidget {
  const Folheto({ Key key }) : super(key: key);

  @override
  _FolhetoState createState() => _FolhetoState();
}

class _FolhetoState extends State<Folheto> {

  bool _loading;
  PDFDocument _doc;
  
  _initPDF() async {

    setState(() {
      _loading = true;
    });
    final doc = await PDFDocument.fromAsset('assets/folheto.pdf');
    _doc = doc;
    _loading = false;
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPDF();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
      ? Center(
        child: CircularProgressIndicator(),
      )
      : PDFViewer(document: _doc));
  }
}