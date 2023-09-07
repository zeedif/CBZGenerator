import 'dart:io';

import 'package:cbz_generator/app/constants.dart';
import 'package:cbz_generator/app/domain/enums/compression_option.dart';
import 'package:cbz_generator/app/domain/enums/input_type.dart';
import 'package:cbz_generator/app/domain/enums/output_type.dart';
import 'package:cbz_generator/app/presentation/controllers/snackbar_controller.dart';
import 'package:cbz_generator/app/presentation/pages/home/controller/home_state.dart';
import 'package:cbz_generator/app/presentation/widgets/input_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController() : super(HomeState.initialState);

  final snackBarController = snackbarProvider.read;
  TextEditingController inputDirController = TextEditingController();
  TextEditingController outputDirController = TextEditingController();
  TextEditingController compressorPathController = TextEditingController();
  TextEditingController pythonScriptPathController = TextEditingController();
  bool get canGenerate => ((state.inputType == InputType.chapter &&
          state.compressionOption != null) ||
      (state.inputType != null &&
              state.contentType != null &&
              (state.contentType != CompressionOption.none ||
                  state.compressionOption != null)) &&
          state.inputDir.isNotEmpty &&
          state.outputDir.isNotEmpty);

  Future<void> loadSavedPaths() async {
    final prefs = await SharedPreferences.getInstance();
    final compressorPath = prefs.getString('compressorPath');
    final pythonScriptPath = prefs.getString('pythonScriptPath');

    if (compressorPath != null) {
      state = state.copyWith(compressorPath: compressorPath);
      compressorPathController.text = compressorPath;
    }

    if (pythonScriptPath != null) {
      state = state.copyWith(pythonScriptPath: pythonScriptPath);
      pythonScriptPathController.text = pythonScriptPath;
    }
  }

  void savePaths() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('compressorPath', compressorPathController.text);
    prefs.setString('pythonScriptPath', pythonScriptPathController.text);
    state = state.copyWith(
      compressorPath: compressorPathController.text,
      pythonScriptPath: pythonScriptPathController.text,
    );
  }

  bool validatePaths() {
    return Directory(state.compressorPath).existsSync() &&
        Directory(state.pythonScriptPath).existsSync();
  }

  void onInputDirChanged(String inputDir) {
    state = state.copyWith(inputDir: inputDir);
    inputDirController.text = inputDir;
  }

  void onOutputDirChanged(String outputDir) {
    state = state.copyWith(outputDir: outputDir);
    outputDirController.text = outputDir;
  }

  void onInputTypeChanged(InputType? type) {
    state = state.copyWith(
        inputType: type,
        // outputType: null,
        contentType: null,
        compressionOption: null);
  }

  void onContentTypeChanged(CompressionOption? option) {
    state = state.copyWith(contentType: option, compressionOption: null);
  }

  void onCompressionOptionChanged(CompressionOption? option) {
    state = state.copyWith(compressionOption: option);
  }

  void onOutputTypeChanged(OutputType? option) {
    state = state.copyWith(outputType: option);
  }

  void onDeleteInputFilesChanged(bool delete) {
    state = state.copyWith(deleteInputFiles: delete);
  }

  Future<void> pickInputDir() async {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      onInputDirChanged(result);
    } else {
      snackBarController.showSnackbar(
        const SnackBar(
          content: Text('No directory selected'),
        ),
      );
    }
  }

  Future<void> pickOutputDir() async {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      onOutputDirChanged(result);
    } else {
      snackBarController.showSnackbar(
        const SnackBar(
          content: Text('No directory selected'),
        ),
      );
    }
  }

  Future<void> pickCompressorPath() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
      compressorPathController.text = result.files.single.path!;
    } else {
      snackBarController.showSnackbar(
        const SnackBar(
          content: Text('No file selected'),
        ),
      );
    }
  }

  Future<void> pickPythonScriptPath() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
      pythonScriptPathController.text = result.files.single.path!;
    } else {
      snackBarController.showSnackbar(
        const SnackBar(
          content: Text('No file selected'),
        ),
      );
    }
  }

  void showConfigDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Configuración'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputText(
                  label: "Ruta del compresor",
                  controller: compressorPathController,
                  iconSuffix: CupertinoButton(
                    padding: const EdgeInsets.all(12),
                    onPressed: pickCompressorPath,
                    child: Icon(
                      Icons.folder_open,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                InputText(
                  label: "Ruta del script de python",
                  controller: pythonScriptPathController,
                  iconSuffix: CupertinoButton(
                    padding: const EdgeInsets.all(12),
                    onPressed: pickPythonScriptPath,
                    child: Icon(
                      Icons.folder_open,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                savePaths();
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                compressorPathController.text = state.compressorPath;
                pythonScriptPathController.text = state.pythonScriptPath;
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> generate(BuildContext context) async {
    if (validatePaths()) {
      // return Process.run(
      //   'python',
      //   [
      //     state.pythonScript,
      //     state.inputDir,
      //     state.outputDir,
      //     state.compressorPath,
      //     state.compressionOption.toString().split('.').last,
      //     state.deleteInputFiles.toString(),
      //   ],
      // ).then((value) {
      //   snackBarController.showSnackbar(
      //     SnackBar(
      //       content: Text(value.stdout.toString()),
      //     ),
      //   );
      // });
    } else {
      showConfigDialog(context);
      snackBarController.showSnackbar(
        const SnackBar(
          content: Text(
              'Por favor, verifique las rutas y asegúrese de que existan y sean válidas.'),
        ),
      );
    }
  }
}

final homeProvider = StateProvider((_) => HomeController());
