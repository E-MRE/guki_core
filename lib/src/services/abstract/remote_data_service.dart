import '../../../guki_core.dart';

abstract class RemoteDataService {
  /* ******************************************************************* */
  /* ************************ GETTER -- SETTERS ************************ */
  /* ******************************************************************* */

  ///Base url for get and post datas.
  String get baseUrl;

  ///API header
  Map<String, String> get baseHeader;

  ///Gets timeout of http methods.
  Duration get getTimeout;

  ///Set base url of remote service with custom url.
  RemoteDataService setUrl(String url);

  ///Set remote service header with custom header
  RemoteDataService setHeader(Map<String, String> header);

  ///Set timeout of http methods.
  RemoteDataService setTimeout(DurationTypes duration);

  ///Add custom token to service header
  RemoteDataService addBearerTokenToHeader(String token);

  ///Add key and value to service header
  RemoteDataService addToHeader(String key, String value);

  /* ******************************************************************* */
  /* *************************** GET METHODS *************************** */
  /* ******************************************************************* */

  ///Base get method of remote service.
  Future<DataResult> get({
    required String endpoint,
    String? query,
    Map<String, String>? headers,
    DurationTypes? timeoutDuration,
  });

  ///Use for get only data from API. If you want to use that function
  ///you must set return type and parse model type.
  ///
  ///`TReturn:` is type of return. It can be [List] or [Model].
  ///
  /// Example:
  /// ```dart
  /// DataResult<List<User>> result = await getData<List<User>,User>(...);
  /// ```
  ///
  ///`TModel:` is model of json data. TModel type using for parse to the json.
  ///Type of [parseModel] is [TModel], so your data's type should be TModel.
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///`[parseModel]` : required for parsing to response body.
  /// Your data's type should be [TModel].
  ///
  ///And also you can use `query` and `header`
  ///
  ///Example:
  ///
  /// ```dart
  /// DataResult<List<User>> result = await getData<List<User>,User>(
  /// endpoint: 'api/Controller/GetUsers',
  /// query: '?type=customer',
  /// parseModel: User(),
  /// headers: {'Content-type':'application/json'},
  /// timeoutDuration: DurationTypes.sixteenSeconds,
  /// );
  /// ```
  Future<DataResult<TReturn>> getData<TReturn, TModel>({
    required String endpoint,
    required TModel parseModel,
    String? query,
    Map<String, String>? headers,
    DurationTypes? timeoutDuration,
  });

  ///Use for get data on API by `ApiResponse` model. If you want to use that function
  ///you must set return type and parse model type.
  ///
  ///`TReturn:` is type of return. It can be [List] or [Model].
  ///
  /// Example:
  /// ```dart
  /// ApiResponseModel<List<User>, User> result = await getDataByApiResponse<List<User>,User>(...);
  /// ```
  ///
  ///`TModel:` is model of json data. TModel type using for parse to the json.
  ///Type of [parseModel] is [TModel], so your data's type should be TModel.
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///`[parseModel]` : required for parsing to response body.
  /// Your data's type should be [TModel].
  ///
  ///And also you can use `query` and `header`
  ///
  ///Example:
  ///
  /// ```dart
  /// ApiResponseModel<List<User>, User> result = await getDataByApiResponse<List<User>,User>(
  /// endpoint: 'api/Controller/GetUsers',
  /// query: '?type=customer',
  /// parseModel: User(),
  /// headers: {'Content-type':'application/json'},
  /// apiResponse: ApiResponseModel(),
  /// timeoutDuration: DurationTypes.sixteenSeconds,
  /// );
  /// ```
  Future<ApiResponse<TReturn, TModel>> getDataByApiResponse<TReturn, TModel>({
    required String endpoint,
    TModel? parseModel,
    String? query,
    Map<String, String>? headers,
    ApiResponse<TReturn, TModel>? apiResponse,
    DurationTypes? timeoutDuration,
  });

