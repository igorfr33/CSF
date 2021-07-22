import 'package:flutter/material.dart';

class Contador extends StatefulWidget {
  const Contador({ Key key }) : super(key: key);

  @override
  _ContadorState createState() => _ContadorState();
}

  int pessoas = 0;

class _ContadorState extends State<Contador> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              "Contador De Pessoas: "
            ),
            Text(
              pessoas.toString(),
              ),
             ElevatedButton(
               onPressed: (){
                 setState(() {
                   pessoas++;
                 });
               }
               )
          ],
        ),
      ),
    );
  }
}