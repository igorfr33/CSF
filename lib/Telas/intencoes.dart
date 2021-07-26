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

    DocumentReference ref = await db.collection("Intencoes")
    .add(
      {
        "Intenções" : "Pelo Sétimo Dia de Fulano"
      }
  );
  print("item salvo: " + ref.documentID );

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