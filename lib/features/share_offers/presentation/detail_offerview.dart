// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:offers_hub/features/leftUIs/chat_window.dart';
import 'package:offers_hub/features/share_offers/domain/offers_model.dart';

class DetailedOfferView extends StatelessWidget {
  final OffersModel offersModel;
  final int i;
  const DetailedOfferView({
    Key? key,
    required this.offersModel,
    required this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 20,
            stretch: true,
            floating: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://www.shareicon.net/data/512x512/2015/11/01/665107_people_512x512.png',
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, i) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(offersModel.brandName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  Text(offersModel.offerStmt,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500)),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(offersModel.uploader,
                              softWrap: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w200,
                                  )),
                          Icon(
                            Icons.verified_rounded,
                            color: Colors.blue,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                  Text('  ${offersModel.uploaderLocation} miles away.'),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_2_rounded,
                            color: Colors.blue,
                          ),
                          Icon(Icons.person_2_rounded),
                        ],
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            otherName: offersModel.uploader,
                          ),
                        ));
                      },
                      child: Text('Chat'))
                ],
              ),
            );
          }, childCount: 1))
        ],
      ),
    );
  }
}

List listOfMiles = [1.5, 3, 5, 1.6, 6, 1.8, 7, 4, 2.8, 9.5];
