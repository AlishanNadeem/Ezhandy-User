import 'package:ezhandy_user/utils/network_strings.dart';

/// Builds a full media URL from an API-relative path, or returns absolute URLs as-is.
String resolveMediaUrl(dynamic path) {
  final s = path?.toString().trim() ?? '';
  if (s.isEmpty || s.toLowerCase() == 'null') return '';
  if (s.startsWith('http://') || s.startsWith('https://')) return s;

  final base = NetworkStrings.IMAGE_BASE_URL.trim().replaceAll(RegExp(r'/+$'), '');
  final normalizedPath = s.startsWith('/') ? s : '/$s';
  return '$base$normalizedPath';
}

/// Candidate URLs for chat media when the primary path fails to load.
List<String> resolveChatMediaUrlCandidates(dynamic path) {
  final s = path?.toString().trim() ?? '';
  if (s.isEmpty || s.toLowerCase() == 'null') return [];

  final primary = resolveMediaUrl(s);
  if (primary.isEmpty) return [];

  final candidates = <String>[primary];
  if (s.startsWith('http://') || s.startsWith('https://')) {
    return candidates;
  }

  final base =
      NetworkStrings.IMAGE_BASE_URL.trim().replaceAll(RegExp(r'/+$'), '');
  final relative = s.startsWith('/') ? s.substring(1) : s;

  for (final prefix in ['storage/', 'public/storage/', 'uploads/']) {
    if (!relative.startsWith(prefix)) {
      final alt = '$base/$prefix$relative';
      if (!candidates.contains(alt)) candidates.add(alt);
    }
  }

  return candidates;
}
