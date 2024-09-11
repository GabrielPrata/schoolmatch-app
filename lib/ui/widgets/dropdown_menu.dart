import 'package:flutter/material.dart';

class DropdownMenuData extends StatefulWidget {
  final List<Map<String, dynamic>> data; // Adiciona isso

  const DropdownMenuData({
    super.key,
    required this.data, // Passa os dados como um parâmetro
  });

  @override
  State<DropdownMenuData> createState() => _DropdownMenuDataState();
}

class _DropdownMenuDataState extends State<DropdownMenuData> {
  int? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.data.first['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        // border: Border.all(
        //   color: Theme.of(context).colorScheme.onSurface,
        //   width: 2,
        // ),
        color: Theme.of(context).colorScheme.onSurface,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: dropdownValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          elevation: 16,
          style: Theme.of(context).textTheme.labelMedium, // Estilo do texto
          onChanged: (int? newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: widget.data
              .map<DropdownMenuItem<int>>((Map<String, dynamic> course) {
            return DropdownMenuItem<int>(
              value: course['id'],
              child: Text(course['nome']),
            );
          }).toList(),
        ),
      ),
    );
  }
}
