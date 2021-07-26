import 'package:capela_sagrada_familia/Telas/contador.dart';
import 'package:capela_sagrada_familia/Telas/folheto.dart';
import 'package:capela_sagrada_familia/Telas/inicio.dart';
import 'package:capela_sagrada_familia/Telas/intencoes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      Inicio(),
      Contador(),
      Intencoes(),
    ];

    return Scaffold(
      
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
          items: [
            BottomNavigationBarItem(
              title: Text("Início"),
              icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
                title: Text("Contador"),
                icon: Icon(Icons.add_outlined)
            ),
             BottomNavigationBarItem(
              title: Text("Folheto"),
              icon: Icon(Icons.auto_stories_outlined),
            ),
          ]
      ),
    );
  }
}
