import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: Jokenpo(), debugShowCheckedModeBanner: false));
}

class Jokenpo extends StatefulWidget {
  @override
  _JokenpoState createState() => _JokenpoState();
}

class _JokenpoState extends State<Jokenpo> {
  String escolhaJogador = "";
  String escolhaPC = "";
  String resultado = "";

  int pontosJogador = 0;
  int pontosPC = 0;

  final List opcoes = ["pedra", "papel", "tesoura"];
  final Random random = Random();

  void jogar(String escolha) {
    escolhaJogador = escolha;
    escolhaPC = opcoes[random.nextInt(3)];

    setState(() {
      if (escolhaJogador == escolhaPC) {
        resultado = "Empate!";
      } else if ((escolhaJogador == "pedra" && escolhaPC == "tesoura") ||
          (escolhaJogador == "papel" && escolhaPC == "pedra") ||
          (escolhaJogador == "tesoura" && escolhaPC == "papel")) {
        resultado = "Você ganhou!";
        pontosJogador++;
      } else {
        resultado = "Você perdeu!";
        pontosPC++;
      }

      if (pontosJogador == 5 || pontosPC == 5) {
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            pontosJogador = 0;
            pontosPC = 0;
            resultado = "Placar resetado!";
          });
        });
      }
    });
  }

  Widget botao(String texto) {
    return ElevatedButton(
      onPressed: () => jogar(texto),
      child: Text(texto.toUpperCase()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jokenpô")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Escolha do PC: $escolhaPC", style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text("Resultado: $resultado", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                botao("pedra"),
                SizedBox(width: 10),
                botao("papel"),
                SizedBox(width: 10),
                botao("tesoura"),
              ],
            ),

            SizedBox(height: 30),

            Text(
              "Você: $pontosJogador x $pontosPC :PC",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
