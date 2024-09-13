import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownMenuData extends StatefulWidget {
  final List<Map<String, dynamic>> data; // Adiciona isso
  final void Function(int, String) onCourseSelected; 

  const DropdownMenuData({
    super.key,
    required this.data, // Passa os dados como um parâmetro
    required this.onCourseSelected,
  });

  @override
  State<DropdownMenuData> createState() => _DropdownMenuDataState();
}

class _DropdownMenuDataState extends State<DropdownMenuData> {
  int? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.data.first['id'];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<int>(
        isExpanded: true,
        hint: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                'Selecione seu curso...',
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.data
            .map((Map<String, dynamic> item) => DropdownMenuItem<int>(
                  value: item['id'], // Ensure this is an integer
                  child: Text(
                    item['nome'], // Assuming you want to display the name
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (newValue) {
          setState(() {
            selectedValue = newValue;
            final selectedCourse = widget.data.firstWhere(
              (course) => course['id'] == newValue,
            );
            if (selectedCourse != null) {
              widget.onCourseSelected(selectedCourse['id'], selectedCourse['nome']);
            }
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 70,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Theme.of(context).colorScheme.secondary,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 400,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).colorScheme.onSurface,
          ),
          // offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all(6),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
