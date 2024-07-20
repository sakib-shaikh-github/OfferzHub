import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:offers_hub/features/nearbuy_offers/presentation/nearbuy_offers_page.dart';
import 'package:offers_hub/features/share_offers/presentation/offer_page.dart';
import 'package:offers_hub/features/share_reward/presentation/ui/profile_page.dart';
import 'package:offers_hub/features/share_reward/presentation/ui/rewards_view.dart';
import 'package:toast/toast.dart';

ValueNotifier<int> currentScreen = ValueNotifier<int>(0);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

class _HomePageState extends State<HomePage> {
  final List<Widget> ListOfScreens = [
    OffersPage(
      offerDrawerKey: drawerKey,
    ),
    new RewardsPage(rewardDrawerKey: drawerKey),
    new NearbuyOPage()
  ];

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: drawerKey,
      body: ListOfScreens[currentScreen.value],
      drawer: Drawer(child: ProfilePage()),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: GNav(
                selectedIndex: 0,
                backgroundColor: Colors.black87,
                color: Colors.white,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                padding: const EdgeInsets.all(15),
                tabs: [
                  GButton(
                    icon: Icons.diversity_1_rounded,
                    text: ' share offers',
                    onPressed: () {
                      setState(() {
                        currentScreen.value = 0;
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.discount_rounded,
                    text: ' share rewards',
                    onPressed: () {
                      setState(() {
                        currentScreen.value = 1;
                      });
                    },
                  ),
                  GButton(
                    icon: Icons.my_location_rounded,
                    text: ' offers nearbuy',
                    onPressed: () {
                      setState(() {
                        currentScreen.value = 2;
                      });
                    },
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
