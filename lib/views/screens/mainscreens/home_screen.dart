import 'package:cached_network_image/cached_network_image.dart';
import 'package:duty_allocation_system/helpers/helper_methods.dart';
import 'package:duty_allocation_system/providers/user_provider.dart';
import 'package:duty_allocation_system/utils/colors/pallete.dart';
import 'package:duty_allocation_system/views/screens/employee_manager/employee_manager.dart';
import 'package:duty_allocation_system/views/screens/mainscreens/duty_allocation_screen.dart';
import 'package:duty_allocation_system/views/screens/profile/profile_screen.dart';
import 'package:duty_allocation_system/views/widgets/home_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../utils/asset_utils/assets_util.dart';
import '../../widgets/my_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return Scaffold(
          drawer: MyDrawer(user: user,),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Pallete.primaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  user == null ? '' : "${user.displayName}",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 16,
                ),
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: user!.photoURL ?? 'https://cdn-icons-png.flaticon.com/128/3177/3177440.png',
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Skeletonizer(
                      enabled: true,
                      child: SizedBox(
                        height: 45,
                        child: Image.asset(Assets.blueProfileImage),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 24, bottom: 24),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      HomeOption(
                        onTap: () => Helpers.temporaryNavigator(
                            context, const DutyAllocationScreen()
                        ),
                        backgroundImage: AssetImage(Assets.duty),
                        alignment: Alignment.centerLeft,
                        text: Text(
                          'Create\nDuty',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.sizeOf(context).height > 400 ? 20 : 14,
                              fontWeight: FontWeight.bold),
                        ),
                        columnCrossAxisAlignment: CrossAxisAlignment.end,
                        backgroundColor: Colors.blueAccent,
                      ),
                      HomeOption(
                          onTap: () {
                            Helpers.temporaryNavigator(context, const EmployeeManager());
                          },
                          backgroundImage: AssetImage(Assets.employees),
                          alignment: Alignment.centerRight,
                          text: Text(
                            'Manage\nEmployees',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.sizeOf(context).height > 400 ? 20 : 14,
                                fontWeight: FontWeight.bold),
                          ),
                          columnCrossAxisAlignment: CrossAxisAlignment.start,
                          backgroundColor: Colors.greenAccent),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      HomeOption(
                          onTap: () {},
                          backgroundImage: AssetImage(Assets.settings),
                          alignment: Alignment.centerLeft,
                          text: Text(
                            'Settings',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: MediaQuery.sizeOf(context).height > 400 ? 20 : 14,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          columnCrossAxisAlignment: CrossAxisAlignment.end,
                          backgroundColor: Colors.purpleAccent),
                      HomeOption(
                        onTap: () {
                          Helpers.temporaryNavigator(context, const ProfileScreen());
                        },
                        backgroundImage: AssetImage(Assets.homeProfile),
                        alignment: Alignment.centerRight,
                        text: Text(
                          'Profile',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.sizeOf(context).height > 400 ? 20 : 14,
                              fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.redAccent,
                        columnCrossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
