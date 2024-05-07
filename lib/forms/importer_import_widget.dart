import 'package:flutter/material.dart';

class ImporterImportWidget extends StatefulWidget {
  const ImporterImportWidget({super.key});

  @override
  State<ImporterImportWidget> createState() => _ImporterImportWidgetState();
}

class _ImporterImportWidgetState extends State<ImporterImportWidget> {
  final _formKey = GlobalKey<FormState>();

  // Attention variables
  bool supplier_att = false;
  bool product_att = false;
  bool qty_att = false;
  bool price_att = false;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Text("Supplier"),
      TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Supplier',
        ),
      ),
      TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Product',
        ),
      ),
      TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(), labelText: 'Quantity'),
        keyboardType: TextInputType.number,
      ),
      TextField(
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: 'Price'),
        keyboardType: TextInputType.number,
      ),
    ]);
  }
}
