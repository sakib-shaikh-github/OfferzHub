// ignore_for_file: public_member_api_docs, sort_constructors_first
class RewardModel {
  final String brand;
  final int amount;
  final String uploader;
  final String category;
  final String imgRef;
  final String? uid;
  RewardModel({
    required this.brand,
    required this.amount,
    required this.uploader,
    required this.category,
    required this.imgRef,
    this.uid,
  });

  factory RewardModel.fromApi(Map apiData) {
    final brand = apiData['brand'] as String;
    final amount = apiData['amount'] as int;
    final uploader = apiData['uploader'] as String;
    final category = apiData['category'] as String;

    final img = apiData['imgRef'];
    return RewardModel(
        brand: brand,
        amount: amount,
        uploader: uploader,
        category: category,
        imgRef: img);
  }
}
