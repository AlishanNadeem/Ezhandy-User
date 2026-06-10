/// Local case-insensitive list filter by a title field. Returns all [items]
/// when [query] is empty.
List<T> filterListByTitle<T>({
  required List<T> items,
  required String query,
  required String Function(T item) titleOf,
}) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return List<T>.from(items);
  return items
      .where((item) => titleOf(item).trim().toLowerCase().contains(q))
      .toList();
}

/// Reads [fullName] from a flat map or nested `userDetails.fullName`.
String displayNameFromUserPayload(dynamic item) {
  if (item is! Map) return '';
  final nested = item['userDetails'];
  if (nested is Map) {
    final name = nested['fullName']?.toString().trim() ?? '';
    if (name.isNotEmpty) return name;
  }
  return item['fullName']?.toString().trim() ?? '';
}

/// Convenience for API rows stored as [Map] (e.g. `name`, `title`).
List<dynamic> filterMapsByTitleKey({
  required List<dynamic> items,
  required String query,
  String titleKey = 'title',
}) {
  return filterListByTitle<dynamic>(
    items: items,
    query: query,
    titleOf: (item) {
      if (item is Map) return item[titleKey]?.toString() ?? '';
      return '';
    },
  );
}
