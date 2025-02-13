// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TGTAPI.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Oproduct _$OproductFromJson(Map<String, dynamic> json) {
  return Oproduct(
    id: json['id'] as int,
    inguser: json['inguser'] as int,
    nowuser: json['nowuser'] as int,
    user: json['user'] as String,
    title: json['title'] as String,
    detail: json['detail'] as String,
  );
}

Map<String, dynamic> _$OproductToJson(Oproduct instance) => <String, dynamic>{
      'id': instance.id,
      'inguser': instance.inguser,
      'nowuser': instance.nowuser,
      'user': instance.user,
      'title': instance.title,
      'detail': instance.detail,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://10.0.2.2:4000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Oproduct>> getoproduct() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Oproduct>>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/oproduct',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Oproduct.fromJson(i as Map<String, dynamic>))
        .toList();
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
