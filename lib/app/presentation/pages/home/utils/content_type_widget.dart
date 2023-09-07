import 'package:cbz_generator/app/constants.dart';
import 'package:cbz_generator/app/domain/enums/compression_option.dart';
import 'package:cbz_generator/app/domain/enums/input_type.dart';
import 'package:cbz_generator/app/presentation/pages/home/controller/home_controller.dart';
import 'package:cbz_generator/app/presentation/widgets/dropdown_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

Consumer ContentTypeWidget(HomeController controller) {
  return Consumer(
    builder: (_, ref, __) {
      final inputType = ref.watch(homeProvider).state.inputType;
      final contentType = ref.watch(homeProvider).state.contentType;
      if (inputType != InputType.chapter && inputType != null) {
        return Column(
          children: [
            DropdownSelector(
              labelText: 'Content Type',
              value: contentType,
              onChanged: (controller.onContentTypeChanged),
              items: const [
                DropdownMenuItem(
                  value: CompressionOption.none,
                  child: Text('Images'),
                ),
                DropdownMenuItem(
                  value: CompressionOption.sevenZ,
                  child: Text('7Z / CB7'),
                ),
                DropdownMenuItem(
                  value: CompressionOption.ace,
                  child: Text('ACE / CBA'),
                ),
                DropdownMenuItem(
                  value: CompressionOption.rar,
                  child: Text('RAR / CBR'),
                ),
                DropdownMenuItem(
                  value: CompressionOption.tar,
                  child: Text('TAR / CBT'),
                ),
                DropdownMenuItem(
                  value: CompressionOption.zip,
                  child: Text('ZIP / CBZ'),
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
