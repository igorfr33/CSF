import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Intencoes extends StatefulWidget {
  @override
  _IntencoesState createState() => _IntencoesState();
}

class _IntencoesState extends State<Intencoes> {

  File _imagem;
  String _statusUpload = "Upload não iniciado";
  String _urlImagemRecuperada = null;

  Future _recuperarImagem(bool daCamera) async {

    File imagemSelecionada;
    if( daCamera ){//camera
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
    }else{//galeria
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _imagem = imagemSelecionada;
    });

  }

  Future _uploadImagem() async {

    //Referenciar arquivo
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz
        .child("fotos")
        .child("foto1.jpg");

    //Fazer upload da imagem
    UploadTask task = arquivo.putFile(_imagem);

    //Controlar progresso do upload
    task.snapshotEvents.listen((TaskSnapshot taskSnapshot){

      if( taskSnapshot.state == TaskState.running ){
        setState(() {
          _statusUpload = "Em progresso";
        });
      }else if( taskSnapshot.state == TaskState.success ){
        _recuperarUrlImagem( taskSnapshot );
        setState(() {
          _statusUpload = "Upload realizado com sucesso!";
        });
      }

    });

    //Recuperar url da imagem
//    task.onComplete.then((StorageTaskSnapshot snapshot){
//
//      _recuperarUrlImagem( snapshot );
//
//    });

  }

  Future _recuperarUrlImagem(TaskSnapshot taskSnapshot) async {

    String url = await taskSnapshot.ref.getDownloadURL();
    print("resultado url: " + url );

    setState(() {
      _urlImagemRecuperada = url;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar imagem"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(_statusUpload),
            RaisedButton(
              child: Text("Camera"),
              onPressed: (){
                _recuperarImagem(true);
              },
            ),
            RaisedButton(
              child: Text("Galeria"),
              onPressed: (){
                _recuperarImagem(false);
              },
            ),
            _imagem == null
                ? Container()
                : Image.file(_imagem),
            _imagem == null
                ? Container()
                : RaisedButton(
              child: Text("Upload Storage"),
              onPressed: (){
                _uploadImagem();
              },
            ),
            _urlImagemRecuperada == null
                ? Container()
                : Image.network( _urlImagemRecuperada )
          ],
        ),
      ),
    );
  }
}

