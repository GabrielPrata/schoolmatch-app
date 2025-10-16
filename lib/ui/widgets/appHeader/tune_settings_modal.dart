import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/app_data_controller.dart';
import 'package:school_match/domain/models/appDataModels/course_model.dart';
import 'package:school_match/domain/models/appDataModels/block_model.dart';
import 'package:school_match/ui/widgets/forms/dropdown_menu.dart';

class TuneSettingsModal extends StatefulWidget {
  const TuneSettingsModal({super.key});

  @override
  State<TuneSettingsModal> createState() => _TuneSettingsModalState();
}

class _TuneSettingsModalState extends State<TuneSettingsModal> {
  final AppDataController appDataController = Get.put(AppDataController());
  CourseModel? selectedCourse;
  BlockModel? selectedBlock;

  @override
  void initState() {
    super.initState();
    _loadCourses();
    _loadBlocks();
  }

  Future<void> _loadCourses() async {
    if (appDataController.appCourses.isEmpty) {
      await appDataController.getAppCourses(context);
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> _loadBlocks() async {
    if (appDataController.appMainBlocks.isEmpty) {
      await appDataController.getMainBlocks(context);
      if (mounted) {
        setState(() {});
      }
    }
  }

  void handleCourseSelection(CourseModel selectedCourseModel) {
    setState(() {
      appDataController.setUserCourse(selectedCourseModel);
      selectedCourse = selectedCourseModel;
    });
  }

  void handleBlockSelection(BlockModel selectedBlockModel) {
    setState(() {
      selectedBlock = selectedBlockModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: Column(
          children: [
            Text(
              'Busca Personalizada:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            if (appDataController.appCourses.isEmpty)
              const CircularProgressIndicator()
            else
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: DropdownMenuData<CourseModel>(
                  items: appDataController.appCourses,
                  defaultText: "Selecione o curso",
                  getId: (course) => course.courseId,
                  getLabel: (course) => course.courseName,
                  selectedId: selectedCourse?.courseId,
                  onItemSelected: handleCourseSelection,
                ),
              ),
            const SizedBox(height: 20),
            if (appDataController.appMainBlocks.isEmpty)
              const CircularProgressIndicator()
            else
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: DropdownMenuData<BlockModel>(
                  items: appDataController.appMainBlocks,
                  defaultText: "Selecione o bloco",
                  getId: (block) => block.blockId,
                  getLabel: (block) => block.blockName,
                  selectedId: selectedBlock?.blockId,
                  onItemSelected: handleBlockSelection,
                ),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () => (),
                // () => Alerts.showInfonackBar(
                //     "Funcionalidade ainda não desenvolvida!",
                //     context),
                child: Text(
                  "Buscar",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
