import 'package:offers_hub/features/share_offers/domain/offers_upload.dart';
import 'package:offers_hub/utilis/constants.dart';
import 'package:offers_hub/utilis/users_profile.dart';

final List<Map> listOfOffers = [];
int offerUploadCount = 0;

class OffersApi {
  //getcompanyUploadedOffers
  Future<void> getOffers() async {
    await firestore
        .collection('offers')
        .doc('companyUploaded')
        .get()
        .then((value) {
      (value.data()?.forEach((key, value) {
        listOfOffers.add({key: value});
      }));
    });
    await firestore
        .collection('offers')
        .doc('usersUploaded')
        .get()
        .then((value) {
      (value.data()?.forEach((key, value) {
        listOfOffers.add({key: value});
      }));
    });
  }

  Future<void> getUserUploadedOffers() async {
    await firestore
        .collection('offers')
        .doc('companyUploaded')
        .get()
        .then((value) {
      (value.data()?.forEach((key, value) {
        listOfOffers.add({key: value});
      }));
    });
  }

  Future<void> userUploadsOffer(OffersUpload offer) async {
    offerUploadCount++;
    await firestore.collection('offers').doc('usersUploaded').update({
      '${auth.currentUser?.displayName}reward$offerUploadCount': [
        offer.brand,
        offer.stmt,
        offer.offerLink,
        auth.currentUser?.uid,
        auth.currentUser?.displayName,
        '0'
      ]
    });
  }

  Future<void> uploadOffers(String offer) async {
    firestore.collection('userOfferRequests').doc('requests').update({
      'userOfferInfo': [
        userInfo[0],
        userInfo[1],
        {'offer': offer}
      ]
    });
  }
}
