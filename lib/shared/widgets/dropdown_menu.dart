import 'package:flutter/material.dart';

const List<String> list = <String>['Diario', 'Semanal', 'Quincenal', 'Mensual'];

class DropdownMenuPays extends StatefulWidget {
  const DropdownMenuPays({super.key});

  @override
  State<DropdownMenuPays> createState() => _DropdownMenuPaysState();
}

class _DropdownMenuPaysState extends State<DropdownMenuPays> {
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
