// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:offers_hub/features/leftUIs/chat_window.dart';
import 'package:offers_hub/utilis/url_launcher_func.dart';

import 'package:offers_hub/config/screen_sizes.dart';
import 'package:offers_hub/features/authentication/auth_ui.dart';
import 'package:offers_hub/features/share_offers/data/offers_api.dart';
import 'package:offers_hub/features/share_offers/domain/offers_upload.dart';
import 'package:offers_hub/features/share_reward/presentation/ui/rewards_view.dart';
import 'package:offers_hub/utilis/snackbar.dart';
import 'package:offers_hub/utilis/toast.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({
    Key? key,
    required this.offerDrawerKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> offerDrawerKey;

  @override
  State<OffersPage> createState() => _OffersPageState();
}

final offerObj = OffersApi();

class _OffersPageState extends State<OffersPage> {
  @override
  void initState() {
    super.initState();
    listOfOffers.clear();
  }

  changingState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: offerObj.getOffers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CircleAvatar(
                                radius: sizes(context).width / 15,
                                child: IconButton(
                                    onPressed: () {
                                      widget.offerDrawerKey.currentState!
                                          .openDrawer();
                                    },
                                    icon: Icon(Icons.menu_rounded)),
                              ),
                            ),
                            Flexible(child: RewardsSearchBar()),
                          ],
                        ),
                        Text('*offers is being shown around your location'),
                        //offers
                        Flexible(
                            child: ListView.builder(
                          itemBuilder: (context, index) {
                            final Map offerModel = listOfOffers[index];
                            final brand = offerModel.values.first[0];
                            final offerStmt = offerModel.values.first[1];
                            final String offerUrl = offerModel.values.first[2];
                            final uploader = offerModel.values.first[4];
                            final uploaderLocation = offerModel.values.first[5];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12),
                              child: Card(
                                elevation: 10,
                                shadowColor: Color.fromARGB(255, 163, 122, 252),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: sizes(context).height / 4,
                                      width: sizes(context).width / 4,
                                      child: ClipRRect(
                                        child: Image.network(
                                          'https://www.shareicon.net/data/512x512/2015/11/01/665107_people_512x512.png',
                                          fit: BoxFit.contain,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Text(brand,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              offerStmt,
                                              softWrap: true,
                                            ),
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.person_2_rounded,
                                                      color: Colors.blue,
                                                    ),
                                                    Icon(
                                                        Icons.person_2_rounded),
                                                  ],
                                                )),
                                            Card(
                                              elevation: 5,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(uploader,
                                                        softWrap: true,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200,
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
                                            Text(
                                                '*The offer uploader is $uploaderLocation miles away',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w200,
                                                    )),
                                            Row(
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      launchUrlFunc(offerUrl);
                                                      // offerObj.uploadOffers(brand);
                                                      // showToast(
                                                      //     'request sent successfully');
                                                    },
                                                    child: Text('check offer')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatScreen(
                                                          otherName: uploader,
                                                        ),
                                                      ));
                                                    },
                                                    child: Text('Chat'))
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: listOfOffers.length,
                        )),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 20,
                      child: FloatingActionButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.all(2),
                                content: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: UploadOfferDialog(
                                    cS: changingState,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Icon(Icons.add),
                      )),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class UploadOfferDialog extends StatefulWidget {
  final Function cS;
  const UploadOfferDialog({
    Key? key,
    required this.cS,
  }) : super(key: key);

  @override
  State<UploadOfferDialog> createState() => _UploadOfferDialogState();
}

class _UploadOfferDialogState extends State<UploadOfferDialog> {
  final listOfTFs = List.generate(3, (index) => TextEditingController());
  final isTFsEmpty = List.generate(3, (index) => true);
  final listOfTFsText = [
    'Brand*',
    'OfferStmt*',
    'Copy the offer url from browser and paste here*',
  ];

  // static String selectedItem = 'travel'; // Initially selected item

  // static List<String> items = [
  //   'travel',
  //   'games',
  //   'food',
  //   'clothes',
  //   'giftCard',
  //   'other'
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: sizes(context).height / 3,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final currentTF = listOfTFs[index];
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: currentTF,
                  onChanged: (value) => !currentTF.text.isEmpty
                      ? isTFsEmpty[index] = false
                      : null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: (listOfTFsText[index]),
                      hintMaxLines: 2),
                ),
              );
            },
            itemCount: 3,
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              if (!isGuest) {
                !checkifTFEmpty()
                    ? {
                        await OffersApi().userUploadsOffer(OffersUpload(
                            brand: listOfTFs[0].text,
                            stmt: listOfTFs[1].text,
                            offerLink: listOfTFs[2].text)),
                        widget.cS()
                      }
                    : {
                        showToast('Enter all/valid inputs..'),
                      };
              } else {
                AppSnackBar.showSnackBar('login to upload', colorGreen: false);
              }
            },
            child: Text('Upload'))
      ],
    );
  }

  bool checkifTFEmpty() => (isTFsEmpty.contains(true)) ? true : false;
}
