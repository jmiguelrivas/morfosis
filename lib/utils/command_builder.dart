import '../state/notifier.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

Future<String> buildComando() async {
  final downloadsDir = Directory('/storage/emulated/0/Download/Morfosis');

  // If output format is Keep Original, use the input extension in the output file
  final outputFormat = settingsNotifier.value.outputFormat == 'Keep Original'
      ? '<FILE_EXT>' // placeholder to represent the original file extension
      : settingsNotifier.value.outputFormat;

  final output = p.join(
    downloadsDir.path,
    '${settingsNotifier.value.outputPrefix}<FILE_NAME>${settingsNotifier.value.outputSuffix}.$outputFormat',
  );

  final overwriteFlag = settingsNotifier.value.overwrite ? '-y' : '';

  final metadataFlag = settingsNotifier.value.clearExif
      ? '-map_metadata -1'
      : '';

  final codecFlags = settingsNotifier.value.outputFormat == 'Keep Original'
      ? '-c copy'
      : [
          if (settingsNotifier.value.videoCodec != 'Keep Original')
            '-c:v ${settingsNotifier.value.videoCodec}',
          if (settingsNotifier.value.audioCodec != 'Keep Original')
            '-c:a ${settingsNotifier.value.audioCodec}',
          if (settingsNotifier.value.videoCodec == 'Keep Original') '-c:v copy',
          if (settingsNotifier.value.audioCodec == 'Keep Original') '-c:a copy',
        ].join(' ');

  return [
    'ffmpeg',
    overwriteFlag,
    '-i',
    '<FILE_PATH>',
    metadataFlag,
    codecFlags,
    '"$output"',
  ].where((e) => e.isNotEmpty).join(' ');
}
