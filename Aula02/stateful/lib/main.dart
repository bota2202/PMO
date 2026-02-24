import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: PaginaContador()));
}

class PaginaContador extends StatefulWidget {
  @override
  _PaginaContadorState createState() => _PaginaContadorState();
}

class _PaginaContadorState extends State<PaginaContador> {
  int contador = 0;

  void Increment() {
    setState(() {
      contador++;
    });
  }

  void Decrement() {
    setState(() {
      contador--;
    });
  }
  void Reset() {
    setState(() {
      contador=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meu app stateful", style: TextStyle(fontSize: 50),)),
      body: Center(
        child: Text("Cliques: $contador", style: TextStyle(fontSize: 30)),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: Decrement, child: Icon(Icons.remove), backgroundColor: Colors.red,),
          SizedBox(height: 10,),
          FloatingActionButton(onPressed: Reset, child: Icon(Icons.exposure_zero), backgroundColor:Color.fromARGB(255, 255, 255, 255),),
          SizedBox(height: 10,),
          FloatingActionButton(onPressed: Increment, child: Icon(Icons.add), backgroundColor: Colors.green,),
        ],
      ),
    );
  }
}
