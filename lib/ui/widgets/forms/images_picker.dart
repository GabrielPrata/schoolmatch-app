import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class ImagesPicker extends StatefulWidget {
  final List<XFile> imageFiles;
  final bool allowReorderingUserImagesOnly;  // Controle para reordenar apenas imagens de usuário
  final VoidCallback newImageFunction;

  const ImagesPicker({
    Key? key,
    required this.newImageFunction,
    required this.imageFiles,
    this.allowReorderingUserImagesOnly = false,
  }) : super(key: key);

  @override
  _ImagesPickerState createState() => _ImagesPickerState();
}

class _ImagesPickerState extends State<ImagesPicker> {
  final int maxImages = 6;

  @override
  void initState() {
    super.initState();
  }

  // Função para substituir a imagem do usuário por uma imagem padrão
  void _removeUserImage(int index) {
    setState(() {
      widget.imageFiles[index] = XFile("assets/emptyPhoto.png");
      _reorderImages();  // Reordena após remover uma imagem do usuário
    });
  }

  // Função para ordenar a lista de imagens
  void _reorderImages() {
    setState(() {
      widget.imageFiles.sort((a, b) {
        // Coloca as imagens padrão ("emptyPhoto.png") no final da lista
        if (a.name == 'emptyPhoto.png' && b.name != 'emptyPhoto.png') {
          return 1;  // a vai para o final
        } else if (a.name != 'emptyPhoto.png' && b.name == 'emptyPhoto.png') {
          return -1; // b vai para o final
        } else {
          return 0;  // mantêm a ordem
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Garante que sempre tenha 6 imagens na lista
    while (widget.imageFiles.length < maxImages) {
      widget.imageFiles.add(XFile("assets/emptyPhoto.png"));
    }

    return ReorderableGridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: widget.imageFiles.length,
      shrinkWrap: true,
      onReorder: (oldIndex, newIndex) {
        // Verifica se a imagem arrastada ou a de destino é uma imagem padrão e evita reordenar
        if (widget.imageFiles[oldIndex].name == 'emptyPhoto.png' ||
            widget.imageFiles[newIndex].name == 'emptyPhoto.png') {

          //Adicionar uma mensagem informando que o usuário não pode reordernar
          return;  // Impede a reordenação se uma das imagens for uma imagem padrão
        }

        // Continua com a reordenação se for uma imagem do usuário
        XFile path = widget.imageFiles.removeAt(oldIndex);
        widget.imageFiles.insert(newIndex, path);
        setState(() {});
      },
      itemBuilder: (context, index) {
        return Stack(
          key: ValueKey(index),
          children: [
            // Se for uma imagem padrão, exibe a imagem padrão e adiciona o GestureDetector
            widget.imageFiles[index].name == 'emptyPhoto.png'
                ? GestureDetector(
                    onTap: () {
                      widget.newImageFunction();  // Chama a função para adicionar nova imagem
                    },
                    child: Image.asset("assets/emptyPhoto.png", fit: BoxFit.cover),
                  )
                : Image.file(File(widget.imageFiles[index].path),
                    fit: BoxFit.cover),
            // Exibe o botão de "X" apenas nas imagens enviadas pelo usuário
            if (widget.imageFiles[index].name != 'emptyPhoto.png')
              Positioned(
                right: 0,
                bottom: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    _removeUserImage(index); // Remove a imagem e insere uma padrão
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
