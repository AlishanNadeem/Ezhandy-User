class WorkDocumentsRoutingArgument {
  final String? serviceTitle;
  final String? serviceDescription;
  final List<String> beforeImagePaths;
  final List<String> afterImagePaths;

  WorkDocumentsRoutingArgument({
    this.serviceTitle,
    this.serviceDescription,
    List<String>? beforeImagePaths,
    List<String>? afterImagePaths,
  })  : beforeImagePaths = beforeImagePaths ?? const <String>[],
        afterImagePaths = afterImagePaths ?? const <String>[];
}
