
import 'package:flutter/material.dart';

class CollapsibleSection extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData icon;

  const CollapsibleSection({
    Key? key,
    required this.title,
    required this.child,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ],
    );
  }
}
