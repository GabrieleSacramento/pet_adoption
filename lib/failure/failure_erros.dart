abstract class Failure {
  String? get message;
}

class InvalidParamsError extends Failure {
  @override
  final String? message;
  InvalidParamsError({
    this.message,
  });
}

class UnauthorizedError extends Failure {
  @override
  final String? message;
  UnauthorizedError({
    this.message,
  });
}

class InternalServerError extends Failure {
  @override
  final String? message;
  InternalServerError({
    this.message,
  });
}

class TimeOutError extends Failure {
  @override
  final String? message;
  TimeOutError({
    this.message,
  });
}

class NotFoundError extends Failure {
  @override
  final String? message;
  NotFoundError({
    this.message,
  });
}

class FatalError extends Failure {
  @override
  final String? message;
  FatalError({
    this.message,
  });
}
