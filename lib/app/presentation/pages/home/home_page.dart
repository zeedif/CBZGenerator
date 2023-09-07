import 'package:cbz_generator/app/constants.dart';
import 'package:cbz_generator/app/presentation/pages/home/controller/home_controller.dart';
import 'package:cbz_generator/app/presentation/pages/home/utils/compression_option_widget.dart';
import 'package:cbz_generator/app/presentation/pages/home/utils/content_type_widget.dart';
import 'package:cbz_generator/app/presentation/pages/home/utils/input_type_widget.dart';
import 'package:cbz_generator/app/presentation/pages/home/utils/output_type_widget.dart';
import 'package:cbz_generator/app/presentation/widgets/input_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: homeProvider,
      builder: (_, controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('CBZ Generator'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  controller.showConfigDialog(context);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputText(
                  label: "Input Directory",
                  controller: controller.inputDirController,
                  onChanged: controller.onInputDirChanged,
                  iconSuffix: CupertinoButton(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    onPressed: controller.pickInputDir,
                    child: Icon(
                      Icons.folder_open,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                InputText(
                  label: "Output Directory",
                  controller: controller.outputDirController,
                  onChanged: controller.onOutputDirChanged,
                  iconSuffix: CupertinoButton(
                    padding: const EdgeInsets.all(kDefaultPadding / 2),
                    onPressed: controller.pickOutputDir,
                    child: Icon(
                      Icons.folder_open,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                InputTypeWidget(controller),
                const SizedBox(height: kDefaultPadding),
                ContentTypeWidget(controller),
                CompressionOptionWidget(controller),
                OutputTypeWidget(controller),
                Consumer(
                  builder: (_, ref, __) {
                    final canGenerate = ref.watch(homeProvider).canGenerate;
                    return ElevatedButton(
                      onPressed:
                          controller.canGenerate ? () => canGenerate : null,
                      child: const Text('Generate'),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
