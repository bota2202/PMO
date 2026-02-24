import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: PaginaRandom()));
}

class PaginaRandom extends StatefulWidget {
  @override
  _PaginaRandomState createState() => _PaginaRandomState();
}

class _PaginaRandomState extends State<PaginaRandom> {
  int numero = 0;
  Random random = Random();

  void sortear() {
    setState(() {
      numero = random.nextInt(11);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text("Sorteio de números", style: TextStyle(fontSize: 40, color: Colors.blue,fontFamily: "OpenSans"),),),
      body: Center(
        child: Text("Número: $numero", style: TextStyle(fontSize: 30),),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.black,onPressed: sortear, child: Icon(Icons.question_mark, color: Colors.white,),),
    );
  }
}
