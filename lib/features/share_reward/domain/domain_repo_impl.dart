import 'package:offers_hub/utilis/dataset.dart';

abstract class DomainApiRepoImpl {
  Future<DataState> getRewardsFromApi();
}
