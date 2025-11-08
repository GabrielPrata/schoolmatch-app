import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/domain/services/match_service.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/show_user_details_bottomsheet.dart';
import 'package:school_match/util/alerts.dart';

class UserMatchCard extends StatefulWidget {
  final UserProfileModel user;
  final VoidCallback onMatchDeleted;

  const UserMatchCard({
    super.key,
    required this.user,
    required this.onMatchDeleted,
  });

  @override
  State<UserMatchCard> createState() => _UserMatchCardState();
}

class _UserMatchCardState extends State<UserMatchCard> {
  Uint8List? _bytes;
  bool _isZoomedOut = false;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _bytes = _safeDecode(widget.user.images.first ?? '');
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

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Desfazer Match'),
          content: const Text('Tem certeza que deseja desfazer este match?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: Theme.of(context).textTheme.labelMedium,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar', style: Theme.of(context).textTheme.labelMedium),
              onPressed: () async {
                final loggedInUserId = box.read('userId');
                final otherUserId = widget.user.userId;
                if (loggedInUserId != null && otherUserId != null) {
                  final response = await MatchService.deleteMatch(
                      loggedInUserId, otherUserId);
                  if (response.statusCode == 200) {
                    Alerts.showSuccessSnackBar(
                        'Match desfeito com sucesso!', context);
                    widget.onMatchDeleted();
                  } else {
                    Alerts.showErrorSnackBar(
                        'Erro ao desfazer o match.', context);
                  }
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = _bytes != null
        ? MemoryImage(_bytes!)
        : const AssetImage('assets/placeholder_user.png') as ImageProvider;

    final displayName = [
      widget.user.firstName?.trim() ?? '',
      widget.user.lastName?.trim() ?? '',
    ].where((x) => x.isNotEmpty).join(' ').trim();

    return GestureDetector(
      onTap: () async {
        setState(() {
          _isZoomedOut = true;
        });
        await Future.delayed(const Duration(milliseconds: 200)); // Duração da animação
        setState(() {
          _isZoomedOut = false;
        });
        showModalBottomSheet(
          backgroundColor: Theme.of(context).colorScheme.primary,
          isScrollControlled: true,
          context: context,
          enableDrag: true,
          showDragHandle: true,
          builder: (BuildContext context) {
            return ShowUserDetailsBottomsheet(
                candidate: widget.user,
                isFromMatch: true,
              );
          },
        );
      },
      child: AnimatedScale(
        scale: _isZoomedOut ? 0.95 : 1.0, // Ajuste o valor para o zoom desejado
        duration: const Duration(milliseconds: 100),
        child: Container(
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
              bottom: 0,
              left: 0,
              right: 0,
              height: 80,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16)),
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
              bottom: 10,
              left: 12,
              right: 12,
              child: Text(
                displayName.isEmpty ? 'Usuário' : displayName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  _showDeleteConfirmationDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
