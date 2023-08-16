import 'package:freezed_annotation/freezed_annotation.dart';

import 'task_dto.dart';

part 'tasks_list_dto.g.dart';
part 'tasks_list_dto.freezed.dart';

@freezed
class TasksListDto with _$TasksListDto {
  const factory TasksListDto({
    required String status,
    required List<TaskDto> list,
    required int revision,
  }) = _TasksListDto;

  factory TasksListDto.fromJson(Map<String, dynamic> json) =>
      _$TasksListDtoFromJson(json);
}
