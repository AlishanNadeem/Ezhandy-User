import 'package:flutter/material.dart';
import 'package:ezhandy_user/utils/app_colors.dart';

/// API reaction kinds: `thumb`, `heart`, `smile` only.
abstract class CommunityReactionType {
  CommunityReactionType._();

  static const String thumb = 'thumb';
  static const String heart = 'heart';
  static const String smile = 'smile';

  static const List<String> values = [thumb, heart, smile];

  /// Returns [thumb], [heart], or [smile] if recognized; otherwise `null`.
  static String? normalize(String? raw) {
    if (raw == null) return null;
    final s = raw.toLowerCase().trim();
    if (s == thumb || s == heart || s == smile) return s;
    return null;
  }

  static IconData icon(String type) {
    switch (type) {
      case thumb:
        return Icons.thumb_up;
      case heart:
        return Icons.favorite;
      case smile:
        return Icons.emoji_emotions;
      default:
        return Icons.favorite_border;
    }
  }

  static Color color(String type) {
    switch (type) {
      case thumb:
        return Colors.blue;
      case heart:
        return Colors.red;
      case smile:
        return Colors.orange;
      default:
        return AppColors.greyLight;
    }
  }
}
