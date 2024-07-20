import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:offers_hub/utilis/dataset.dart';

class BaseApi {
  @protected
  Future<DataState> getStateOf({required Future Function() request}) async {
    try {
      final List<Map> apiData = await request();
      return await DataSucceed(data: apiData);
    } on DioException catch (e) {
      return DataFailed(error: e);
    }
  }
}
