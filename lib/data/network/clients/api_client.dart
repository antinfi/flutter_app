import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/models.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET('country')
  Future<Paginated<AppCountry>> countryList(@Queries() Map<String, dynamic> queries);
}
