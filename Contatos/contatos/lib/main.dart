import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ListaContatos(), debugShowCheckedModeBanner: false));
}

class ListaContatos extends StatelessWidget {
  final List<Map<String, String>> contatos = [
    {'nome': 'Otávio Saturnino', 'telefone': '(19) 99949-5895'},
    {'nome': 'Pedro Silva', 'telefone': '(11) 98888-7777'},
    {'nome': 'Maria Souza', 'telefone': '(21) 97777-6666'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];

          return ListTile(
            leading: Icon(Icons.person),
            title: Text(contato['nome']!),
            subtitle: Text(contato['telefone']!),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalhesContato(
                    nome: contato['nome']!,
                    telefone: contato['telefone']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetalhesContato extends StatelessWidget {
  final String nome;
  final String telefone;

  const DetalhesContato({required this.nome, required this.telefone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes'), backgroundColor: Colors.blueGrey),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nome:', style: TextStyle(fontSize: 20)),
            Text(nome, style: TextStyle(fontSize: 25)),
            SizedBox(height: 20),
            Text('Telefone:', style: TextStyle(fontSize: 20)),
            Text(telefone, style: TextStyle(fontSize: 25)),
            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
