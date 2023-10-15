import 'package:flutter/material.dart';
import 'package:profile_part/src/widget/constant_widget/App_Bar/app_bar.dart';
import 'package:profile_part/src/widget/custom_Widget.dart/drawer_widget.dart';
import 'package:profile_part/src/widget/pages_widget/NavBar_widgets/history_widget.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: profileAppBar(),
        drawer: Drawer(
          child: DrawerWidget(),
        ),
        body: HistoryWidget());
  }
}