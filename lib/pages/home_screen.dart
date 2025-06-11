import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/models/subscriptions.dart';

import 'package:trackizer/pages/custom_arc_painter.dart';
import 'package:trackizer/widgets/custom_status_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final subs = Subscriptions.dummySubs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.gray80,
      body: Column(
        children: [
          _buildArcPercentage(media),
          Expanded(child: _buildTabs(media)),
        ],
      ),
    );
  }

  Widget _buildArcPercentage(var media) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(27)),
        color: AppColors.gray70,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset("assets/images/home_bg.png", fit: BoxFit.cover),
          Container(
            padding: EdgeInsets.only(bottom: media.width * 0.05),
            height: media.width * 0.68,
            width: media.width * 0.68,
            child: CustomPaint(painter: CustomArcPainter()),
          ),
          Column(
            children: [
              Image.asset(
                "assets/images/app_logo.png",
                width: media.width * 0.25,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 16),
              Text(
                "\$1235",
                style: TextStyle(
                  fontSize: 46,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Text(
                "This month bills",
                style: TextStyle(fontSize: 16, color: AppColors.gray30),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gray60,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text("See your budget"),
              ),
            ],
          ),
          Positioned(
            bottom: media.height * 0.007,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomStatusButton(
                    title: "Active subs",
                    value: "12",
                    onPressed: () {},
                    color: Color(0xffFFA699),
                  ),
                  CustomStatusButton(
                    title: "Highest subs",
                    value: "\$19.99",
                    onPressed: () {},
                    color: Color(0xffAD7BFF),
                  ),
                  CustomStatusButton(
                    title: "Lowest subs",
                    value: "\$5.99",
                    onPressed: () {},
                    color: Color(0xff7DFFEE),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(var media) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        children: [
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.all(12),
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: "Your subscriptions"),
                Tab(text: "Upcoming bills"),
              ],
              labelColor: AppColors.white,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              unselectedLabelColor: AppColors.gray30,
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: AppColors.gray70,
                borderRadius: BorderRadius.circular(14),
              ),
              splashFactory: NoSplash.splashFactory,
            ),
          ),
          SizedBox(height: 6),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildYourSubs(), _buildUpcomingSubs()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourSubs() {
    return ListView.separated(
      itemBuilder: (context, index) {
        final sub = subs[index];
        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.gray70.withOpacity(0.5),
            border: Border.all(
              color: AppColors.gray60.withOpacity(0.4),
              width: 2,
            ),
          ),
          child: ListTile(
            leading: Image.asset(sub.imageUrl, height: 50, width: 50),
            title: Text(
              sub.title,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            trailing: Text(
              "\$${sub.price}",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: subs.length,
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }

  Widget _buildUpcomingSubs() {
    return ListView.separated(
      itemBuilder: (context, index) {
        final sub = subs[index];
        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.gray70.withOpacity(0.5),
            border: Border.all(
              color: AppColors.gray60.withOpacity(0.4),
              width: 2,
            ),
          ),
          child: ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.gray60.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    DateFormat.MMM().format(sub.endDate),
                    style: TextStyle(
                      color: AppColors.gray30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    sub.endDate.day.toString(),
                    style: TextStyle(
                      color: AppColors.gray30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            title: Text(
              sub.title,
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            trailing: Text(
              "\$${sub.price}",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: subs.length,
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }
}
