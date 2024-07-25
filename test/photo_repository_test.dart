import 'package:bloc_rxdart/src/data/datasources/post_api_service.dart';
import 'package:bloc_rxdart/src/data/repositories/photo_repository_impl.dart';
import 'package:bloc_rxdart/src/domain/repositories/photo_repository.dart';
import 'package:bloc_rxdart/src/utils/error/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateMocks([PostApiService])
import 'photo_repository_test.mocks.dart';

void main() {
  late MockPostApiService mockPostApiService;
  late PhotoRepository photoRepository;

  setUp(() {
    mockPostApiService = MockPostApiService();
    photoRepository = PhotoRepositoryImpl(mockPostApiService);
  });

  group('PhotoRepository', () {
    test('should throw Failure when DioErrorType is connectionTimeout',
        () async {
      when(mockPostApiService.getPhotos()).thenAnswer((_) => Future.error(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.connectionTimeout,
              message: 'connection timeout',
            ),
          ));

      await expectLater(
        photoRepository.getPhotos(),
        emitsError(predicate((e) =>
            e is Failure && e.code == -1 && e.message == 'Connect timeout')),
      );
    });

    test('should throw Failure when DioErrorType is sendTimeout', () async {
      when(mockPostApiService.getPhotos()).thenAnswer((_) => Future.error(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.sendTimeout,
              message: 'send timeout',
            ),
          ));

      await expectLater(
        photoRepository.getPhotos(),
        emitsError(predicate((e) =>
            e is Failure && e.code == -4 && e.message == 'Send timeout')),
      );
    });

    test('should throw Failure when DioErrorType is receiveTimeout', () async {
      when(mockPostApiService.getPhotos()).thenAnswer((_) => Future.error(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.receiveTimeout,
              message: 'receive timeout',
            ),
          ));

      await expectLater(
        photoRepository.getPhotos(),
        emitsError(predicate((e) =>
            e is Failure && e.code == -3 && e.message == 'Receive timeout')),
      );
    });

    test(
        'should throw Failure when DioErrorType is badResponse with 400 status',
        () async {
      when(mockPostApiService.getPhotos()).thenAnswer((_) => Future.error(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.badResponse,
              response: Response(
                requestOptions: RequestOptions(path: ''),
                statusCode: 400,
              ),
            ),
          ));

      await expectLater(
        photoRepository.getPhotos(),
        emitsError(predicate((e) =>
            e is Failure && e.code == 400 && e.message == 'Bad request')),
      );
    });

    test(
        'should throw Failure when DioErrorType is badResponse with 401 status',
        () async {
      when(mockPostApiService.getPhotos()).thenAnswer((_) => Future.error(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.badResponse,
              response: Response(
                requestOptions: RequestOptions(path: ''),
                statusCode: 401,
              ),
            ),
          ));

      await expectLater(
        photoRepository.getPhotos(),
        emitsError(predicate((e) =>
            e is Failure && e.code == 401 && e.message == 'Unauthorised')),
      );
    });

    test(
        'should throw Failure when DioErrorType is badResponse with 500 status',
        () async {
      when(mockPostApiService.getPhotos()).thenAnswer((_) => Future.error(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.badResponse,
              response: Response(
                requestOptions: RequestOptions(path: ''),
                statusCode: 500,
              ),
            ),
          ));

      await expectLater(
        photoRepository.getPhotos(),
        emitsError(predicate((e) =>
            e is Failure &&
            e.code == 500 &&
            e.message == 'Internal server error')),
      );
    });

    test('should throw Failure when DioErrorType is cancel', () async {
      when(mockPostApiService.getPhotos()).thenAnswer((_) => Future.error(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.cancel,
              message: 'request cancelled',
            ),
          ));

      await expectLater(
        photoRepository.getPhotos(),
        emitsError(predicate((e) =>
            e is Failure && e.code == -2 && e.message == 'Request cancelled')),
      );
    });

    test('should throw Failure for unknown DioErrorType', () async {
      when(mockPostApiService.getPhotos()).thenAnswer((_) => Future.error(
            DioException(
              requestOptions: RequestOptions(path: ''),
              type: DioExceptionType.unknown,
              message: 'unknown error',
            ),
          ));

      await expectLater(
        photoRepository.getPhotos(),
        emitsError(predicate((e) =>
            e is Failure &&
            e.code == -7 &&
            e.message == 'Something went wrong')),
      );
    });
  });
}
