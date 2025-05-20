import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownMenuData<T> extends StatefulWidget {
  final List<T> items;
  final int? selectedId;
  final void Function(int, String) onItemSelected;
  final String defaultText;
  final int Function(T) getId;
  final String Function(T) getLabel;

  const DropdownMenuData({
    super.key,
    required this.items,
    required this.onItemSelected,
    required this.defaultText,
    required this.getId,
    required this.getLabel,
    this.selectedId,
  });

  @override
  State<DropdownMenuData<T>> createState() => _DropdownMenuDataState<T>();
}

class _DropdownMenuDataState<T> extends State<DropdownMenuData<T>> {
  int? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedId;
  }

  @override
  void didUpdateWidget(covariant DropdownMenuData<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedId != oldWidget.selectedId) {
      setState(() {
        selectedValue = widget.selectedId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<int>(
        isExpanded: true,
        hint: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.defaultText,
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<int>(
                  value: widget.getId(item),
                  child: Text(
                    widget.getLabel(item),
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue;
          });

          final selectedItem = widget.items.firstWhere(
            (item) => widget.getId(item) == newValue,
          );

          widget.onItemSelected(
              widget.getId(selectedItem), widget.getLabel(selectedItem));
        },
        buttonStyleData: ButtonStyleData(
          height: 70,
          width: 160,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(Icons.arrow_forward_ios_outlined),
          iconSize: 14,
          iconEnabledColor: Theme.of(context).colorScheme.secondary,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 400,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all(6),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 14),
        ),
      ),
    );
  }
}
