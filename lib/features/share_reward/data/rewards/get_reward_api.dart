import 'package:offers_hub/utilis/constants.dart';

final List<Map> listOfRewards = [];
final List<String> listOfImages = [];

class RewardApi {
  Future<List<Map>> getRewards() async {
    listOfRewards.clear();
    listOfImages.clear();
    await firestore.collection('userUploadedRewards').get().then((value) {
      value.docs.forEach((element) {
        (element.data().forEach((key, value) async {
          listOfRewards.add(value);
        }));
      });
    });

    await firestore.collection('companyUploadedRewards').get().then((value) {
      value.docs.forEach((element) {
        (element.data().forEach((key, value) async {
          listOfRewards.add(value);
        }));
      });
    });

    return listOfRewards;
  }
}
