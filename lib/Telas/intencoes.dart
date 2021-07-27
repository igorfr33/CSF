import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Intencoes extends StatefulWidget {
  const Intencoes({ Key key }) : super(key: key);

  @override
  _IntencoesState createState() => _IntencoesState();
}

class _IntencoesState extends State<Intencoes> {
  
  TextEditingController _controller = TextEditingController();

  _salvarIntencoes(TextEditingController _controllerIntencoes) async{

    _controllerIntencoes = _controller;

    WidgetsFlutterBinding.ensureInitialized();

    Firestore db = Firestore.instance;

    db.collection("Intencoes").add(
      {
        "Intenção" : _controllerIntencoes.text,
        
      }
  );

  }

  _listarInencoes() async {

     WidgetsFlutterBinding.ensureInitialized();

    Firestore db = Firestore.instance;

    DocumentSnapshot snapshot = await db.collection("Intencoes")
      .document()
      .get();

    db.collection("Intencoes").snapshots().listen(
      ( snapshot ){

        for( DocumentSnapshot item in snapshot.documents ){
          var dados = item.data;
          print("Itenções: " + dados["Intenção"]);
        }

      }
  );

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          FloatingActionButton.extended(
          label: Text("Adcionar Intenção"),
          backgroundColor: Colors.purple,
          onPressed: (){
            showDialog(
                context: context,
              builder: (context){

                  return AlertDialog(
                    title: Text("Adicionar Intenção"),
                    content: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: "Digite sua inteção"
                      ),
                      onChanged: (text){

                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Cancelar"),
                        onPressed: () => Navigator.pop(context) ,
                      ),
                      FlatButton(
                        child: Text("Salvar"),
                        onPressed: (){
                          //salvar
                          _salvarIntencoes(_controller);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );

              }
            );

          }
      ),

        ],
      )
    );
  }
}