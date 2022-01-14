import 'entity_model.dart';

class EmptyEntityModel implements EntityModel<EmptyEntityModel> {
  EmptyEntityModel();

  factory EmptyEntityModel.fromJson(Map<String, dynamic> json) =>
      EmptyEntityModel();

  @override
  EmptyEntityModel fromJson(Map<String, dynamic> json) => EmptyEntityModel();

  @override
  Map<String, dynamic>? toJson() => {};
}
