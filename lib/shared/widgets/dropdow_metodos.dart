import 'package:flutter/material.dart';

const List<String> list = <String>['Efectivo', 'Tranferencia', 'Zelle'];

class DropdownMenuMethods extends StatefulWidget {
  const DropdownMenuMethods({super.key});

  @override
  State<DropdownMenuMethods> createState() => _DropdownMenuMethodsState();
}

class _DropdownMenuMethodsState extends State<DropdownMenuMethods> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      initialSelection: list.first,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
