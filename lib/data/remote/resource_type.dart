import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource_type.freezed.dart';

@freezed
class ResourceType<T> with _$ResourceType<T>{

  const factory ResourceType.success(T value) = Success<T>;
  const factory ResourceType.error([String? message]) = Error<T>;
  const factory ResourceType.loading() = Loading<T>;
}