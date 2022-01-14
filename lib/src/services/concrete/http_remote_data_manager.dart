import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../guki_core.dart';
import '../../constants/api_constants.dart';

class HttpRemoteDataManager
    with JsonConverterMixin, HttpStatusCodeControllerMixin
    implements RemoteDataService {
  static HttpRemoteDataManager? _instance;

  final http.Client _client;

  String _baseUrl;
  Map<String, String> _header;
  DurationTypes _timeout;

  static HttpRemoteDataManager getInstance(
      {String? baseUrl, Map<String, String>? header, DurationTypes? timeout}) {
    _instance ??= HttpRemoteDataManager._init(
      baseUrl: baseUrl,
      header: header,
      timeout: timeout,
    );
    return _instance!;
  }

  HttpRemoteDataManager._init({
    String? baseUrl,
    Map<String, String>? header,
    DurationTypes? timeout,
  })  : _baseUrl = baseUrl ?? ApiConstants.baseUrl,
        _header = header ??
            {HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'},
        _timeout = timeout ?? DurationTypes.sixteenSeconds,
        _client = http.Client();

  @override
  Map<String, String> get baseHeader => _header;

  @override
  String get baseUrl => _baseUrl;

  @override
  Duration get getTimeout => _timeout.rawValue();

  @override
  RemoteDataService setUrl(String url) {
    _baseUrl = url;
    return _instance ?? HttpRemoteDataManager._init();
  }

  @override
  RemoteDataService setHeader(Map<String, String> header) {
    _header = header;
    return _instance ?? HttpRemoteDataManager._init();
  }

  @override
  RemoteDataService setTimeout(DurationTypes timeout) {
    _timeout = timeout;
    return _instance ?? HttpRemoteDataManager._init();
  }

  @override
  RemoteDataService addBearerTokenToHeader(String token) {
    _header['Authorization'] = 'Bearer $token';
    return _instance ?? HttpRemoteDataManager._init();
  }

  @override
  RemoteDataService addToHeader(String key, String value) {
    _header[key] = value;
    return _instance ?? HttpRemoteDataManager._init();
  }

  @override
  Future<DataResult<String>> getByResponseJson({
    required String endpoint,
    String? query,
    Map<String, String>? headers,
    DurationTypes? timeoutDuration,
  }) async {
    var result = await get(
      endpoint: endpoint,
      query: query,
      headers: headers,
      timeoutDuration: timeoutDuration,
    );

    return result.success
        ? SuccessDataResult(data: jsonDecode(result.data?.body ?? emptyJson))
        : ErrorDataResult(message: result.message);
  }

  @override
  Future<DataResult<TReturn>> getData<TReturn, TModel>({
    required String endpoint,
    required TModel parseModel,
    String? query,
    Map<String, String>? headers,
    DurationTypes? timeoutDuration,
  }) async {
    var result = await get(
      endpoint: endpoint,
      query: query,
      headers: headers,
      timeoutDuration: timeoutDuration,
    );

    return result.success
        ? convertJson<TReturn, TModel>(
            parseModel, jsonDecode(result.data?.body ?? emptyJson))
        : ErrorDataResult(message: result.message);
  }

  @override
  Future<ApiResponse<TReturn, TModel>> getDataByApiResponse<TReturn, TModel>({
    required String endpoint,
    TModel? parseModel,
    String? query,
    Map<String, String>? headers,
    ApiResponse<TReturn, TModel>? apiResponse,
    DurationTypes? timeoutDuration,
  }) async {
    var result = await get(
      endpoint: endpoint,
      query: query,
      headers: headers,
      timeoutDuration: timeoutDuration,
    );

    if (!result.success) {
      apiResponse?.message = result.message;
      apiResponse?.success = false;
      return apiResponse ??
          ApiResponseModel<TReturn, TModel>(
              message: result.message, success: false);
    }

    return convertApiResponse<TReturn, TModel>(
      jsonBody: result.data?.body,
      apiResponse: apiResponse ?? ApiResponseModel<TReturn, TModel>(),
      parseModel: parseModel,
    );
  }

  @override
  Future<DataResult<http.Response>> get(
      {required String endpoint,
      String? query,
      Map<String, String>? headers,
      DurationTypes? timeoutDuration}) async {
    try {
      var response = await _client
          .get(
            Uri.parse(_getUrl(endpoint, query)),
            headers: headers ?? baseHeader,
          )
          .timeout(timeoutDuration?.rawValue() ?? getTimeout);

      return response.statusCode == HttpStatus.ok
          ? SuccessDataResult<http.Response>(data: response)
          : ErrorDataResult(message: ApiMessages.getDataError);
    } on SocketException {
      throw ConnectionException();
    } on ServerException {
      throw ServerException();
    } on TimeoutException {
      throw Exception(ApiMessages.timeoutError);
    } catch (error) {
      return ErrorDataResult(message: error.toString());
    }
  }

  @override
  Future<DataResult<TReturn>> postByData<TReturn, TParse>({
    required String endpoint,
    required Object body,
    bool isJsonEncode = true,
    required TParse parseModel,
    Map<String, String>? headers,
    DurationTypes? timeoutDuration,
  }) async {
    var result = await post(
      endpoint: endpoint,
      body: isJsonEncode ? jsonEncode(body) : body,
      headers: headers,
      timeoutDuration: timeoutDuration,
    );

    return result.success
        ? convertJson<TReturn, TParse>(
            parseModel, jsonDecode(result.data?.body ?? emptyJson))
        : ErrorDataResult(message: result.message);
  }

  @override
  Future<ApiResponse<TReturn, TParse>> postByResponseData<TReturn, TParse>({
    required String endpoint,
    required Object body,
    bool isJsonEncode = true,
    required TParse parseModel,
    Map<String, String>? headers,
    ApiResponse<TReturn, TParse>? apiResponse,
    DurationTypes? timeoutDuration,
  }) async {
    var result = await post(
      endpoint: endpoint,
      body: isJsonEncode ? jsonEncode(body) : body,
      headers: headers,
      timeoutDuration: timeoutDuration,
    );

    if (!result.success) {
      apiResponse?.message = result.message;
      apiResponse?.success = false;
      return apiResponse ??
          ApiResponseModel(message: result.message, success: false);
    }

    return convertApiResponse<TReturn, TParse>(
      jsonBody: result.data?.body,
      apiResponse: apiResponse ?? ApiResponseModel<TReturn, TParse>(),
      parseModel: parseModel,
    );
  }

  @override
  Future<DataResult<String>> postByResponseJson({
    required String endpoint,
    required Object body,
    bool isJsonEncode = true,
    Map<String, String>? headers,
    DurationTypes? timeoutDuration,
  }) async {
    var result = await post(
      endpoint: endpoint,
      body: isJsonEncode ? jsonEncode(body) : body,
      headers: headers,
      timeoutDuration: timeoutDuration,
    );

    return result.success
        ? SuccessDataResult(data: jsonDecode(result.data?.body ?? emptyJson))
        : ErrorDataResult(message: result.message);
  }

  @override
  Future<DataResult<http.Response>> post({
    required String endpoint,
    Object? body,
    Map<String, String>? headers,
    DurationTypes? timeoutDuration,
  }) async {
    try {
      var response = await _client
          .post(
            Uri.parse(_getUrl(endpoint, null)),
            headers: headers ?? baseHeader,
            body: body,
          )
          .timeout(timeoutDuration?.rawValue() ?? getTimeout);

      return checkStatusCode(response.statusCode).success
          ? SuccessDataResult(data: response)
          : ErrorDataResult(data: response, message: ApiMessages.sendDataError);
    } on SocketException {
      throw ConnectionException();
    } on ServerException {
      throw ServerException();
    } on TimeoutException {
      throw Exception(ApiMessages.timeoutError);
    } catch (error) {
      return ErrorDataResult(message: error.toString());
    }
  }

  String _getUrl(String endpoint, String? query) {
    return query?.isNotEmpty ?? false
        ? '$baseUrl/$endpoint?$query'
        : '$baseUrl/$endpoint';
  }
}
