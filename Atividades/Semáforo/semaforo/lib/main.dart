import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Semaforo(), debugShowCheckedModeBanner: false));
}

class Semaforo extends StatefulWidget {
  @override
  _SemaforoState createState() => _SemaforoState();
}

class _SemaforoState extends State<Semaforo> {
  bool green = true;
  bool red = false;
  bool yellow = false;

  bool rodando = false;

  Future<void> atualizarCor() async {
    while (rodando) {
      if (green == true) {
        await Future.delayed(Duration(seconds: 3));
        if (!rodando) break;
        setState(() {
          green = false;
          yellow = true;
        });
      } else if (yellow == true) {
        await Future.delayed(Duration(seconds: 2));
        if (!rodando) break;
        setState(() {
          yellow = false;
          red = true;
        });
      } else {
        await Future.delayed(Duration(seconds: 3));
        if (!rodando) break;
        setState(() {
          red = false;
          green = true;
        });
      }
    }
  }

  void start() {
    rodando = !rodando;
    if (rodando) {
      atualizarCor();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Semáforo")),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 220,
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  SizedBox(height: 15),

                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: green ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),

                  SizedBox(height: 25),

                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: yellow ? Colors.yellow : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),

                  SizedBox(height: 25),

                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: red ? Colors.red : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            SizedBox(height: 50),
            Text(red?"🚶‍♂️":"🛑", style: TextStyle(fontSize: 60)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: start,
              child: Text("Iniciar", style: TextStyle(fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }
}
