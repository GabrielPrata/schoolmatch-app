import 'package:flutter/material.dart';
import 'package:school_match/ui/widgets/forms/unique_filter_chip.dart';

class UserMoreInfosTopics extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<Map<String, dynamic>> data;
  final TextEditingController controller;

  const UserMoreInfosTopics({
    super.key,
    required this.title, // Passa os dados como um parâmetro
    required this.icon,
    required this.data,
    required this.controller,
  });

  @override
  State<UserMoreInfosTopics> createState() => _UserMoreInfosTopicsState();
}

class _UserMoreInfosTopicsState extends State<UserMoreInfosTopics> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                widget.icon,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        SizedBox(
          child: UniqueFilterChip(
            data: widget.data,
            controller: widget.controller,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Divider(),
      ],
    );
  }
}
