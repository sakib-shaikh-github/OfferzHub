// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:offers_hub/config/screen_sizes.dart';
import 'package:offers_hub/features/authentication/auth_ui.dart';
import 'package:offers_hub/features/leftUIs/chat_window.dart';
import 'package:offers_hub/features/share_reward/data/rewards/get_reward_api.dart';
import 'package:offers_hub/features/share_reward/data/rewards/upload_reward.dart';
import 'package:offers_hub/features/share_reward/domain/reward_model.dart';
import 'package:offers_hub/features/share_reward/presentation/bloc/reward_bloc.dart';
import 'package:offers_hub/features/share_reward/presentation/bloc/reward_state.dart';
import 'package:offers_hub/utilis/constants.dart';
import 'package:offers_hub/utilis/search_delegate.dart';
import 'package:offers_hub/utilis/snackbar.dart';
import 'package:offers_hub/utilis/text_resizer.dart';

import 'package:offers_hub/utilis/toast.dart';

class RewardsPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> rewardDrawerKey;
  const RewardsPage({
    Key? key,
    required this.rewardDrawerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
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
                            rewardDrawerKey.currentState!.openDrawer();
                          },
                          icon: Icon(Icons.menu_rounded)),
                    ),
                  ),
                  Flexible(child: RewardsSearchBar()),
                ],
              ),

              //rewards
              RewardsCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class RewardsCard extends StatelessWidget {
  const RewardsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardCubit, RewardState>(
      builder: (context, state) {
        if (state is RewardStateSucceed) {
          return Flexible(
            child: Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final rewardModel =
                        RewardModel.fromApi(listOfRewards[index]);
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            otherName: rewardModel.uploader,
                          ),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 80,
                          width: 50,
                          child: Card(
                            elevation: 10,
                            shadowColor: Color.fromARGB(255, 163, 122, 252),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: sizes(context).height / 8,
                                  width: sizes(context).width / 4,
                                  child: ClipRRect(
                                    child: Image.network(
                                      rewardModel.imgRef,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    isThreeLine: true,
                                    title: Text(
                                        textResizer(rewardModel.brand, 12),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold)),
                                    subtitle: Text("${rewardModel.category}"),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("save \$${rewardModel.amount}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        Card(
                                          elevation: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(rewardModel.uploader,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200)),
                                                Icon(
                                                  Icons.verified_rounded,
                                                  color: Colors.blue,
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: listOfRewards.length,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.all(2),
                                content: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: UploadRewardDialog(),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                )
              ],
            ),
          );
        } else if (state is RewardStateFailed) {
          return Center(child: Text(state.errMsg));
        } else if (state is RewardStateLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(
              child: Text('Something went wrong. Try again later..😕'));
        }
      },
    );
  }
}

class RewardsSearchBar extends StatefulWidget {
  const RewardsSearchBar({super.key});

  @override
  State<RewardsSearchBar> createState() => _RewardsSearchBarState();
}

class _RewardsSearchBarState extends State<RewardsSearchBar> {
  static final TextEditingController searchBarTextEditingController =
      TextEditingController();

  static final _searchBarFocusNode = FocusNode();
  static ValueNotifier<bool> isTFActive = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    _searchBarFocusNode.addListener(onFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              final List<String> listSearchRewards = [];
              for (var reward in listOfRewards) {
                final brandname = RewardModel.fromApi(reward).brand;
                listSearchRewards.add(brandname);
              }

              CustomSearchDelegate(data: listSearchRewards);
            },
            child: TextFormField(
              controller: searchBarTextEditingController,
              focusNode: _searchBarFocusNode,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  prefixIcon: Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isTFActive,
            builder: (context, value, child) {
              return !value
                  ? Positioned(
                      top: 15,
                      left: 40,
                      child: Row(
                        children: [
                          Text('search for '),
                          AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                            TyperAnimatedText('Nike'),
                            TyperAnimatedText('Skull Candy'),
                            TyperAnimatedText('RedBus'),
                            TyperAnimatedText('rewards you want..'),
                          ])
                        ],
                      ))
                  : Container();
            },
          )
        ],
      ),
    );
  }

  void onFocusChange() {
    if (_searchBarFocusNode.hasFocus ||
        searchBarTextEditingController.text.isNotEmpty) {
      isTFActive.value = true;
    } else {
      isTFActive.value = false;
    }
  }
}

class UploadRewardDialog extends StatefulWidget {
  const UploadRewardDialog({super.key});

  @override
  State<UploadRewardDialog> createState() => _UploadRewardDialogState();
}

class _UploadRewardDialogState extends State<UploadRewardDialog> {
  final listOfTFs = List.generate(2, (index) => TextEditingController());
  final isTFsEmpty = List.generate(2, (index) => true);
  final listOfTFsText = [
    'Brand name*',
    'Reward amount*',
  ];

  static String selectedItem = 'travel'; // Initially selected item

  static List<String> items = [
    'travel',
    'games',
    'food',
    'clothes',
    'giftCard',
    'other'
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: sizes(context).height / 4,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final currentTF = listOfTFs[index];
              currentIndex = index;
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  controller: currentTF,
                  onChanged: (value) => !currentTF.text.isEmpty
                      ? isTFsEmpty[index] = false
                      : null,
                  keyboardType: index == 1 ? TextInputType.number : null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: (listOfTFsText[index]),
                      hintMaxLines: 2),
                ),
              );
            },
            itemCount: 2,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Category',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              borderRadius: BorderRadius.circular(20),
              value: selectedItem, // Currently selected value
              items: items
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedItem = newValue!; // Update selected item
                });
              },
            ),
          ],
        ),
        ElevatedButton(
            onPressed: () async {
              if (!isGuest) {
                !checkifTFEmpty()
                    ? {
                        await UploadRewardApi().uploadReward(RewardModel(
                            brand: listOfTFs[0].text,
                            amount: int.parse(listOfTFs[1].text),
                            uploader: auth.currentUser?.displayName ?? 'user',
                            category: selectedItem,
                            uid: auth.currentUser?.uid ?? 'user',
                            imgRef:
                                'https://firebasestorage.googleapis.com/v0/b/offershub-5e52e.appspot.com/o/rewardsDefaultImgs%2Fdefault%2Fdiscount.jpg?alt=media&token=cc69c013-810a-467a-a0dc-cc49e75f3f7f')),
                        BlocProvider.of<RewardCubit>(context).getRewards(),
                      }
                    : {
                        showToast('Enter valid inputs..'),
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
