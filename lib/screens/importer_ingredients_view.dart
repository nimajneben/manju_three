import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

//Importer Ingredients Main Screen Widget
class ImporterIngredientsView extends StatelessWidget {
  const ImporterIngredientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Ingredients')),
      body: const ImporterIngredientsList(),
    );
  }
}

// Importer Ingredients Stateful Helper
// Return the Ingredients List
class ImporterIngredientsList extends StatefulWidget {
  const ImporterIngredientsList({super.key});

  @override
  State<ImporterIngredientsList> createState() => _ImporterIngredientsList();
}

// Ingredients List Builder
class _ImporterIngredientsList extends State<ImporterIngredientsList> {
  final db = FirebaseFirestore.instance;

  // Get Ingredients Collection from Firebase
  Future<List<Ingredient>> _getData() async {
    List<Ingredient> ingredientList = [];
    db.collection("Ingredients").get().then(
      (querySnapshot) {
        // DEBUG: success message
        // print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          // DEBUG: print data
          // print('${docSnapshot.id} => ${docSnapshot.data()}');
          // Extract data from query
          final String ingredientName = docSnapshot.id;
          final Map<String, dynamic> idmap = docSnapshot.data();
          // Serialization to our Ingredient Object
          ingredientList.add(
            Ingredient(
                name: ingredientName,
                amount: int.parse(idmap['amount'].toString() ?? '0'),
                restock: bool.parse(idmap['needRestock'].toString() ?? 'false',)
            )
          );
        }
      },
      // DEBUG: For error
      // onError: (e) => print("Error completing: $e"),
    );
    return ingredientList;
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Ingredient>> ingredientList = _getData();
    // return GestureDetector(
    //   onTap: () => _getData()
    // );
    return FutureBuilder(
        // FutureBuilder
        // Show spinner while contents load
        future: ingredientList,
        builder: (context,snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              // parameter may be null, assert the possibility and provide base case.
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(snapshot.data?[index].toString() ?? '')
                );
              }
            );}
          else if (snapshot.hasError) {
            throw Exception("data error");
          }
          return const CircularProgressIndicator();
      }
    );
  }

}

// In-App Ingredient Object Representation
class Ingredient {
  final String name;
  final int amount;
  final bool restock;

  Ingredient({
    required this.name,
    required this.amount,
    required this.restock,
  });

  @override
  String toString() {
    return name;
  }
}
