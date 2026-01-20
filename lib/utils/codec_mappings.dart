import '../models/format_option.dart';

/// ============================================================
/// Formats (containers)
/// ============================================================
class Formats {
  static const keepOriginal = FormatOption(
    label: 'Keep Original',
    description: 'Do not change container or streams',
  );

  static const mp4 = FormatOption(
    label: 'mp4',
    description: 'Most compatible video format',
  );
  static const avi = FormatOption(
    label: 'avi',
    description: 'Legacy format, widely supported',
  );
  static const mov = FormatOption(
    label: 'mov',
    description: 'Apple QuickTime format',
  );
  static const webm = FormatOption(
    label: 'webm',
    description: 'Web-friendly format',
  );
  static const mkv = FormatOption(
    label: 'mkv',
    description: 'Advanced container',
  );
  static const flv = FormatOption(
    label: 'flv',
    description: 'Streaming format',
  );
  static const g3p = FormatOption(
    label: '3gp',
    description: 'Mobile-friendly legacy format',
  );
  static const g3p2 = FormatOption(label: '3g2', description: '3GPP2 format');

  static const all = [keepOriginal, mp4, avi, mov, webm, mkv, flv, g3p, g3p2];
}

/// ============================================================
/// Video codecs
/// ============================================================
class VideoCodecs {
  static const keep = FormatOption(
    label: 'Keep Original',
    description: 'Do not re-encode video',
  );
  static const h264 = FormatOption(
    label: 'libx264',
    description: 'H.264, widely supported',
  );
  static const h265 = FormatOption(
    label: 'libx265',
    description: 'H.265 / HEVC',
  );
  static const mpeg4 = FormatOption(
    label: 'mpeg4',
    description: 'MPEG-4 Part 2',
  );
  static const h263 = FormatOption(
    label: 'h263',
    description: 'H.263 (legacy 3GP)',
  );

  static const all = [keep, h264, h265, mpeg4, h263];
}

/// ============================================================
/// Audio codecs
/// ============================================================
class AudioCodecs {
  static const keep = FormatOption(
    label: 'Keep Original',
    description: 'Do not re-encode audio',
  );
  static const aac = FormatOption(label: 'aac', description: 'AAC audio');
  static const mp3 = FormatOption(
    label: 'libmp3lame',
    description: 'MP3 audio',
  );
  static const ac3 = FormatOption(label: 'ac3', description: 'Dolby Digital');
  static const flac = FormatOption(label: 'flac', description: 'Lossless FLAC');
  static const amr = FormatOption(
    label: 'libopencore_amrnb',
    description: 'AMR Narrowband',
  );
  static const amrWb = FormatOption(
    label: 'amr_wb',
    description: 'AMR Wideband',
  );
  static const pcm = FormatOption(
    label: 'pcm_s16le',
    description: 'Uncompressed PCM',
  );

  static const all = [keep, aac, mp3, ac3, flac, amr, amrWb, pcm];
}

/// ============================================================
/// Compatibility tables
/// ============================================================
final Map<String, List<FormatOption>> videoCodecsByFormat = {
  Formats.keepOriginal.label: [VideoCodecs.keep],

  Formats.mp4.label: [VideoCodecs.keep, VideoCodecs.h264, VideoCodecs.h265],
  Formats.avi.label: [VideoCodecs.keep, VideoCodecs.h264],
  Formats.mov.label: [VideoCodecs.keep, VideoCodecs.h264, VideoCodecs.h265],
  Formats.webm.label: [VideoCodecs.keep, VideoCodecs.h264],
  Formats.mkv.label: [VideoCodecs.keep, VideoCodecs.h264, VideoCodecs.h265],
  Formats.flv.label: [VideoCodecs.keep, VideoCodecs.h264],
  Formats.g3p.label: [VideoCodecs.keep, VideoCodecs.mpeg4, VideoCodecs.h263],
  Formats.g3p2.label: [VideoCodecs.keep, VideoCodecs.mpeg4, VideoCodecs.h263],
};

final Map<String, List<FormatOption>> audioCodecsByFormat = {
  Formats.keepOriginal.label: [AudioCodecs.keep],

  // Audio-only outputs
  'mp3': [AudioCodecs.keep, AudioCodecs.mp3],
  'm4a': [AudioCodecs.keep, AudioCodecs.aac],
  'wav': [AudioCodecs.keep, AudioCodecs.pcm],
  'flac': [AudioCodecs.keep, AudioCodecs.flac],
  'ogg': [AudioCodecs.keep, AudioCodecs.aac],

  // Video containers
  Formats.mp4.label: [
    AudioCodecs.keep,
    AudioCodecs.aac,
    AudioCodecs.mp3,
    AudioCodecs.ac3,
  ],
  Formats.avi.label: [
    AudioCodecs.keep,
    AudioCodecs.mp3,
    AudioCodecs.ac3,
    AudioCodecs.pcm,
  ],
  Formats.mov.label: [
    AudioCodecs.keep,
    AudioCodecs.aac,
    AudioCodecs.mp3,
    AudioCodecs.pcm,
  ],
  Formats.webm.label: [AudioCodecs.keep, AudioCodecs.aac],
  Formats.mkv.label: [
    AudioCodecs.keep,
    AudioCodecs.aac,
    AudioCodecs.ac3,
    AudioCodecs.mp3,
    AudioCodecs.flac,
  ],
  Formats.flv.label: [AudioCodecs.keep, AudioCodecs.aac, AudioCodecs.mp3],
  Formats.g3p.label: [
    AudioCodecs.keep,
    AudioCodecs.aac,
    AudioCodecs.amr,
    AudioCodecs.amrWb,
  ],
  Formats.g3p2.label: [
    AudioCodecs.keep,
    AudioCodecs.aac,
    AudioCodecs.amr,
    AudioCodecs.amrWb,
  ],
};

/// ============================================================
/// Public helpers
/// ============================================================
List<FormatOption> getVideoCodecs(String formatLabel) {
  return videoCodecsByFormat[formatLabel] ?? const [VideoCodecs.keep];
}

List<FormatOption> getAudioCodecs(String formatLabel) {
  return audioCodecsByFormat[formatLabel] ?? const [AudioCodecs.keep];
}

/// ============================================================
/// Metadata-only detection
/// ============================================================
bool isMetadataOnlyRun({
  required String format,
  required String videoCodec,
  required String audioCodec,
}) {
  return format == Formats.keepOriginal.label &&
      videoCodec == VideoCodecs.keep.label &&
      audioCodec == AudioCodecs.keep.label;
}
