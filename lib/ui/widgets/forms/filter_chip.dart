import 'package:flutter/material.dart';

class CustomFilterChip extends StatefulWidget {
  final List<int> secondaryBlocksIds;
  final List<String> secondaryBlocks;

  const CustomFilterChip({
    super.key,
    required this.secondaryBlocksIds, // Passa os dados como um parâmetro
    required this.secondaryBlocks,
  });

  @override
  State<CustomFilterChip> createState() => _CustomFilterChipState();
}

class _CustomFilterChipState extends State<CustomFilterChip> {
  final List<Map<String, dynamic>> blocosSecundarios = [
    {"id": 1, "name": "Bloco A (Central)", "selected": false},
    {"id": 2, "name": "Bloco B", "selected": false},
    {"id": 3, "name": "Bloco C", "selected": false},
    {"id": 4, "name": "Bloco D", "selected": false},
    {"id": 5, "name": "Bloco E", "selected": false},
    {"id": 6, "name": "Bloco F", "selected": false},
    {"id": 7, "name": "Bloco G", "selected": false},
    {"id": 8, "name": "Bloco H", "selected": false},
    {"id": 9, "name": "Bloco I", "selected": false},
    {"id": 10, "name": "Bloco J", "selected": false},
    {"id": 11, "name": "Bloco K", "selected": false},
    {"id": 12, "name": "Bosque", "selected": false},
    {"id": 13, "name": "Cantina", "selected": false},
    {"id": 14, "name": "ISO", "selected": false},
    {"id": 15, "name": "Violinha", "selected": false},
    {"id": 16, "name": "Boteko", "selected": false},
    {"id": 17, "name": "Espetinho", "selected": false},
    {"id": 18, "name": "Milho", "selected": false},
    {"id": 19, "name": "Banca TOP", "selected": false},
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            spacing: 7.0,
            runSpacing: 4.0,
            children: blocosSecundarios.map((block) {
              return FilterChip(
                label: Text(
                  block['name'],
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                selected: block['selected'],
                onSelected: (bool selected) {
                  setState(() {
                    block['selected'] = selected;
                    if (selected) {
                      widget.secondaryBlocksIds.add(block['id']);
                      widget.secondaryBlocks.add(block['name']);
                    } else {
                      widget.secondaryBlocksIds.remove(block['id']);
                      widget.secondaryBlocks.remove(block['name']);
                    }
                  });
                },
                selectedColor: Theme.of(context).colorScheme.secondary,
                // selectedColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                showCheckmark: false,
              );
            }).toList(),
          ),
          const SizedBox(height: 20.0),
          Text(
            'Locais selecionados: ${blocosSecundarios.where((block) => block['selected']).map((e) => e['name']).join(', ')}.',
            style: textTheme.bodySmall,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
