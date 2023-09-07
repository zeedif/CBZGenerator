import 'package:cbz_generator/app/constants.dart';
import 'package:cbz_generator/app/domain/enums/compression_option.dart';
import 'package:cbz_generator/app/domain/enums/input_type.dart';
import 'package:cbz_generator/app/domain/enums/output_type.dart';
import 'package:cbz_generator/app/presentation/pages/home/controller/home_controller.dart';
import 'package:cbz_generator/app/presentation/widgets/dropdown_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

Consumer OutputTypeWidget(HomeController controller) {
  return Consumer(
    builder: (_, ref, __) {
      final inputType = ref.watch(homeProvider).state.inputType;
      final contentType = ref
          .watch(homeProvider.select((p) => p.contentType))
          .state
          .contentType;
      final compressionOption = ref
          .watch(homeProvider.select((p) => p.compressionOption))
          .state
          .compressionOption;
      String customExtension = '';

      if ((inputType == InputType.chapter && compressionOption != null) ||
          (inputType != null &&
              contentType != null &&
              (contentType != CompressionOption.none ||
                  compressionOption != null))) {
        customExtension = {
              CompressionOption.sevenZ: 'CB7',
              CompressionOption.ace: 'CBA',
              CompressionOption.rar: 'CBR',
              CompressionOption.tar: 'CBT',
              CompressionOption.zip: 'CBZ',
            }[contentType ?? compressionOption] ??
            '';
        return Column(
          children: [
            DropdownSelector(
              value: controller.state.outputType,
              onChanged: controller.onOutputTypeChanged,
              items: [
                DropdownMenuItem(
                  value: OutputType.same,
                  child: contentType != CompressionOption.none &&
                          contentType != null
                      ? const Text('Same as input')
                      : const Text('Same as compression'),
                ),
                // if (customExtension.isNotEmpty)
                DropdownMenuItem(
                  value: OutputType.custom,
                  child: Text(customExtension),
                ),
                const DropdownMenuItem(
                  value: OutputType.mobi,
                  child: Text('MOBI'),
                ),
              ],
            ),
            const SizedBox(height: kDefaultPadding),
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    },
  );
}
