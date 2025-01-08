import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/show_user_details_bottomsheet.dart';
import 'package:school_match/util/functions.dart';

class UserListImages extends StatefulWidget {
  final UserProfileModel candidate;

  const UserListImages({Key? key, required this.candidate}) : super(key: key);

  @override
  _UserListImagesState createState() => _UserListImagesState();
}

class _UserListImagesState extends State<UserListImages> {
  late PageController _pageController;
  int currentPage = 0;

  void nextPage() {
    if (currentPage < widget.candidate.images.length - 1) {
      _pageController.animateToPage(++currentPage,
          duration: Duration(milliseconds: 100), curve: Curves.easeInQuint);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      _pageController.animateToPage(--currentPage,
          duration: Duration(milliseconds: 100), curve: Curves.easeInQuint);
    }
  }

  Widget _buildPhotoIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.candidate.images.length,
              (index) => buildDot(index: index)),
        ),
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      height: 8,
      width: 8,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.white : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height * 0.7;

    return Padding(
      padding: EdgeInsets.only(
          top: 0,
          left: MediaQuery.of(context).size.width * 0.06,
          right: MediaQuery.of(context).size.width * 0.06,
          bottom: 5),
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: BoxDecoration(
          // Define as bordas arredondadas aqui
          borderRadius:
              BorderRadius.circular(20), // Ajuste o valor conforme necessário
          color: Colors
              .white, // Cor de fundo do container, ajuste conforme necessário
        ),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: widget.candidate.images.length,
              itemBuilder: (context, index) {
                Uint8List imageBytes =
                    base64Decode(widget.candidate.images[index]!);
                return ClipRRect(
                  // Adiciona um ClipRRect para manter a imagem dentro das bordas arredondadas
                  borderRadius: BorderRadius.circular(
                      15), // Garante que a imagem também tenha bordas arredondadas
                  child: Image.memory(imageBytes, fit: BoxFit.cover),
                );
              },
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 10,
              child: GestureDetector(
                onTap: previousPage,
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width * 0.1,
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 10,
              child: GestureDetector(
                onTap: nextPage,
                child: Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width * 0.1,
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            ),
            _buildPhotoIndicator(), // Include the indicator here.
          ],
        ),
      ),
    );
  }
}
