import 'package:cbz_generator/app/domain/enums/compression_option.dart';
import 'package:cbz_generator/app/domain/enums/input_type.dart';
import 'package:cbz_generator/app/domain/enums/output_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();
  const factory HomeState({
    @Default('') String inputDir,
    @Default('') String outputDir,
    @Default('') String compressorPath,
    @Default('') String pythonScriptPath,
    @Default(false) bool deleteInputFiles,
    @Default(null) InputType? inputType,
    @Default(null) CompressionOption? compressionOption,
    @Default(null) CompressionOption? contentType,
    @Default(null) OutputType? outputType,
  }) = _HomeState;

  static HomeState get initialState => HomeState();
}
