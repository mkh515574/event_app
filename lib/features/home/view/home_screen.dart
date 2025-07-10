
import 'package:event_app/features/home/taps/profile%20tap/profile_tap.dart';

import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileTap(),
      floatingActionButton: FloatingActionButton(


        child: Icon(Icons.add, color: AppColors.whiteColor,size: 40,),
        onPressed: () {
          // your logic here
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ])
    );
  }
}
