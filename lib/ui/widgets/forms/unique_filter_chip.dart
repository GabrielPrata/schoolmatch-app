import 'package:flutter/material.dart';

class UniqueFilterChip extends StatefulWidget {
  final TextEditingController controller;
  final List<Map<String, dynamic>> data;

  const UniqueFilterChip({
    super.key,
    required this.controller,
    required this.data,
  });

  @override
  State<UniqueFilterChip> createState() => _UniqueFilterChipState();
}

class _UniqueFilterChipState extends State<UniqueFilterChip> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            spacing: 5.0,
            runSpacing: 2.0,
            children: widget.data.map((block) {
              return FilterChip(
                label: Text(
                  block['name'],
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                selected: block['selected'],
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      // Desmarca todos os blocos
                      for (var otherBlock in widget.data) {
                        otherBlock['selected'] = false;
                      }
                      // Marca o bloco selecionado
                      block['selected'] = true;
                      widget.controller.text = block['name'];
                    } else {
                      block['selected'] = false;
                      widget.controller.text = "";
                    }
                  });
                },
                selectedColor: Theme.of(context).colorScheme.secondary,
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                showCheckmark: false,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
