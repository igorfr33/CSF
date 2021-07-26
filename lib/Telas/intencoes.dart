import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Intencoes extends StatefulWidget {
  const Intencoes({ Key key }) : super(key: key);

  @override
  _IntencoesState createState() => _IntencoesState();
}

class _IntencoesState extends State<Intencoes> {
  
  _salvarIntencoes() async{

    WidgetsFlutterBinding.ensureInitialized();

    Firestore db = Firestore.instance;

    db.collection("Intencoes")
    .document("intecoes")
    .setData({
        "Intenções": "Pelo Sétimo Dia De Fulano"
    }
    );

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text("Salvar Intenção"),
              onPressed: _salvarIntencoes,
            )
          ],
        ),
      ),
    );
  }
}