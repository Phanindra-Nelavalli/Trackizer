enum CardType { Rupay, Visa, MasterCard }

class PaymentCards {
  final String cardName;
  final String userName;
  final String cardNumber;
  final String originalCardNumber;
  final String expiryDate;
  final CardType cardType;
  final String cardLogo;
  final String bankName;

  PaymentCards({
    required this.cardName,
    required this.userName,
    required this.cardNumber,
    required this.originalCardNumber,
    required this.expiryDate,
    required this.cardType,
    required this.cardLogo,
    required this.bankName,
  });

  static final List<PaymentCards> dummyCards = [
    PaymentCards(
      cardName: 'Virtual Card',
      userName: 'John Doe',
      cardNumber: '**** **** **** 2197',
      originalCardNumber: '1234 5678 9012 2197',
      expiryDate: '08/28',
      cardType: CardType.MasterCard,
      cardLogo: 'assets/images/mastercard_logo.png',
      bankName: 'HDFC Bank',
    ),
    PaymentCards(
      cardName: 'Virtual Card',
      userName: 'John Doe',
      cardNumber: '**** **** **** 8743',
      originalCardNumber: '9876 5432 1098 8743',
      expiryDate: '12/27',
      cardType: CardType.Visa,
      cardLogo: 'assets/images/visacard_logo.png',
      bankName: 'ICICI Bank',
    ),
    PaymentCards(
      cardName: 'Virtual Card',
      userName: 'John Doe',
      cardNumber: '**** **** **** 4311',
      originalCardNumber: '4321 9876 5432 4311',
      expiryDate: '05/29',
      cardType: CardType.Rupay,
      cardLogo: 'assets/images/rupaycard_logo.png',
      bankName: 'SBI Bank',
    ),
    PaymentCards(
      cardName: 'Virtual Card',
      userName: 'John Doe',
      cardNumber: '**** **** **** 9981',
      originalCardNumber: '8765 4321 8765 9981',
      expiryDate: '03/26',
      cardType: CardType.MasterCard,
      cardLogo: 'assets/images/mastercard_logo.png',
      bankName: 'Kotak Mahindra Bank',
    ),
    PaymentCards(
      cardName: 'Virtual Card',
      userName: 'John Doe',
      cardNumber: '**** **** **** 6720',
      originalCardNumber: '5678 1234 9012 6720',
      expiryDate: '11/30',
      cardType: CardType.Visa,
      cardLogo: 'assets/images/visacard_logo.png',
      bankName: 'Axis Bank',
    ),
  ];
}
