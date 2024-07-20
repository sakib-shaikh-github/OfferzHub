import 'package:dio/dio.dart';

abstract class DataState<T> {
  final List<Map>? data;
  final DioException? error;

  const DataState({this.data, this.error});
}

class DataSucceed<List> extends DataState {
  const DataSucceed({super.data});
}

class DataFailed<T> extends DataState {
  DataFailed({super.error});
}
