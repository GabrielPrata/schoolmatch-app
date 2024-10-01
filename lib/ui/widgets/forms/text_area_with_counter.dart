import 'package:flutter/material.dart';

class TextAreaWithCounter extends StatefulWidget {
  final TextEditingController controller;
  final int maxChars;


  const TextAreaWithCounter({super.key, required this.controller, required this.maxChars});

  @override
  _TextAreaWithCounterState createState() => _TextAreaWithCounterState();
}

class _TextAreaWithCounterState extends State<TextAreaWithCounter> {
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _charCount =
            widget.controller.text.length; // Atualiza o contador de caracteres
      });
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
            child: Text(
              'Sua Bio...',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          TextField(
            style: Theme.of(context).textTheme.bodySmall,
            controller: widget.controller,
            maxLength: widget.maxChars, // Limita o número de caracteres
            maxLines: 12, // Permite que o TextField seja uma área de texto
            cursorColor: Theme.of(context).colorScheme.surface,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10), // Define as bordas arredondadas
                borderSide: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary, // Define a cor da borda
                  width: 2, // Largura da borda
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10), // Define as bordas arredondadas
                borderSide: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary, // Define a cor da borda
                  width: 2, // Largura da borda
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary, // Cor da borda ao focar
                  width: 2, // Largura da borda ao focar
                ),
              ),
              counterStyle: TextStyle(
                // Estilo do contador de caracteres
                color: Theme.of(context)
                    .colorScheme
                    .onPrimary, // Cor personalizada do contador
                fontSize: 16, // Tamanho da fonte do contador
                fontWeight: FontWeight.bold, // Peso da fonte (negrito)
              ),
            ),
          ),
          // SizedBox(height: 8), // Espaço entre o TextField e o contador
          // Text(
          //   '$_charCount/$widget.maxChars caracteres',
          //   style: TextStyle(
          //     color: _charCount > widget.maxChars ? Colors.red : Colors.grey,
          //   ),
          // ),
        ],
      ),
    );
  }
}
