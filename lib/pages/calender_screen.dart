// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/models/subscriptions.dart';
import 'package:trackizer/widgets/subscription_card.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  late ScrollController _scrollController;
  String selectedMonth = DateFormat.MMMM().format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  List<DateTime> getDatesInMonth(String month) {
    final int year = DateTime.now().year;
    final int monthIndex = months.indexOf(month) + 1;
    final int totalDays = DateTime(year, monthIndex + 1, 0).day;

    return List.generate(
      totalDays,
      (index) => DateTime(year, monthIndex, index + 1),
    );
  }

  double getUpcomingBillsTotal({int daysAhead = 30}) {
    final now = selectedDate;
    final futureLimit = now.add(Duration(days: daysAhead));

    final upcomingSubs = Subscriptions.dummySubs.where((sub) {
      final nextBilling = sub.getNextBillingDate();
      return nextBilling.isAfter(now) && nextBilling.isBefore(futureLimit);
    });

    return upcomingSubs.fold(0.0, (sum, sub) => sum + sub.price);
  }

  late List<Subscriptions> subscriptions;

  void updateSubscriptionsForDate(DateTime date) {
    subscriptions =
        Subscriptions.dummySubs
            .where(
              (sub) =>
                  sub.startDate.isBefore(date.add(Duration(days: 1))) &&
                  sub.endDate.isAfter(date.subtract(Duration(days: 1))),
            )
            .toList();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    updateSubscriptionsForDate(selectedDate);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dates = getDatesInMonth(selectedMonth);
      final today = DateTime.now();
      final todayIndex = dates.indexWhere(
        (date) =>
            date.day == today.day &&
            date.month == today.month &&
            date.year == today.year,
      );
      if (todayIndex != -1) {
        _scrollController.jumpTo(todayIndex * 72.0);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.gray80,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [_buildCalender(media), _bulidSubsGrid(media)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalender(var media) {
    return Container(
      width: double.infinity,
      height: media.height * 0.50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(27)),
        color: AppColors.gray70.withOpacity(0.8),
      ),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    "Calender",
                    style: TextStyle(
                      color: AppColors.gray20,
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Positioned(
                  right: -15,
                  child: IconButton(
                    onPressed: () {},
                    splashColor: AppColors.white.withOpacity(0.2),
                    splashRadius: 24,
                    icon: Icon(
                      Icons.settings_outlined,
                      color: AppColors.gray30,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          Text(
            "Subs\nSchedule",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 52,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${subscriptions.length} subscriptions for today",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.gray30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 120,
                padding: EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.gray80.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      color: AppColors.gray80.withOpacity(0.07),
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedMonth,
                  dropdownColor: AppColors.gray80,
                  elevation: 2,
                  isExpanded: true,
                  alignment: Alignment.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(13, 0, 10, 0),
                  ),
                  items:
                      months.map((month) {
                        return DropdownMenuItem(
                          value: month,
                          alignment: Alignment.center,
                          child: Text(
                            month,
                            style: TextStyle(
                              color: AppColors.gray10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: getDatesInMonth(selectedMonth).length,
              itemBuilder: (context, index) {
                final date = getDatesInMonth(selectedMonth)[index];
                final isToday =
                    selectedDate.day == date.day &&
                    selectedDate.month == date.month;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Container(
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color:
                          isToday
                              ? AppColors.gray30.withOpacity(0.5)
                              : AppColors.gray80.withOpacity(0.5),
                    ),
                    padding: EdgeInsets.all(12),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedDate = date;
                        });
                        updateSubscriptionsForDate(selectedDate);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('dd').format(date),
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            DateFormat('E').format(date).substring(0, 2),
                            style: TextStyle(
                              color: AppColors.gray20,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 35),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isToday ? AppColors.secondary : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulidSubsGrid(var media) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedMonth,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "\$${getUpcomingBillsTotal().toStringAsFixed(2)}",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('dd.MM.yyy').format(selectedDate),
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.4),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                "In upcoming bills",
                style: TextStyle(
                  color: AppColors.white.withOpacity(0.4),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 20,
              childAspectRatio: 0.85,
            ),
            itemCount: subscriptions.length,
            itemBuilder: (context, index) {
              return SubscriptionCard(subscription: subscriptions[index]);
            },
          ),
        ],
      ),
    );
  }
}
