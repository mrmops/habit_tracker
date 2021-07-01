import 'package:moor_flutter/moor_flutter.dart';

class DatesTypeConverter extends TypeConverter<List<DateTime>, String> {
  @override
  List<DateTime>? mapToDart(String? fromDb) {
    return fromDb
        ?.split(',')
        .where((element) => element.isNotEmpty)
        .map((e) => DateTime.parse(e))
        .toList() ??
        List.empty();
  }

  @override
  String? mapToSql(List<DateTime>? value) {
    return value?.map((e) => e.toString()).join(',') ?? '';
  }
}