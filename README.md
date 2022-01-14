<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package. 
-->

Core layer usable in every Flutter project.

## Features

- Results: It usable for return operation result, message and/or data.
- DisplayMessages: Use them for display mesage with SnackBar or AlertDialog.

## Getting started

For import that library, open pubspec.yaml document on your project root and add theese commands below to the `dependencies`

```dart
guki_core:
    git:
        url: https://github.com/E-MRE/guki_core
        ref: #choose a tag you want to use
```

## Usage

Include short and useful examples for package users. Add longer examples
to `/example` folder. 

v0.0.3
Post Example (sends body and API returns json ):
/* -- More Examples in the RemoteDataService  -- */

```dart
  DataResult<String> result = await postByResponseJson(
  endpoint: 'api/Controller/AddUser',
  body: {'userId':1,'name':'tester'},
  headers: {'Content-type':'application/json'},
  isJsonEncode = false,
  timeoutDuration: DurationTypes.sixteenSeconds,
  );
```

Get Example (get data by endpoint and query, API returns response model):

```dart
 ApiResponseModel<List<User>, User> result = await                     getDataByApiResponse<List<User>,User>(
 endpoint: 'api/Controller/GetUsers',
 query: '?type=customer',
 parseModel: User(),
 headers: {'Content-type':'application/json'},
 apiResponse: ApiResponseModel(),
 timeoutDuration: DurationTypes.sixteenSeconds,
 );
```

```dart
    convertApiResponse<TReturn, TParse>(
      jsonBody: result.data?.body,
      apiResponse: apiResponse ?? ApiResponseModel<TReturn, TParse>(),
      parseModel: parseModel,
    );
```

```dart
double containerHeight = Sizes.normal.rawValue();
```


```dart
Duration futureDelayed = DurationTypes.eightSeconds.rawValue();
```

v0.0.2:

```dart
DisplaySnackBar(context).errorMessage('Error message here');
DisplayAlertDialog(context).successAlert('Message is success');
```

v0.0.1:

```dart
DataResult<int> addOneIfNotNull(int? value) {
    return value != null
        ? SuccessDataResult(data: value + 1)
        : ErrorDataResult(message: 'value is null');
  }
```
