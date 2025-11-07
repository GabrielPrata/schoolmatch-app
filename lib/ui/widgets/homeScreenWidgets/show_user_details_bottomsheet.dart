import 'package:flutter/material.dart';
import 'package:school_match/domain/models/user_profile_model.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_about.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_basic_infos.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_extra_infos.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_lifestyle.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_list_images.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_list_interests.dart';
import 'package:school_match/ui/widgets/homeScreenWidgets/user_music.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowUserDetailsBottomsheet extends StatefulWidget {
  final UserProfileModel candidate;
  final bool isFromMatch;

  const ShowUserDetailsBottomsheet(
      {Key? key, required this.candidate, this.isFromMatch = false})
      : super(key: key);

  @override
  State<ShowUserDetailsBottomsheet> createState() =>
      _ShowUserDetailsBottomsheetState();
}

class _ShowUserDetailsBottomsheetState
    extends State<ShowUserDetailsBottomsheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _normalizeBrPhone(String input) {
    // remove tudo que não é dígito
    var digits = input.replaceAll(RegExp(r'\D'), '');
    // adiciona 55 se ainda não tiver
    if (digits.isNotEmpty && !digits.startsWith('55')) {
      digits = '55$digits';
    }
    return digits;
  }

  Future<void> openWhatsApp(BuildContext context,
      {String? rawPhone, String? message}) async {
    try {
      // 1) validações contra null/vazio
      if (rawPhone == null || rawPhone.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Telefone não disponível para contato.')),
        );
        return;
      }

      // 2) normaliza o telefone e a mensagem
      final phone = _normalizeBrPhone(rawPhone);
      if (phone.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Número de telefone inválido.')),
        );
        return;
      }
      final text = (message ?? '').trim();
      final uri =
          Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(text)}');

      // 3) abre o WhatsApp
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o WhatsApp.')),
        );
      }
    } catch (e) {
      // evita exceção não tratada
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao abrir WhatsApp: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "${widget.candidate.firstName} ${widget.candidate.lastName}",
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontSize: 30),
            ),
            SizedBox(
              height: 5,
            ),
            UserListImages(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
            if (widget.isFromMatch)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Color.fromARGB(255, 21, 172, 2)),
                  ),
                  onPressed: () => openWhatsApp(
                    context,
                    rawPhone: widget.candidate.userWhatsApp,
                    message:
                        'Olá ${widget.candidate.firstName}, nos encontramos no SchoolMatch!',
                  ),
                  child: Text(
                    "WhatsApp",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
            SizedBox(
              height: 20,
            ),
            UserAbout(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
            UserBasicInfos(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
            UserExtraInfos(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
            UserListInterests(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
            UserLifestyle(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
            UserMusic(candidate: widget.candidate),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
