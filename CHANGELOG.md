## 0.0.4

- Locale Caching Added.
    - Use HiveCachingManager for save data to the cache.

- HiveRegistrationModel Created.
    - For register more Hive adapters.

## 0.0.3

- RemoteDataService created for API requests.
    - HttpRemoteDataManager created.
    - ApiResponse & ApiResponseModel created. Users can parse their json using ApiResponse. 
    - EntityModel created for parse json to model simply.
    - Also JsonConverter created for parse json.
    - HttpStatusCodeController created. It returns Result with message.
    - Exceptions created like ConnectionException, ServerException or SocketException
    - ApiConstants created. It includes url's and messages.

- DurationTypes enum created. It includes some Durations.
- Sizes enum created. It returns some double values.

## 0.0.2

- Display Messages added. Thesee utilities:
    - AlertDialog
    - SnackBar

## 0.0.1

- Result & DataResult utilities added.
