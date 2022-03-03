// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_suggestions_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _DadataClient implements DadataClient {
  _DadataClient(this._dio, {this.baseUrl}) {
    baseUrl ??=
        'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Suggestions> getSuggestions(query, tokenString) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'query': query};
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json',
      r'Custom-Header': 'Your header',
      r'Authorization': tokenString
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Suggestions>(Options(
                method: 'GET',
                headers: _headers,
                extra: _extra,
                contentType: 'application/json')
            .compose(_dio.options, '/',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Suggestions.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
