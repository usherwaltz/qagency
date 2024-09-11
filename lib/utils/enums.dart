enum BlocStateUIStatus { initial, loading, loadingMore, loaded, error }

/// Commonly seen status codes
enum ResponseTypes {
  /// 200
  ok,

  /// Request took too long (over 3s)
  timeout,

  /// 400 and 401
  badRequest,

  /// 403
  unauthorised,

  /// 500
  unexpected,

  /// 404
  notFound,

  ///204
  noContent,

  /// 422
  unProcessableEntity,

  ///503
  serviceUnavailable,
}
