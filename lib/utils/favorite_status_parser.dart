import 'dart:convert';

/// Parses `{ data: ... }` from favourites status GET (provider or service).
bool parseFavoriteStatusPayload(dynamic response) {
  if (response is! Map) return false;
  dynamic data = response['data'];
  if (data is String) {
    try {
      data = jsonDecode(data);
    } catch (_) {
      data = null;
    }
  }
  if (data is bool) return data;
  if (data is Map) {
    return _coerceFavoriteBool(Map<String, dynamic>.from(data));
  }
  return _coerceFavoriteBool(Map<String, dynamic>.from(response));
}

bool _coerceFavoriteBool(Map<String, dynamic> m) {
  const keys = [
    'isFavorite',
    'is_favorite',
    'isFavourite',
    'is_favourite',
    'favourite',
    'favorite',
    'favorited',
    'isInFavorites',
  ];
  for (final key in keys) {
    final v = m[key];
    if (v is bool) return v;
    if (v == 1 || v == '1') return true;
    if (v == 0 || v == '0') return false;
    if (v is String && v.toLowerCase() == 'true') return true;
    if (v is String && v.toLowerCase() == 'false') return false;
  }
  return false;
}
