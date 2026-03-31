import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: ListaCompras()));
}

class ListaCompras extends StatefulWidget {
  @override
  _ListaComprasState createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  List<String> itens = [];
  List<bool> comprado = [];
  TextEditingController controller = TextEditingController();

  void adicionarItem() {
    if (controller.text.isNotEmpty) {
      setState(() {
        itens.add(controller.text);
        comprado.add(false); 
        controller.clear();
      });
      salvarDados();
    }
  }

  void alternarComprado(int index) {
    setState(() {
      comprado[index] = !comprado[index]; 
    });
    salvarDados();
  }

  void removerItem(int index) {
    setState(() {
      itens.removeAt(index);
      comprado.removeAt(index);
    });
    salvarDados();
  }

  void limparLista() {
    setState(() {
      itens.clear();
      comprado.clear();
    });
    salvarDados();
  }

  void salvarDados() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("itens", itens);
    prefs.setStringList("comprado", comprado.map((e) => e.toString()).toList());
  }

  void carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      itens = prefs.getStringList("itens") ?? [];
      List<String> listaBool = prefs.getStringList("comprado") ?? [];
      comprado = listaBool.map((e) => e == "true").toList();
    });
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    int qtdComprados = comprado.where((e) => e).length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Compras"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: limparLista,
            tooltip: "Limpar lista",
          ),
        ],
      ),
      body: Column(
        children: [
          if (itens.isNotEmpty)
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "$qtdComprados de ${itens.length} itens comprados",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: "Adicionar item",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(onPressed: adicionarItem, child: Text("+")),
              ],
            ),
          ),
          Expanded(
            child: itens.isEmpty
                ? Center(child: Text("Lista vazia!"))
                : ListView.builder(
                    itemCount: itens.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        tileColor: comprado[index] ? Colors.green[50] : null,
                        leading: Checkbox(
                          value: comprado[index],
                          onChanged: (_) => alternarComprado(index),
                        ),
                        title: Text(
                          itens[index],
                          style: TextStyle(
                            decoration: comprado[index]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: comprado[index] ? Colors.grey : Colors.black,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => removerItem(index),
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
