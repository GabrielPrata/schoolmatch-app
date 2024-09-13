import 'package:flutter/material.dart';
import 'package:school_match/util/constants.dart';

// ignore: must_be_immutable
class ProgressBar extends StatefulWidget {
  ProgressBar(this.currentPage);

  int currentPage;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _progress = 0;
  int totalPages = Constants.totalPagesFormNewUser;

  @override
  void initState() {
    _progress = widget.currentPage / totalPages; 
    super.initState();
  }

  // SensitivaController sensitivaController = Get.put(SensitivaController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PreferredSize(
        preferredSize: Size.fromHeight(5),
        child: LinearProgressIndicator(
          minHeight: 5.0,
          value: _progress,
          color: Theme.of(context).colorScheme.secondary,
          backgroundColor: Colors.grey[300],
        ),
      ),
    );
  }
}
