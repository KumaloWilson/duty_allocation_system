import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_x_universal/api_services/auth_methods/authorization_services.dart';
import 'package:platform_x_universal/helpers/shared_preferances_helper.dart';
import 'package:platform_x_universal/utils/asset_utils/assets_util.dart';
import 'package:platform_x_universal/views/screens/agent_module/agent_tabs/home/baskets/see_all_products.dart';
import 'package:platform_x_universal/views/screens/universal_screens/authorization_screens/auth_handler.dart';
import 'package:platform_x_universal/views/screens/universal_screens/usertype/select_user_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../helpers/genenal_helpers.dart';
import '../../utils/colors/pallete.dart';
import 'custom_button.dart';
import 'loading_widgets/custom_loader.dart';

class MyDrawer extends StatelessWidget {
  User? user;
  MyDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.32,
            child: DrawerHeader(
              decoration: const BoxDecoration(color:Colors.white),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.height * 0.18,
                    height: MediaQuery.of(context).size.height * 0.18,
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
                      child: CachedNetworkImage(
                        imageUrl: user!.photoURL ?? 'https://cdn-icons-png.flaticon.com/128/3177/3177440.png',
                        width: MediaQuery.of(context).size.height * 0.18,
                        height: MediaQuery.of(context).size.height * 0.18,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Skeletonizer(
                          enabled: true,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height*0.45,
                            child: Image.asset(Assets.blueProfileImage),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user!.displayName ?? 'username',
                          style: TextStyle(
                            fontSize: 16,
                            color: Pallete.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user!.email ?? 'example@email.com',
                          style: TextStyle(
                            fontSize: 12,
                            color: Pallete.primaryColor,
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
            leading: Icon(
              Icons.shopping_bag_outlined,
              color: Pallete.primaryColor,
            ),
            title: const Text(
              'Baskets'
            ),
            trailing: const Icon(
                Icons.navigate_next
            ),
            onTap: () => Helpers.temporaryNavigator(context, const SeeAllProducts(productType: 'basket'))
          ),

          ListTile(
            leading: Icon(
              Icons.category_outlined,
              color: Pallete.primaryColor,
            ),
            title: const Text(
                'Single Products'
            ),
            trailing: const Icon(
                Icons.navigate_next
            ),
              onTap: () => Helpers.temporaryNavigator(context, const SeeAllProducts(productType: 'simple'))
          ),


          ListTile(
            leading: Icon(
              Icons.shopping_cart_outlined,
              color: Pallete.primaryColor,
            ),
            title: const Text(
                'Orders'
            ),
            trailing: const Icon(
                Icons.navigate_next
            ),
            onTap: () {

            }
          ),


          ListTile(
            leading: Icon(
              Icons.people_alt_outlined,
              color: Pallete.primaryColor,
            ),
            title: const Text(
                'Customers'
            ),
            trailing: const Icon(
                Icons.navigate_next
            ),
            onTap: () {

            }
          ),


          ListTile(
            leading: Icon(
              Icons.history,
              color: Pallete.primaryColor,
            ),
            title: const Text(
                'History'
            ),
            trailing: const Icon(
              Icons.navigate_next
            ),
            onTap: () {

            }
          ),

          ListTile(
            leading: Icon(
              Icons.settings,
              color: Pallete.primaryColor,
            ),
            title: const Text(
                'Settings'
            ),
            trailing: const Icon(
                Icons.navigate_next
            ),
            onTap: () async{
              await SharedPreferencesHelper.clearCachedUserRole();
              await AuthServices.signOut();

              Helpers.permanentNavigator(context, RoleSelectionScreen());
            }
          ),

          ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.redAccent,
              ),
              title: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.redAccent
                ),
              ),
              trailing: const Icon(
                  Icons.navigate_next
              ),
              onTap: () async{

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context){
                      return const CustomLoader(
                          message: 'Signing Out'
                      );
                    }
                );
                await AuthServices.signOut();

                Helpers.back(context);

                Helpers.temporaryNavigator(context, const AuthHandler());
              }
          ),
        ],
      ),
    );
  }
}
