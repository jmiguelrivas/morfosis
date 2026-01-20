class UiSettings {
  String outputFormat;
  String videoCodec;
  String audioCodec;
  String outputPrefix;
  String outputSuffix;
  bool overwrite;
  bool clearExif;

  UiSettings({
    this.outputFormat = 'Keep Original',
    this.videoCodec = 'Keep Original',
    this.audioCodec = 'Keep Original',
    this.outputPrefix = '',
    this.outputSuffix = '',
    this.overwrite = true,
    this.clearExif = true,
  });

  UiSettings copyWith({
    String? outputFormat,
    String? videoCodec,
    String? audioCodec,
    String? outputPrefix,
    String? outputSuffix,
    String? command,
    bool? overwrite,
    bool? clearExif,
  }) {
    return UiSettings(
      outputFormat: outputFormat ?? this.outputFormat,
      videoCodec: videoCodec ?? this.videoCodec,
      audioCodec: audioCodec ?? this.audioCodec,
      outputPrefix: outputPrefix ?? this.outputPrefix,
      outputSuffix: outputSuffix ?? this.outputSuffix,
      overwrite: overwrite ?? this.overwrite,
      clearExif: clearExif ?? this.clearExif,
    );
  }
}
