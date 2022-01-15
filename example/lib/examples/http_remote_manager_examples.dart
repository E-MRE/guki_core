// ignore_for_file: avoid_print

import 'package:guki_core/guki_core.dart';

class HttpRemoteManagerExamples {
  final _remoteService = HttpRemoteDataManager.getInstance(
    baseUrl: 'https://jsonplaceholder.typicode.com/',
    timeout: DurationTypes.thirtytwoSeconds,
    header: {'Content-type': 'application/json'},
  )
    ..addBearerTokenToHeader('ADD_YOUR_TOKEN')
    ..setTimeout(DurationTypes.sixteenSeconds)
    ..setHeader({'Content-type': 'application/json'});

  Future<void> getData(int id) async {
    //TReturn means: this method will return for example Todo class.
    //TModel means: Parse response data like TModel type for example Todo class.
    var result = await _remoteService.getData<Todo, Todo>(
      endpoint: 'todos/$id',
      parseModel: Todo(),
    );

    //End this methods request with http and convert response json like Todo class.
    // If all operations succes it returns [SuccessDataResult] and data type Todo.

    if (result.success) {
      print(result.data?.title);
      print(result.toJson());
    } else {
      print(result.message);
    }
  }

  Future<void> getAllTodosByApiResponse(int id) async {
    //That operation gets Todo list inside of [ApiResponseModel]
    var result = await _remoteService.getDataByApiResponse<List<Todo>, Todo>(
      endpoint: 'todos/$id',
      parseModel: Todo(),
      apiResponse: MyApiResponseModel(),
    );

    if (result.statusCode == 0 && result.success == true) {
      result.data?.map((item) => print(item.title));
      print(result.toJson());
    } else {
      print(result.message);
    }
  }

  Future<void> postData(Todo todo) async {
    //That operation send data using [POST] method and returns [Todo] class
    var result = await _remoteService.postByData<Todo, Todo>(
      endpoint: '/posts',
      body: todo,
      parseModel: Todo(),
      isJsonEncode: true,
    );

    if (result.success) {
      print(result.toJson());
    } else {
      print(result.message);
    }
  }

  Future<void> postDataByApiResponse(Todo todo) async {
    //That operation send data using [POST] method and returns [ApiResponse] extended class
    var result = await _remoteService.postByResponseData<Todo, Todo>(
      endpoint: '/posts',
      body: todo,
      parseModel: Todo(),
      isJsonEncode: true,
      apiResponse: MyApiResponseModel(),
    );

    if ((result.success ?? false) && (result.statusCode ?? -1) == 0) {
      print(result.toJson());
    } else {
      print(result.message);
    }
  }
}

// implement EntityModel to your class if you want to parse automatically.
class Todo implements EntityModel<Todo> {
  int? userId;
  int? id;
  bool completed;
  String? title;
  String? body;

  Todo({
    this.userId,
    this.id,
    this.completed = false,
    this.title,
    this.body,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
      completed: json['completed'],
    );
  }

  @override
  Todo fromJson(Map<String, dynamic> json) => Todo.fromJson(json);

  @override
  Map<String, dynamic>? toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}

// You can create your ApiResponseModel and use it.
class MyApiResponseModel<TData, TParse> implements ApiResponse<TData, TParse> {
  @override
  TData? data;

  @override
  String? message;

  @override
  TParse? parseModel;

  @override
  int? statusCode;

  @override
  bool? success;

  MyApiResponseModel({
    this.data,
    this.message,
    this.parseModel,
    this.statusCode,
    this.success,
  });

  @override
  ApiResponse fromJson(Map<String, dynamic> json, {TParse? parseModel}) {
    // ignore: todo
    //TODO: parse your json data
    return ApiResponseModel();
  }

  @override
  Map<String, dynamic> toJson() {
    // ignore: todo
    // TODO: implement toJson
    return {};
  }
}
