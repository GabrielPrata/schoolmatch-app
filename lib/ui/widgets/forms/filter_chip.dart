import 'package:flutter/material.dart';

class CustomFilterChip extends StatefulWidget {
  final List<int>? listIds;
  final List<String> listNames;
  final List<Map<String, dynamic>> data;
  final bool showOptions;

  const CustomFilterChip({
    super.key,
    this.listIds, // Passa os dados como um parâmetro
    required this.listNames,
    required this.data,
    this.showOptions = true,
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
                    block['selected'] = selected;
                    if (selected) {
                      widget.listIds?.add(block['id']);
                      widget.listNames.add(block['name']);
                    } else {
                      widget.listIds?.remove(block['id']);
                      widget.listNames.remove(block['name']);
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
