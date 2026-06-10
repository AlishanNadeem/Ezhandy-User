import 'package:ezhandy_user/utils/network_strings.dart';

/// Builds a full media URL from an API-relative path, or returns absolute URLs as-is.
String resolveMediaUrl(dynamic path) {
  final s = path?.toString().trim() ?? '';
  if (s.isEmpty || s.toLowerCase() == 'null') return '';
  if (s.startsWith('http://') || s.startsWith('https://')) return s;
  return '${NetworkStrings.IMAGE_BASE_URL}$s';
}
