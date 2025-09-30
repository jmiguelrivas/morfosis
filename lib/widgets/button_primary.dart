import 'button.dart';

class CustomBtnPrimary extends CustomBtnBase {
  const CustomBtnPrimary({
    super.key,
    required super.glyph,
    required super.tooltip,
    required super.accent,
    required super.action,
    super.label,
  }) : super(isPrimary: true);
}