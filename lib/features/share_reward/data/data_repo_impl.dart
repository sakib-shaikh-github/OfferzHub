import 'package:offers_hub/features/share_reward/data/rewards/base_api.dart';
import 'package:offers_hub/features/share_reward/data/rewards/get_reward_api.dart';
import 'package:offers_hub/features/share_reward/domain/domain_repo_impl.dart';
import 'package:offers_hub/utilis/dataset.dart';

class DataRepoImpl extends BaseApi implements DomainApiRepoImpl {
  RewardApi rewardApi = RewardApi();
  @override
  Future<DataState> getRewardsFromApi() async {
    return await getStateOf(request: () async => rewardApi.getRewards());
  }
}
