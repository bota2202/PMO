import 'package:flutter/material.dart';

void main() {
  runApp(Meuapp());
}

class Meuapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Hello world', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text('Estudar flutter'),
              trailing: Icon(Icons.delete),
            ),
            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text('Estudar Java'),
              trailing: Icon(Icons.delete),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Text('Botão clicado');
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.black),
        ),
    );
  }
}
