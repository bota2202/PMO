import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: AppBanco()));
}

class AppBanco extends StatefulWidget {
  @override
  _AppBancoState createState() => _AppBancoState();
}

class _AppBancoState extends State<AppBanco> {
  TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> tarefas = [];
  late Database db;

  @override
  void initState() {
    super.initState();
    iniciarBanco();
  }

  Future<void> iniciarBanco() async {
    final caminho = await getDatabasesPath();
    final path = join(caminho, 'banco.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE tarefas(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT)",
        );
      },
    );

    carregarTarefas();
  }

  Future<void> inserirTarefa() async {
    await db.insert("tarefas", {"nome": controller.text});
    controller.clear();
    carregarTarefas();
  }

  Future<void> carregarTarefas() async {
    final lista = await db.query("tarefas");

    setState(() {
      tarefas = lista;
    });
  }

  Future<void> deletarTarefa(int id) async {
    await db.delete("tarefas", where: "id=?", whereArgs: [id]);
    carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Banco de dados')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Nova Tarefa',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                inserirTarefa();
              }
            },
            child: Text('Adicionar'),
          ),














































































































          Expanded(
            child: ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = tarefas[index];

                return ListTile(
                  title: Text(tarefa['nome']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deletarTarefa(tarefa['id']);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
