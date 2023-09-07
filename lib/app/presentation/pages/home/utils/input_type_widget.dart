import 'package:cbz_generator/app/domain/enums/input_type.dart';
import 'package:cbz_generator/app/presentation/pages/home/controller/home_controller.dart';
import 'package:cbz_generator/app/presentation/widgets/dropdown_selector.dart';
import 'package:flutter/material.dart';

DropdownSelector<InputType> InputTypeWidget(HomeController controller) {
  return DropdownSelector(
    value: controller.state.inputType,
    onChanged: controller.onInputTypeChanged,
    items: const [
      DropdownMenuItem(
        value: InputType.chapter,
        child: Text(
          'Single Chapter (Images Only)',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      DropdownMenuItem(
        value: InputType.volume,
        child: Text(
          'Volume (Folders Only)',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      DropdownMenuItem(
        value: InputType.series,
        child: Text(
          'Series (Folders Only)',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      DropdownMenuItem(
        value: InputType.library,
        child: Text(
          'Library (Folders Only)',
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
