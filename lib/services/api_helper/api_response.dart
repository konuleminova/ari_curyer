enum Status { Loading, Done, Error, Idle }

class ApiResponse<T> {
  T data;
  Status status;
  AppException error;

  ApiResponse({this.data, this.status, this.error});

  factory ApiResponse.initial() {
    return new ApiResponse(status: Status.Idle, data: null, error: null);
  }

  factory ApiResponse.completed(T data) {
    return new ApiResponse(status: Status.Done, data: data, error: null);
  }

  factory ApiResponse.loading() {
    return new ApiResponse(status: Status.Loading, data: null, error: null);
  }

  factory ApiResponse.error(AppException appException) {
    return new ApiResponse(
        status: Status.Error, data: null, error: appException);
  }

  ApiResponse<V> copyWithData<V>(V Function(T) mapper) {
    return new ApiResponse<V>(
        status: this.status,
        error: this.error,
        data: this.data != null ? mapper(data) : null);
  }

  @override
  String toString() {
    return 'ApiResponse{data: $data, status: $status, error: $error}';
  }
}

class AppException implements Exception {
  String message;

  AppException({this.message});
}
