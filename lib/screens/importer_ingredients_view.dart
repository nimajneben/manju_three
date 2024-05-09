import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImporterIngredientsView extends StatelessWidget {
  const ImporterIngredientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Ingredients')),
      // body: ListView.builder(
      //   padding: const EdgeInsets.all(8),
      //   itemBuilder: (_, index) =>
      //     Container(
      //       height: 50,
      //       color: Colors.amber[600],
      //       child: const Center(child: Text('test item')),
      //     )
      // )
      body: const ImporterIngredientsList(),
    );
  }
}

class ImporterIngredientsList extends StatefulWidget {
  const ImporterIngredientsList({super.key});

  @override
  State<ImporterIngredientsList> createState() => _ImporterIngredientsList();
}

class _ImporterIngredientsList extends State<ImporterIngredientsList> {
  final db = FirebaseFirestore.instance;
  late var docRef;

  void _getData() {
    docRef = db.collection("Ingredients");
    const source = Source.server;

    docRef.get(const GetOptions(source: source)).then(
          (res) => print("Successfully completed"),
      onError: (e) => print("Error completing: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _getData()
    );
  }

}
