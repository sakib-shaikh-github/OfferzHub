// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class RewardState {}

class RewardStateLoading extends RewardState {}

class RewardStateSucceed extends RewardState {
  final List? data;
  RewardStateSucceed({
    required this.data,
  });
}

class RewardStateFailed extends RewardState {
  final String errMsg;
  RewardStateFailed({
    required this.errMsg,
  });
}
