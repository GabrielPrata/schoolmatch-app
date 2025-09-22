import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Box de Termos de Uso com rolagem própria.
/// - Mostra Scrollbar.
/// - Altura fixa configurável.
/// - Só permite marcar "Li e aceito" ao alcançar o fim do texto.
/// - Expõe callback onAcceptedChanged(bool) para o pai reagir.
class TermsOfUseBox extends StatefulWidget {
  final String termsText;
  final double height;
  final EdgeInsetsGeometry padding;
  final void Function(bool accepted)? onAcceptedChanged;
  final String title;

  const TermsOfUseBox({
    super.key,
    required this.termsText,
    this.height = 280,
    this.padding = const EdgeInsets.all(16),
    this.onAcceptedChanged,
    this.title = 'Termos de Uso',
  });

  @override
  State<TermsOfUseBox> createState() => _TermsOfUseBoxState();
}

class _TermsOfUseBoxState extends State<TermsOfUseBox> {
  final _scrollController = ScrollController();
  bool _reachedEnd = false;
  bool _accepted = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    final offset = _scrollController.offset;
    // Considera "fim" quando faltar <= 12px
    final reached = (max - offset) <= 12;
    if (reached != _reachedEnd) {
      setState(() => _reachedEnd = reached);
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(widget.title, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        Container(
          height: 450,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: theme.colorScheme.outlineVariant),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.06),
              ),
            ],
          ),
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            interactive: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: widget.padding,
              child: _RichTermsText(widget.termsText),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Checkbox(
              value: _accepted,
              onChanged: _reachedEnd
                  ? (v) {
                      setState(() => _accepted = v ?? false);
                      widget.onAcceptedChanged?.call(v ?? false);
                    }
                  : null,
              checkColor: Colors.white, // cor do tick
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Theme.of(context)
                      .colorScheme
                      .secondary; // cor quando selecionado
                }
                return null; // cor padrão
              }),
            ),
            Expanded(
              child: Text(
                  _reachedEnd
                      ? 'Li e aceito os Termos'
                      : 'Role até o fim para aceitar',
                  style: theme.textTheme.bodyMedium),
            ),
          ],
        ),
      ],
    );
  }
}

/// Texto rico que transforma URLs em links clicáveis de forma simples.
/// (Opcional – você pode trocar por um Text/SelectableText se preferir)
class _RichTermsText extends StatelessWidget {
  final String text;
  const _RichTermsText(this.text);

  @override
  Widget build(BuildContext context) {
    final urlRegex = RegExp(
      r'(https?:\/\/[^\s)]+)',
      caseSensitive: false,
    );

    final spans = <TextSpan>[];
    int start = 0;

    for (final match in urlRegex.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      final url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // Use url_launcher se quiser abrir o link:
              // launchUrlString(url);
            },
        ),
      );
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge,
        children: spans,
      ),
      textAlign: TextAlign.left,
    );
  }
}
