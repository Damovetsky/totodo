import 'package:freezed_annotation/freezed_annotation.dart';

import 'task_dto.dart';

part 'task_response_dto.g.dart';
part 'task_response_dto.freezed.dart';

@freezed
class TaskResponseDto with _$TaskResponseDto {
  const factory TaskResponseDto({
    required String status,
    @JsonKey(name: 'element') required TaskDto taskDto,
    required int revision,
  }) = _TaskResponseDto;

  factory TaskResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseDtoFromJson(json);
}
