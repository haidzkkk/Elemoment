enum Status{
  idle,
  loading,
  success,
  failure,
}

extension StatusExtension on Status{
  bool get isInit => this == Status.idle;
  bool get isLoading => this == Status.loading;
  bool get isSuccessFull => this == Status.success;
  bool get isFailed => this == Status.failure;
}