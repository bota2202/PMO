import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: TelaInicial()));
}

// Tela 1
class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  final String nome = 'Otávio';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela Inicial'), backgroundColor: Colors.blue),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SegundaTela(nome: nome,)),
                );
              },
              child: Text('Ir para segunda página'),
            ),
          ),
          Center(child: Text('$nome')),
        ],
      ),
    );
  }
}

class SegundaTela extends StatelessWidget {
  @override
  final String nome;

  const SegundaTela({required this.nome});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Segunda Tela')),
      body: Center(
        child: Text('Bem vindo a tela 2 ${nome}', style: TextStyle(fontSize: 80)),
      ),
    );
  }
}
