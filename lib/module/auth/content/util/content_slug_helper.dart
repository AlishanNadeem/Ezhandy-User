/// Maps legacy [WebContentType] route `type` values to API page slugs
/// (about, privacy, terms, refund).
class ContentSlugHelper {
  static String fromType(String? type) {
    switch (type) {
      case 'tc':
        return 'terms';
      case 'pp':
        return 'privacy';
      case 'ap':
        return 'about';
      case 'rp':
        return 'refund-policy';
      default:
        if (type != null && type.trim().isNotEmpty) {
          return type.trim().toLowerCase();
        }
        return 'about';
    }
  }
}
