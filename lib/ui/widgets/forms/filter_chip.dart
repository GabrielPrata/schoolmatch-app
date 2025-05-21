import 'package:flutter/material.dart';

class CustomFilterChip<T> extends StatefulWidget {
  final List<T> dataList;
  final List<T?> selectedItems;
  final bool showOptions;
  final int maxSelections;

  // Funções de extração:
  final String Function(T) labelExtractor;
  final dynamic Function(T) idExtractor;

  const CustomFilterChip({
    super.key,
    required this.dataList,
    required this.selectedItems,
    required this.labelExtractor,
    required this.idExtractor,
    this.showOptions = true,
    this.maxSelections = 3,
  });

  @override
  State<CustomFilterChip<T>> createState() => _CustomFilterChipState<T>();
}

class _CustomFilterChipState<T> extends State<CustomFilterChip<T>> {
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
            children: widget.dataList.map((item) {
              final String label = widget.labelExtractor(item);
              final bool isSelected = widget.selectedItems.contains(item);

              return FilterChip(
                label: Text(label, style: textTheme.labelMedium),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      if (widget.selectedItems.length < widget.maxSelections) {
                        widget.selectedItems.add(item);
                      }
                    } else {
                      widget.selectedItems.remove(item);
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
              'Selecionados: ${widget.selectedItems.whereType<T>().map(widget.labelExtractor).join(', ')}.',
              style: textTheme.bodySmall,
              textAlign: TextAlign.left,
            ),
        ],
      ),
    );
  }
}
