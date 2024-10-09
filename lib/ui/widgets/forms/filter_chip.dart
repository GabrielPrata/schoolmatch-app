import 'package:flutter/material.dart';

class CustomFilterChip extends StatefulWidget {
  final List<int>? listIds;
  final List<String> listNames;
  final List<Map<String, dynamic>> data;
  final bool showOptions;
  final int maxSelections; // Novo parâmetro para o número máximo de seleções

  const CustomFilterChip({
    super.key,
    this.listIds,
    required this.listNames,
    required this.data,
    this.showOptions = true,
    this.maxSelections = 3, // Valor padrão para máximo de seleções, ajuste conforme necessário
  });

  @override
  State<CustomFilterChip> createState() => _CustomFilterChipState();
}

class _CustomFilterChipState extends State<CustomFilterChip> {
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
            children: widget.data.map((block) {
              return FilterChip(
                label: Text(
                  block['name'],
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                selected: block['selected'],
                onSelected: (bool selected) {
                  setState(() {
                    // Verifica se o chip pode ser selecionado baseado no limite de seleções
                    if (selected) {
                      if ((widget.listIds?.length ?? 0) < widget.maxSelections) {
                        block['selected'] = true;
                        widget.listIds?.add(block['id']);
                        widget.listNames.add(block['name']);
                      }
                    } else {
                      block['selected'] = false;
                      widget.listIds?.remove(block['id']);
                      widget.listNames.remove(block['name']);
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
          const SizedBox(height: 20.0),
          if (widget.showOptions)
            Text(
              'Locais selecionados: ${widget.data.where((block) => block['selected']).map((e) => e['name']).join(', ')}.',
              style: textTheme.bodySmall,
              textAlign: TextAlign.left,
            ),
        ],
      ),
    );
  }
}
