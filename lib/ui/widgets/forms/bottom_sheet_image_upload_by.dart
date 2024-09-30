import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetImageUploadBy extends StatelessWidget {
  const BottomSheetImageUploadBy({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0XFF333333),  // Define a cor de fundo do BottomSheet
      builder: (BuildContext context) {
        // Calcula a altura máxima para o BottomSheet
        double maxHeight = MediaQuery.of(context).size.height * 0.2; // 20% da altura da tela

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: maxHeight, // Aplica a altura máxima ao container
              ),
              child: Column(
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_camera,
                          color: const Color(0XFFE8EAED),
                          size: 36,
                        ),
                        SizedBox(width: 10),  // Espaçamento entre o ícone e o texto
                        Text(
                          "Câmera",
                          style: GoogleFonts.montserrat(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: const Color(0XFFE8EAED),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(color: Color(0XFFE8EAED),),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(
                          Icons.image,
                          color: const Color(0XFFE8EAED),
                          size: 36,
                        ),
                        SizedBox(width: 10),  // Espaçamento entre o ícone e o texto
                        Text(
                          "Galeria",
                          style: GoogleFonts.montserrat(
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: const Color(0XFFE8EAED),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
