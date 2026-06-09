abstract class ResponseListener {
  void onSuccess({var response}) {}
  void onFailure({var response}) {}
}

class CallbackResponseListener extends ResponseListener {
  CallbackResponseListener({
    required this.onSuccessCallback,
    required this.onFailureCallback,
  });

  final void Function(dynamic response) onSuccessCallback;
  final void Function(dynamic response) onFailureCallback;

  @override
  void onSuccess({var response}) => onSuccessCallback(response);

  @override
  void onFailure({var response}) => onFailureCallback(response);
}