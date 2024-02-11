import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class MyDrawer extends StatelessWidget {
  String? name;
  String? email;
  String? profilePic;

  MyDrawer({super.key, this.name, this.email, this.profilePic});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Container(
        color: Colors.black,
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.25,
              child: DrawerHeader(
                decoration: const BoxDecoration(color:Colors.white),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300, // Light color for top shadow
                            offset: const Offset(-5, -5),
                            blurRadius: 15,
                          ),
                          BoxShadow(
                            color: Colors.grey.shade500, // Dark color for bottom shadow
                            offset: const Offset(5, 5),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile.png',
                        ),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            email.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
                tileColor: Colors.white,
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                title: const Text(
                  'All Orders',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                trailing: const Icon(
                    Icons.navigate_next
                ),
                onTap: () {

                }
            ),
            ListTile(
                tileColor: Colors.white,
                leading: const Icon(
                  Icons.money,
                  color: Colors.black,
                ),
                title: const Text(
                  'Billing',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                trailing: const Icon(
                    Icons.navigate_next
                ),
                onTap: () {

                }
            ),
            ListTile(
                tileColor: Colors.white,
                leading: const Icon(
                  Icons.store,
                  color: Colors.black,
                ),
                title: const Text(
                  'My Stores',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                trailing: const Icon(
                    Icons.navigate_next
                ),
                onTap: () {

                }
            ),
            ListTile(
                tileColor: Colors.white,
                leading: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                trailing: const Icon(
                    Icons.navigate_next
                ),
                onTap: () {

                }
            ),
            ListTile(
                tileColor: Colors.white,
                leading: const Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                trailing: const Icon(
                    Icons.navigate_next
                ),
                onTap: () {

                }
            ),

            const SizedBox(
              height: 30,
            ),
            //SignOut Button
            GestureDetector(
                onTap: ()
                {

                },
                child: CustomButton(
                    neumophismPrimaryColor: CupertinoColors.white,
                    buttonText: 'SignOut',
                    buttonTextColor: Colors.white,
                    buttonIcon: Icons.logout_sharp,
                    iconColor: Colors.white,
                    buttonColor: Colors.redAccent,
                    onTap: () {  },
                )
            ),

            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
