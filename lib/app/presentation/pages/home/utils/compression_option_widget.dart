import 'package:cbz_generator/app/constants.dart';
import 'package:cbz_generator/app/domain/enums/compression_option.dart';
import 'package:cbz_generator/app/domain/enums/input_type.dart';
import 'package:cbz_generator/app/presentation/pages/home/controller/home_controller.dart';
import 'package:cbz_generator/app/presentation/widgets/dropdown_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

Consumer CompressionOptionWidget(HomeController controller) {
  return Consumer(
    builder: (_, ref, __) {
      final contentType = ref.watch(homeProvider).state.contentType;
      final inputType =
          ref.watch(homeProvider.select((p) => p.inputType)).state.inputType;
      if (contentType == CompressionOption.none ||
          inputType == InputType.chapter) {
        return Column(
          children: [
            DropdownSelector(
              value: controller.state.compressionOption,
              onChanged: controller.onCompressionOptionChanged,
              items: const [
                DropdownMenuItem(
                  value: CompressionOption.sevenZ,
                  child: Text('7Z', overflow: TextOverflow.ellipsis),
                ),
                DropdownMenuItem(
                  value: CompressionOption.ace,
                  child: Text('ACE', overflow: TextOverflow.ellipsis),
                ),
                DropdownMenuItem(
                  value: CompressionOption.rar,
                  child: Text('RAR', overflow: TextOverflow.ellipsis),
                ),
                DropdownMenuItem(
                  value: CompressionOption.tar,
                  child: Text('TAR', overflow: TextOverflow.ellipsis),
                ),
                DropdownMenuItem(
                  value: CompressionOption.zip,
                  child: Text('ZIP', overflow: TextOverflow.ellipsis),
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
