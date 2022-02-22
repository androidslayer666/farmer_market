import 'package:farmer_market/repository/models/api/suggestion.dart';
import 'package:farmer_market/repository/models/api/suggestions.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart' as retro;
import 'package:dio/dio.dart';

import '../repository/constants.dart';

part 'address_suggestions_rest_client.g.dart';


@retro.RestApi(baseUrl: dadataBaseUrl)
abstract class DadataClient {
  factory DadataClient(Dio dio) = _DadataClient;

  @retro.GET("/")
  @retro.Headers(<String, dynamic>{
    "Content-Type" : "application/json",
    "Custom-Header" : "Your header"
  })
  Future<Suggestions> getSuggestions(@retro.Query("query") String query, @Header("Authorization") String tokenString);
}