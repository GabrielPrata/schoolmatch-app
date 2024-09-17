import 'package:flutter/material.dart';

class CustomFilterChip extends StatefulWidget {
  const CustomFilterChip({super.key});

  @override
  State<CustomFilterChip> createState() => _CustomFilterChipState();
}

class _CustomFilterChipState extends State<CustomFilterChip> {
  final List<Map<String, dynamic>> blocosSecundarios = [
    {"name": "walking", "selected": false},
    {"name": "running", "selected": false},
    {"name": "cycling", "selected": false},
    {"name": "hiking", "selected": false},
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            spacing: 5.0,
            children: blocosSecundarios.map((block) {
              return FilterChip(
                label: Text(block['name']),
                selected: block['selected'],
                onSelected: (bool selected) {
                  setState(() {
                    block['selected'] = selected;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Looking for: ${blocosSecundarios.where((block) => block['selected']).map((e) => e['name']).join(', ')}',
            style: textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
