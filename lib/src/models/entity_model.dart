///Every models of entity should implements `[EntityModel]` for API response.
///API services constraints generic methods with `[EntityModel]`.
///
///Example:
///```dart
///class UserModel implements EntityModel<UserModel>
/// ```
abstract class EntityModel<TModel> {
  Map<String, dynamic>? toJson();
  TModel fromJson(Map<String, dynamic> json);
}
