import 'dart:async';
import 'package:offers_hub/features/share_reward/domain/reward_model.dart';
import 'package:offers_hub/utilis/constants.dart';
import 'package:offers_hub/utilis/snackbar.dart';

int userUploadCount = gloabal_prefs.getInt('userUploadCount') ?? 0;

String fireStoreAuoId() {
  return firestore.collection('userUploadedRewards').doc().id;
}

final userFirestoreId = gloabal_prefs.getString('firestoreId');

class UploadRewardApi {
  Future uploadReward(RewardModel model) async {
    userUploadCount++;
    if (userUploadCount == 1) {
      await firestore
          .collection('userUploadedRewards')
          .doc(userFirestoreId)
          .set({
        'reward$userUploadCount': {
          'brand': model.brand,
          'amount': model.amount,
          'uploader': model.uploader,
          'category': model.category,
          'imgRef': model.imgRef
        }
      }).catchError((e) {
        print(e);
        AppSnackBar.showSnackBar('Error uploading.', colorGreen: false);
      });
    } else {
      await firestore
          .collection('userUploadedRewards')
          .doc(userFirestoreId)
          .update({
        'reward$userUploadCount': {
          'brand': model.brand,
          'amount': model.amount,
          'uploader': model.uploader,
          'category': model.category,
          'imgRef': model.imgRef
        }
      }).catchError((e) {
        print(e);
        AppSnackBar.showSnackBar('Error uploading.', colorGreen: false);
      });
    }
  }
}
