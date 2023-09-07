import 'package:cbz_generator/app/constants.dart';
import 'package:cbz_generator/app/domain/enums/input_type.dart';
import 'package:cbz_generator/app/presentation/pages/home/controller/home_controller.dart';
import 'package:flutter/material.dart';

DropdownButtonFormField<InputType> InputTypeWidget(HomeController controller) {
  return DropdownButtonFormField(
    decoration: const InputDecoration(
      labelText: 'Input Type',
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.only(
        top: 0,
        left: kDefaultPadding / 2,
        right: kDefaultPadding / 2,
      ),
    ),
    value: controller.state.inputType,
    onChanged: controller.onInputTypeChanged,
    items: const [
      DropdownMenuItem(
        value: InputType.chapter,
        child: Text('Only images in folder (Single C11h1apter)',
            overflow: TextOverflow.ellipsis),
      ),
      DropdownMenuItem(
        value: InputType.volume,
        child: Text('Only folders in folder (Volume)',
            overflow: TextOverflow.ellipsis),
      ),
      DropdownMenuItem(
        value: InputType.series,
        child: Text('Only folders in root (Serie)',
            overflow: TextOverflow.ellipsis),
      ),
      DropdownMenuItem(
        value: InputType.library,
        child: Text('Only folders (Library)', overflow: TextOverflow.ellipsis),
      ),
    ],
  );
}
