// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:offers_hub/features/share_reward/domain/domain_repo_impl.dart';
import 'package:offers_hub/features/share_reward/presentation/bloc/reward_state.dart';
import 'package:offers_hub/utilis/dataset.dart';

class RewardCubit extends Cubit<RewardState> {
  RewardCubit(
    this.domainApiRepoImpl,
  ) : super(RewardStateLoading());

  final DomainApiRepoImpl domainApiRepoImpl;

  Future getRewards() async {
    final dataState = await domainApiRepoImpl.getRewardsFromApi();

    if (dataState is DataSucceed) {
      emit(RewardStateSucceed(data: dataState.data));
    } else {
      emit(RewardStateFailed(errMsg: dataState.error!.message.toString()));
    }
  }
}
