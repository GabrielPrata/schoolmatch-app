import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_match/domain/controllers/app_data_controller.dart';
import 'package:school_match/domain/controllers/home_page_controller.dart';
import 'package:school_match/domain/models/appDataModels/course_model.dart';
import 'package:school_match/domain/models/appDataModels/block_model.dart';
import 'package:school_match/ui/screens/search_results_screen.dart';
import 'package:school_match/ui/widgets/forms/dropdown_menu.dart';
import 'package:school_match/util/alerts.dart';

class TuneSettingsModal extends StatefulWidget {
  const TuneSettingsModal({super.key});

  @override
  State<TuneSettingsModal> createState() => _TuneSettingsModalState();
}

class _TuneSettingsModalState extends State<TuneSettingsModal> {
  final AppDataController appDataController = Get.put(AppDataController());
  final HomePageController homePageController = Get.put(HomePageController());
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
    appDataController.appSecondaryBlocks.clear();
    if (appDataController.appSecondaryBlocks.isEmpty) {
      await appDataController.getSecondaryBlocks(context);
    }
    if (mounted) {
      setState(() {});
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

  void _onSearchPressed() async {
    if (selectedCourse == null && selectedBlock == null) {
      Alerts.showErrorSnackBar(
          "Adicione pelo menos um filtro de busca!", context);
    } else {
      try {
        await homePageController.searchByCourseAndBlock(
          selectedCourse?.courseId ?? 0,
          selectedBlock?.blockId ?? 0,
        );
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Get.to(() =>
            SearchResultsScreen(searchResults: homePageController.profiles));
      } catch (e) {
        Navigator.of(context).pop();
        Alerts.showErrorSnackBar(
            e.toString().replaceAll("Exception: ", ""), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
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
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 5,
              )
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
            if (appDataController.appSecondaryBlocks.isEmpty)
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 5,
              )
            else
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: DropdownMenuData<BlockModel>(
                  items: appDataController.appSecondaryBlocks,
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
                onPressed: _onSearchPressed,
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
