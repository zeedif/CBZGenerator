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
              onChanged: controller.onContentTypeChanged,
              items: const [
                DropdownMenuItem(
                  value: CompressionOption.none,
                  child: Text('Images', overflow: TextOverflow.ellipsis),
                ),
                DropdownMenuItem(
                  value: CompressionOption.sevenZ,
                  child: Text(
                    '7Z / CB7',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DropdownMenuItem(
                  value: CompressionOption.ace,
                  child: Text(
                    'ACE / CBA',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DropdownMenuItem(
                  value: CompressionOption.rar,
                  child: Text(
                    'RAR / CBR',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DropdownMenuItem(
                  value: CompressionOption.tar,
                  child: Text(
                    'TAR / CBT',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DropdownMenuItem(
                  value: CompressionOption.zip,
                  child: Text(
                    'ZIP / CBZ',
                    overflow: TextOverflow.ellipsis,
                  ),
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
