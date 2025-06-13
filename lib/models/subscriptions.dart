enum SubscriptionType { Classic, Silver, Gold, Platinum }

enum SubscriptionPeriod { Monthly, Annually, Weekly, Custom }

class Subscriptions {
  final String title;
  final String imageUrl;
  final double price;
  final DateTime startDate;
  final DateTime endDate;
  final SubscriptionType type;
  final SubscriptionPeriod period;
  final Duration? customDuration;

  Subscriptions({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.startDate,
    required this.type,
    this.period = SubscriptionPeriod.Monthly,
    this.customDuration,
  }) : endDate = _calculateEndDate(startDate, period, customDuration);

  static DateTime _calculateEndDate(
    DateTime startDate,
    SubscriptionPeriod period,
    Duration? customDuration,
  ) {
    switch (period) {
      case SubscriptionPeriod.Monthly:
        return DateTime(startDate.year, startDate.month + 1, startDate.day);
      case SubscriptionPeriod.Annually:
        return DateTime(startDate.year + 1, startDate.month, startDate.day);
      case SubscriptionPeriod.Weekly:
        return startDate.add(const Duration(days: 7));
      case SubscriptionPeriod.Custom:
        if (customDuration == null) {
          throw ArgumentError(
            'customDuration must be provided when SubscriptionPeriod is Custom',
          );
        }
        return startDate.add(customDuration);
    }
  }

  static final List<Subscriptions> dummySubs = [
    Subscriptions(
      title: "Spotify",
      imageUrl: "assets/images/spotify_logo.png",
      price: 5.99,
      startDate: DateTime(2025, 6, 1),
      type: SubscriptionType.Gold,
      period: SubscriptionPeriod.Monthly,
    ),
    Subscriptions(
      title: "Youtube Premium",
      imageUrl: "assets/images/youtube_logo.png",
      price: 18.99,
      startDate: DateTime(2025, 5, 20),
      type: SubscriptionType.Gold,
      period: SubscriptionPeriod.Monthly,
    ),
    Subscriptions(
      title: "Netflix",
      imageUrl: "assets/images/netflix_logo.png",
      price: 149.99,
      startDate: DateTime(2025, 1, 15),
      type: SubscriptionType.Platinum,
      period: SubscriptionPeriod.Annually,
    ),
  ];
}

extension SubscriptionUtils on Subscriptions {
  DateTime getNextBillingDate() {
    DateTime now = DateTime.now();

    DateTime next = startDate;

    while (next.isBefore(now)) {
      switch (period) {
        case SubscriptionPeriod.Monthly:
          next = DateTime(next.year, next.month + 1, next.day);
          break;
        case SubscriptionPeriod.Annually:
          next = DateTime(next.year + 1, next.month, next.day);
          break;
        case SubscriptionPeriod.Weekly:
          next = next.add(Duration(days: 7));
          break;
        case SubscriptionPeriod.Custom:
          next = next.add(customDuration!);
          break;
      }
    }

    return next;
  }
}
