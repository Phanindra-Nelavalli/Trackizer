import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:trackizer/common/App_Colors.dart';
import 'package:trackizer/models/payment_cards.dart';
import 'package:trackizer/models/subscriptions.dart';
import 'package:trackizer/pages/add_new_card.dart';

class PaymentCardsScreen extends StatefulWidget {
  const PaymentCardsScreen({super.key});

  @override
  State<PaymentCardsScreen> createState() => _PaymentCardsScreenState();
}

class _PaymentCardsScreenState extends State<PaymentCardsScreen> {
  final List<Subscriptions> subscriptions =
      Subscriptions.dummySubs
          .where(
            (sub) =>
                sub.startDate.isBefore(DateTime.now().add(Duration(days: 1))) &&
                sub.endDate.isAfter(DateTime.now().subtract(Duration(days: 1))),
          )
          .toList();
  final SwiperController _swiperController = SwiperController();
  final cards = PaymentCards.dummyCards;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray80,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 24),
            SizedBox(
              height: 25,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Text(
                      "Credit Cards",
                      style: TextStyle(
                        color: AppColors.gray30,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 15,
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
            cards.isNotEmpty
                ? Column(
                  children: [
                    _buildSwiper(),
                    SizedBox(height: 40),
                    Text(
                      "Subscriptions",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        subscriptions.length,
                        (index) => Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(subscriptions[index].imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                : _buildNoCardsDisplay(),
            SizedBox(height: 40),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  color: AppColors.gray70.withOpacity(0.8),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                    child: InkWell(
                      splashColor:AppColors.white.withOpacity(0.7),
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNewCard(),
                            ),
                          ),
                      child: DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          dashPattern: [5, 4],
                          strokeWidth: 2,
                          radius: Radius.circular(12),
                          color: AppColors.gray60.withOpacity(0.7),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.gray70.withOpacity(0.25),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Add new card",
                                  style: TextStyle(
                                    color: AppColors.gray30,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.gray30,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoCardsDisplay() {
    return SizedBox(
      height: 450,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wallet_outlined,
              size: 64,
              color: AppColors.white.withOpacity(0.8),
            ),
            SizedBox(height: 8),
            Text(
              "There are no Payment Cards",
              style: TextStyle(
                color: AppColors.white.withOpacity(0.8),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwiper() {
    return Swiper(
      itemCount: cards.length,
      customLayoutOption:
          CustomLayoutOption(startIndex: -1, stateCount: 3)
            ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
            ..addTranslate([
              const Offset(-370.0, -40.0),
              Offset.zero,
              const Offset(370.0, -40.0),
            ]),
      fade: 1.0,
      scale: 0.8,
      itemWidth: 232.0,
      autoplayDisableOnInteraction: false,
      itemHeight: 350,
      controller: _swiperController,
      layout: SwiperLayout.STACK,
      viewportFraction: 0.8,
      axisDirection: AxisDirection.right,
      itemBuilder: (context, index) {
        final card = cards[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.gray70,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 12)],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/card_blank.png",
                width: 232.0,
                height: 350,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  children: [
                    Image.asset(
                      card.cardLogo,
                      width: 72,
                      height: 34,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 16),
                    Text(
                      card.cardName,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      card.bankName,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    Text(
                      card.userName,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      card.cardNumber,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      card.expiryDate,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
