abstract class ApiResultListener<T> {
  void onRequesting();
  void onSuccess(List<T> response);
  void onError(String message);
}
abstract class SignInListener<T> {
  void onNeedUpdate();
  void onSuccess(List<T> response);
  void onError(String message);
}
abstract class RequestTaskListener<T> {
  void onRequestTaskError(String message);
  void onRequestTaskSuccess();
}

abstract class OnDeleteListener<T> {
  void onDeleteSuccess(T response);
}