  ///Use for get data on API. It returns response data like json String .
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///And also you can use `header`
  ///
  ///Example:
  ///
  /// ```dart
  /// DataResult<String> result = await getByResponseJson(
  /// endpoint: 'api/Controller/GetUsers',
  /// query: '?type=customer',
  /// headers: {'Content-type':'application/json'},
  /// timeoutDuration: DurationTypes.sixteenSeconds,
  /// );
  /// ```
  Future<DataResult<String>> getByResponseJson({
    required String endpoint,
    String? query,
    Map<String, String>? headers,
    DurationTypes? timeoutDuration,
  });

  /* ******************************************************************* */
  /* ************************** POST  METHODS ************************** */
  /* ******************************************************************* */

  ///Base post method of remote service.
  Future<DataResult> post({
    required String endpoint,
    Object? body,
    Map<String, String>? headers,
    DurationTypes? timeoutDuration,
  });

  ///Use for send data to API. It returns `SuccessResult` or `ErrorResult`.
  ///
  ///`TReturn:` is type of return. It can be [List] or [Model].
  ///
  /// Example:
  /// ```dart
  /// DataResult<List<User>> result = await postByData<List<User>,User>(...);
  /// ```
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///`[body]` : required for send data to API.`
  ///
  ///`[parseModel]` : required for parsing to response body.
  /// Your data's type should be [TModel].
  ///
  ///And also you can use and `header`
  ///
  ///Example:
  ///
  /// ```dart
  /// DataResult<List<User>> result = await postByData<List<User>,User>(
  /// parseModel: User(),
  /// endpoint: 'api/Controller/AddUser',
  /// body: {'userId':1,'name':'tester'},
  /// headers: {'Content-type':'application/json'},
  /// isJsonEncode = false,
  /// timeoutDuration: DurationTypes.sixteenSeconds,
  /// );
  /// ```
  Future<DataResult<TReturn>> postByData<TReturn, TParse>({
    required String endpoint,
    required Object body,
    bool isJsonEncode = true,
    required TParse parseModel,
    Map<String, String>? headers,
    DurationTypes? timeoutDuration,
  });

  ///Use for send data to API. It returns `SuccessResult` or `ErrorResult`.
  ///
  ///`TReturn:` is type of return. It can be [List] or [Model].
  ///
  /// Example:
  /// ```dart
  /// ApiResponseModel<List<User>, User> result = await postByResponseData<List<User>,User>(...);
  /// ```
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///`[body]` : required for send data to API.`
  ///
  ///`[parseModel]` : required for parsing to response body.
  /// Your data's type should be [TModel].
  ///
  ///And also you can use `header`
  ///
  ///Example:
  ///
  /// ```dart
  /// ApiResponseModel<List<User>, User> result = await postByResponseData<List<User>,User>(
  /// parseModel: User(),
  /// apiResponse: ApiResponseModel(),
  /// endpoint: 'api/Controller/AddUser',
  /// body: {'userId':1,'name':'tester'},
  /// headers: {'Content-type':'application/json'},
  /// isJsonEncode = false,
  /// timeoutDuration: DurationTypes.sixteenSeconds,
  /// );
  /// ```
  Future<ApiResponse<TReturn, TParse>> postByResponseData<TReturn, TParse>({
    required String endpoint,
    required Object body,
    bool isJsonEncode = true,
    required TParse parseModel,
    Map<String, String>? headers,
    ApiResponse<TReturn, TParse>? apiResponse,
    DurationTypes? timeoutDuration,
  });

  ///Use for send data to API. It returns `SuccessDataResult` or `ErrorDataResult`.
  ///
  ///The model includes response body.
  ///
  ///`[endpoint]` : required for access to service methods.
  ///
  ///`[body]` : required for send data to API.
  ///
  ///And also you can use `header`
  ///
  ///Example:
  ///
  /// ```dart
  /// DataResult<String> result = await postByResponseJson(
  /// endpoint: 'api/Controller/AddUser',
  /// body: {'userId':1,'name':'tester'},
  /// headers: {'Content-type':'application/json'},
  /// isJsonEncode = false,
  /// timeoutDuration: DurationTypes.sixteenSeconds,
  /// );
  /// ```
  Future<DataResult<String>> postByResponseJson({
    required String endpoint,
    required Object body,
    bool isJsonEncode = true,
    Map<String, String>? headers,
    DurationTypes? timeoutDuration,
  });
}
