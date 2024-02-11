import 'package:duty_allocation_system/helpers/helper_methods.dart';
import 'package:duty_allocation_system/providers/user_provider.dart';
import 'package:duty_allocation_system/views/screens/mainscreens/duty_allocation_screen.dart';
import 'package:duty_allocation_system/views/widgets/home_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.black87,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration:
                  const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 20,
                  ),
                ),
                Text(
                  userProvider.user == null ? '' : "${userProvider.user!.email}",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 12, bottom: 12),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      HomeOption(
                        onTap: () => Helpers.temporaryNavigator(
                            context, const DutyAllocationScreen()),
                        backgroundImage: const AssetImage('assets/images/duty.png'),
                        alignment: Alignment.centerLeft,
                        text: const Text(
                          'Create\nDuty',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        columnCrossAxisAlignment: CrossAxisAlignment.end,
                        backgroundColor: Colors.blueAccent,
                      ),
                      HomeOption(
                          onTap: () {},
                          backgroundImage: const AssetImage('assets/images/nurses.png'),
                          alignment: Alignment.centerRight,
                          text: const Text(
                            'Manage\nEmployees',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
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
                          backgroundImage: const AssetImage('assets/images/settings.png'),
                          alignment: Alignment.centerLeft,
                          text: const Text(
                            'Settings',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          columnCrossAxisAlignment: CrossAxisAlignment.end,
                          backgroundColor: Colors.purpleAccent),
                      HomeOption(
                        onTap: () {},
                        backgroundImage: const AssetImage('assets/images/me.png'),
                        alignment: Alignment.centerRight,
                        text: const Text(
                          'Profile',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
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
