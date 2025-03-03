import 'package:dio/dio.dart';
import 'package:pet_adoption/failure/rest_client_status.dart';

import 'failure_error_message.dart';
import 'failure_erros.dart';

class RepositoryError implements Failure {
  RepositoryError();
  Failure getError(Object e) {
    if (e is DioException) {
      if (e.response != null &&
          e.response!.statusCode != null &&
          e.response!.statusMessage != null) {
        switch (e.response!.statusCode) {
          case RestClientStatus.invalidParams:
            return InvalidParamsError(message: e.response!.statusMessage);
          case RestClientStatus.unauthorized:
            return UnauthorizedError(message: e.response!.statusMessage);
          case RestClientStatus.notFound:
            return NotFoundError(message: e.response!.statusMessage);
          case RestClientStatus.timeOut:
            return TimeOutError(message: e.response!.statusMessage);
          case RestClientStatus.internalServer:
            return InternalServerError(message: e.response!.statusMessage);
          default:
            return InternalServerError(message: e.response!.statusMessage);
        }
      } else {
        return InternalServerError(
            message: FailureErrorMessage.internalServerErrorMessage);
      }
    } else {
      return FatalError(message: FailureErrorMessage.fatalErrorMessage);
    }
  }

  @override
  String? get message => 'Error';
}
