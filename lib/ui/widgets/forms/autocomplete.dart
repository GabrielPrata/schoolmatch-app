import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CitiesAutocomplete extends StatefulWidget {
  late TextEditingController controller;

  CitiesAutocomplete({super.key, required this.controller});

  @override
  _CitiesAutocompleteState createState() => _CitiesAutocompleteState();
}

class _CitiesAutocompleteState extends State<CitiesAutocomplete> {
  List<String> cities = [];

  @override
  void initState() {
    super.initState();
    loadCities();
  }

  Future<void> loadCities() async {
    final String response =
        await rootBundle.loadString('assets/cidades_sp_mg.json');
    final data = await json.decode(response);
    List<dynamic> states = data['estados'];
    for (var state in states) {
      List<dynamic> citiesData = state['cidades'];
      cities.addAll(citiesData.cast<String>());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return cities.where((String option) {
            return option
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selection) {
          debugPrint('Você selecionou: $selection');
          widget.controller.text = selection;
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted) {
          return SizedBox(
            child: TextField(
              controller: fieldTextEditingController,
              focusNode: fieldFocusNode,
              style: Theme.of(context).textTheme.labelMedium,
              cursorColor: Theme.of(context).colorScheme.surface,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    width: 2,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                labelText: "Sua Cidade...",
                labelStyle: Theme.of(context).textTheme.bodySmall,
                filled: true,
                fillColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          );
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              child: Container(
                width: MediaQuery.of(context).size.width -
                    95, // This will match the padding of the main body
                color: Theme.of(context)
                    .colorScheme
                    .surface,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: ListTile(
                        title: Text(option,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary)), // Text color
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
