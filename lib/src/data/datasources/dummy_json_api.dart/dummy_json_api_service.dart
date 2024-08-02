import 'package:bloc_rxdart/src/domain/models/login/request/login_request.dart';
import 'package:bloc_rxdart/src/domain/models/login/response/user_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'dummy_json_api_service.g.dart';

@RestApi()
abstract class DummyJsonApiService {
  factory DummyJsonApiService(Dio dio) = _DummyJsonApiService;

  @POST("/auth/login")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<UserModel> login(@Body() LoginRequest body);
}
