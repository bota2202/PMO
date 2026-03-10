import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: PaginaInterruptor()),
  );
}

class PaginaInterruptor extends StatefulWidget {
  @override
  _PaginaInterruptorState createState() => _PaginaInterruptorState();
}

class _PaginaInterruptorState extends State<PaginaInterruptor> {
  bool claro = true;
  bool escuro = false;
  bool vermelho = false;

  void desativarcores() {
    vermelho = false;
    escuro = false;
  }

  void trocarpreto() {
    setState(() {
      if (claro && !escuro) {
        claro = false;
        escuro = true;
        vermelho = false;
      } else {
        claro = true;
        escuro = false;
        vermelho = false;
      }
    });
  }

  void trocarvermelho() {
    setState(() {
      if (claro && !vermelho) {
        claro = false;
        vermelho = true;
        escuro = false;
      } else {
        claro = true;
        vermelho = false;
        escuro = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meu interruptor")),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: trocarvermelho,
            child: Icon(Icons.switch_left, color: Colors.red),
          ),
          ElevatedButton(
            onPressed: trocarpreto,
            child: Icon(Icons.switch_left),
          ),
        ],
      ),
      backgroundColor: claro
          ? Colors.white
          : escuro
          ? Colors.black
          : vermelho
          ? Colors.red
          : Colors.blue,
    );
  }
}
