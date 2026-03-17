import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Temperatura(), debugShowCheckedModeBanner: false));
}

class Temperatura extends StatefulWidget {
  @override
  _TemperaturaState createState() => _TemperaturaState();
}

class _TemperaturaState extends State<Temperatura> {
  bool frio = false;
  bool agradavel = true;
  bool quente = false;

  int celsius = 20;

  void desativar() {
    frio = false;
    agradavel = false;
    quente = false;
  }

  void aumentar() {
    celsius += 1;
    atualizar();
  }

  void diminuir() {
    celsius -= 1;
    atualizar();
  }

  void atualizar() {
    if (celsius > 15 && celsius < 23) {
      setState(() {
        desativar();
        agradavel = true;
      });
    } else if (celsius <= 15) {
      setState(() {
        desativar();
        frio = true;
      });
    } else {
      setState(() {
        desativar();
        quente = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Temperatura")),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 300),
            Text(
              frio
                  ? "🥶"
                  : quente
                  ? "🥵"
                  : "😁",
              style: TextStyle(fontSize: 120),
            ),
            SizedBox(height: 30),
            Text(
              "Está ${celsius} graus celsius",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              frio
                  ? "Está frio"
                  : quente
                  ? "Está calor"
                  : "Está agradável",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: aumentar, child: Icon(Icons.add)),
                ElevatedButton(onPressed: diminuir, child: Icon(Icons.remove)),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: frio
          ? const Color.fromARGB(255, 106, 208, 255)
          : quente
          ? Colors.amber
          : const Color.fromARGB(255, 112, 255, 186),
    );
  }
}
