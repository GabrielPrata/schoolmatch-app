import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class UserMatchCard extends StatefulWidget {
  final String imageBase64; // pode vir com ou sem "data:image/...;base64,"
  final String userName;

  const UserMatchCard({
    super.key,
    required this.imageBase64,
    required this.userName,
  });

  @override
  State<UserMatchCard> createState() => _UserMatchCardState();
}

class _UserMatchCardState extends State<UserMatchCard> {
  Uint8List? _bytes;

  @override
  void initState() {
    super.initState();
    _bytes = _safeDecode(widget.imageBase64);
  }

  Uint8List? _safeDecode(String raw) {
    try {
      // remove prefixo data-uri se existir
      final b64 = raw.split(',').last.trim();
      return base64Decode(b64);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = _bytes != null
        ? MemoryImage(_bytes!)
        : const AssetImage('assets/placeholder_user.png') as ImageProvider;

    return Container(
      width: 150,
      height: 230,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          // degradê preto -> transparente na base
          Positioned(
            bottom: 0, left: 0, right: 0, height: 80,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                ),
              ),
            ),
          ),
          // nome do usuário
          Positioned(
            bottom: 10, left: 12, right: 12,
            child: Text(
              widget.userName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
