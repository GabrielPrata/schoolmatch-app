import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class ImagesPicker extends StatefulWidget {
  final List<XFile> imageFiles;

  const ImagesPicker({
    Key? key,
    required this.imageFiles,
  });

  @override
  _ImagesPickerState createState() => _ImagesPickerState();
}

class _ImagesPickerState extends State<ImagesPicker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableGridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
        itemCount: widget.imageFiles.length,
        shrinkWrap: true,
        onReorder: ((oldIndex, newIndex) {
          XFile path = widget.imageFiles.removeAt(oldIndex);
          widget.imageFiles.insert(newIndex, path);
          setState(() {});
        }),
        itemBuilder: (context, index) {
          return Container(
            key: ValueKey(index),
            child: Image.file(File(widget.imageFiles![index].path)),
          );
        });
  }
}
