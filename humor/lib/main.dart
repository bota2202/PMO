import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TelaHumor(), debugShowCheckedModeBanner: false));
}

class TelaHumor extends StatefulWidget {
  @override
  _TelaHumorState createState() => _TelaHumorState();
}

class _TelaHumorState extends State<TelaHumor> {
  // Humores:
  // 0 = Feliz
  // 5 = Neutro
  // 10 = Bravo

  int humor = 0;
  bool feliz = true;
  bool neutro = false;
  bool bravo = false;

  void atualizarHumor() {
    if (humor >= 0 && humor < 4) {
      feliz = true;
      neutro = false;
      bravo = false;
    } else if (humor >= 4 && humor < 7) {
      feliz = false;
      neutro = true;
      bravo = false;
    } else {
      feliz = false;
      neutro = false;
      bravo = true;
    }
  }

  void irritar() {
    if (humor < 10) {
      humor += 1;
      atualizarHumor();
      setState(() {});
    } else {
      return;
    }
  }

  void acalmar() {
    if (humor > 0) {
      humor -= 1;
      atualizarHumor();
      setState(() {});
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela de humores")),
      body: Column(
        children: [
          SizedBox(height: 8),
          ElevatedButton(onPressed: irritar, child: Text("Irritar"),style: ElevatedButton.styleFrom(minimumSize: Size(500, 40))),
          SizedBox(height: 4,),
          ElevatedButton(onPressed: acalmar, child: Text("Acalmar"), style: ElevatedButton.styleFrom(minimumSize: Size(500, 40)),),

          Expanded(
            child: Center(
              child: Text(
                feliz
                    ? "😁"
                    : neutro
                    ? "😑"
                    : "😡",
                style: TextStyle(fontSize: 200),
              ),
            ),
          ),
        ],
      ),backgroundColor: feliz?Colors.green:neutro?Colors.yellow:Colors.red,
    );
  }
}
