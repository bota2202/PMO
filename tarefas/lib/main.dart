import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: PaginaTarefas()));
}

class PaginaTarefas extends StatefulWidget {
  @override
  _PaginaTarefasState createState() => _PaginaTarefasState();
}

class _PaginaTarefasState extends State<PaginaTarefas> {
  TextEditingController controller = TextEditingController();

  List<String> tarefas = [];

  void excluir(int index) {
    setState(() {
      tarefas.removeAt(index);
    });
  }

  void adicionar() {
    if (controller.text.trim().isNotEmpty) {
      setState(() {
        tarefas.add(controller.text.trim());
      });
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meu Trello',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Digite a tarefa',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => adicionar(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(tarefas[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => excluir(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: adicionar,
        child: Icon(Icons.add),
      ),
    );
  }
}