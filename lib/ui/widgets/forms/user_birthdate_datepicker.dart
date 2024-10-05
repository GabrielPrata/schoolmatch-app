import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UserBirthdateDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const UserBirthdateDatePicker({
    Key? key,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _UserBirthdateDatePickerState createState() =>
      _UserBirthdateDatePickerState();
}

class _UserBirthdateDatePickerState extends State<UserBirthdateDatePicker> {
  DateTime? selectedDate;
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime eighteenYearsAgo =
        DateTime(currentDate.year - 18, currentDate.month, currentDate.day);
    DateTime effectiveInitialDate = selectedDate ??
        eighteenYearsAgo; // Use selectedDate or fallback to eighteenYearsAgo

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: effectiveInitialDate,
      firstDate: widget.firstDate,
      lastDate: eighteenYearsAgo,
      helpText: 'Você nasceu em?',
      cancelText: 'Sair',
      confirmText: 'Salvar',
      errorFormatText: 'Por favor, selecione uma data válida!',
      errorInvalidText: 'Você deve ser maior de 18 anos para usar o app!',
      fieldLabelText: 'Data de Nascimento',
      fieldHintText: 'dd/mm/yyyy',
      initialDatePickerMode: DatePickerMode.year,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
              colorScheme: ColorScheme.light(
                  primary: Theme.of(context).colorScheme.secondary),
              datePickerTheme: DatePickerThemeData(
                backgroundColor: Colors.white,
                dividerColor: Theme.of(context).colorScheme.secondary,
                headerBackgroundColor: Theme.of(context).colorScheme.secondary,
                headerForegroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                // Defina os estilos de fonte para o seletor de datas aqui
                headlineLarge: Theme.of(context).textTheme.labelLarge,
                labelLarge: Theme.of(context).textTheme.labelMedium,
              )),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        widget.onDateSelected(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String displayText =
        selectedDate == null ? 'D D  /  M M  /  Y Y Y Y' : dateFormat.format(selectedDate!);

    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Text(
          displayText,
          style: GoogleFonts.ibmPlexSansDevanagari(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w400,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
