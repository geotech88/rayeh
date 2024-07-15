// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Service Requester`
  String get serviceRequester {
    return Intl.message(
      'Service Requester',
      name: 'serviceRequester',
      desc: '',
      args: [],
    );
  }

  /// `Service Provider`
  String get serviceProvider {
    return Intl.message(
      'Service Provider',
      name: 'serviceProvider',
      desc: '',
      args: [],
    );
  }

  /// `Choose Destination:`
  String get chooseLocation {
    return Intl.message(
      'Choose Destination:',
      name: 'chooseLocation',
      desc: '',
      args: [],
    );
  }

  /// `Current Destination:`
  String get choosedLocation {
    return Intl.message(
      'Current Destination:',
      name: 'choosedLocation',
      desc: '',
      args: [],
    );
  }

  /// `Promotions`
  String get promotions {
    return Intl.message(
      'Promotions',
      name: 'promotions',
      desc: '',
      args: [],
    );
  }

  /// `Offers Available`
  String get availableOffers {
    return Intl.message(
      'Offers Available',
      name: 'availableOffers',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Offer`
  String get offer {
    return Intl.message(
      'Offer',
      name: 'offer',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `It will launch after:`
  String get launchAfter {
    return Intl.message(
      'It will launch after:',
      name: 'launchAfter',
      desc: '',
      args: [],
    );
  }

  /// `Starting Place:`
  String get startingPlace {
    return Intl.message(
      'Starting Place:',
      name: 'startingPlace',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `More Details`
  String get more {
    return Intl.message(
      'More Details',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Current Flight:`
  String get currentFlight {
    return Intl.message(
      'Current Flight:',
      name: 'currentFlight',
      desc: '',
      args: [],
    );
  }

  /// `Departure Date:`
  String get departureDate {
    return Intl.message(
      'Departure Date:',
      name: 'departureDate',
      desc: '',
      args: [],
    );
  }

  /// `Previous Flights:`
  String get prevFlights {
    return Intl.message(
      'Previous Flights:',
      name: 'prevFlights',
      desc: '',
      args: [],
    );
  }

  /// `Duration:`
  String get duration {
    return Intl.message(
      'Duration:',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Rating:`
  String get rating {
    return Intl.message(
      'Rating:',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `More Reviews`
  String get moreReviews {
    return Intl.message(
      'More Reviews',
      name: 'moreReviews',
      desc: '',
      args: [],
    );
  }

  /// `Contact Provider`
  String get contactProvider {
    return Intl.message(
      'Contact Provider',
      name: 'contactProvider',
      desc: '',
      args: [],
    );
  }

  /// `Create Offer`
  String get createOffer {
    return Intl.message(
      'Create Offer',
      name: 'createOffer',
      desc: '',
      args: [],
    );
  }

  /// `Write Something`
  String get chatHintTxt {
    return Intl.message(
      'Write Something',
      name: 'chatHintTxt',
      desc: '',
      args: [],
    );
  }

  /// `The Client:`
  String get client {
    return Intl.message(
      'The Client:',
      name: 'client',
      desc: '',
      args: [],
    );
  }

  /// `Choose Date:`
  String get chooseDate {
    return Intl.message(
      'Choose Date:',
      name: 'chooseDate',
      desc: '',
      args: [],
    );
  }

  /// `Service Type:`
  String get serviceType {
    return Intl.message(
      'Service Type:',
      name: 'serviceType',
      desc: '',
      args: [],
    );
  }

  /// `Commission:`
  String get commission {
    return Intl.message(
      'Commission:',
      name: 'commission',
      desc: '',
      args: [],
    );
  }

  /// `Show The Offer`
  String get showOffer {
    return Intl.message(
      'Show The Offer',
      name: 'showOffer',
      desc: '',
      args: [],
    );
  }

  /// `The Price`
  String get price {
    return Intl.message(
      'The Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Product Price`
  String get productPrice {
    return Intl.message(
      'Product Price',
      name: 'productPrice',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Price`
  String get deliveryPrice {
    return Intl.message(
      'Delivery Price',
      name: 'deliveryPrice',
      desc: '',
      args: [],
    );
  }

  /// `Direction`
  String get direction {
    return Intl.message(
      'Direction',
      name: 'direction',
      desc: '',
      args: [],
    );
  }

  /// `Arrival Date`
  String get arrivalDate {
    return Intl.message(
      'Arrival Date',
      name: 'arrivalDate',
      desc: '',
      args: [],
    );
  }

  /// `Service Cost`
  String get serviceCost {
    return Intl.message(
      'Service Cost',
      name: 'serviceCost',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Proceed To Checkout`
  String get goToCheckout {
    return Intl.message(
      'Proceed To Checkout',
      name: 'goToCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Provider`
  String get provider {
    return Intl.message(
      'Provider',
      name: 'provider',
      desc: '',
      args: [],
    );
  }

  /// `Offer Preview`
  String get offerPreview {
    return Intl.message(
      'Offer Preview',
      name: 'offerPreview',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `The Account`
  String get account {
    return Intl.message(
      'The Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Personal Informations`
  String get personalInfos {
    return Intl.message(
      'Personal Informations',
      name: 'personalInfos',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Previous Offers`
  String get prevOffers {
    return Intl.message(
      'Previous Offers',
      name: 'prevOffers',
      desc: '',
      args: [],
    );
  }

  /// `Date:`
  String get date {
    return Intl.message(
      'Date:',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post {
    return Intl.message(
      'Post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Delete Offer`
  String get deleteOffer {
    return Intl.message(
      'Delete Offer',
      name: 'deleteOffer',
      desc: '',
      args: [],
    );
  }

  /// `Accepte Offer`
  String get accepteOffer {
    return Intl.message(
      'Accepte Offer',
      name: 'accepteOffer',
      desc: '',
      args: [],
    );
  }

  /// `Offer Details`
  String get offerDetails {
    return Intl.message(
      'Offer Details',
      name: 'offerDetails',
      desc: '',
      args: [],
    );
  }

  /// `List Of Current Services`
  String get listOfCurrentServices {
    return Intl.message(
      'List Of Current Services',
      name: 'listOfCurrentServices',
      desc: '',
      args: [],
    );
  }

  /// `Add Update To Service`
  String get addUpdateToService {
    return Intl.message(
      'Add Update To Service',
      name: 'addUpdateToService',
      desc: '',
      args: [],
    );
  }

  /// `Service:`
  String get service {
    return Intl.message(
      'Service:',
      name: 'service',
      desc: '',
      args: [],
    );
  }

  /// `Now`
  String get now {
    return Intl.message(
      'Now',
      name: 'now',
      desc: '',
      args: [],
    );
  }

  /// `Tracking Service`
  String get trackingService {
    return Intl.message(
      'Tracking Service',
      name: 'trackingService',
      desc: '',
      args: [],
    );
  }

  /// `Add An Update`
  String get addAnUpdate {
    return Intl.message(
      'Add An Update',
      name: 'addAnUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delivery`
  String get confirmDelivery {
    return Intl.message(
      'Confirm Delivery',
      name: 'confirmDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Payment Completed Successfully!!!`
  String get paymentSucceded {
    return Intl.message(
      'Payment Completed Successfully!!!',
      name: 'paymentSucceded',
      desc: '',
      args: [],
    );
  }

  /// `The Product Is On Its Way To You`
  String get productOnHisWay {
    return Intl.message(
      'The Product Is On Its Way To You',
      name: 'productOnHisWay',
      desc: '',
      args: [],
    );
  }

  /// `Track Your Service`
  String get trackYourService {
    return Intl.message(
      'Track Your Service',
      name: 'trackYourService',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR Code`
  String get scanQrCode {
    return Intl.message(
      'Scan QR Code',
      name: 'scanQrCode',
      desc: '',
      args: [],
    );
  }

  /// `Total Incomes`
  String get totalIncome {
    return Intl.message(
      'Total Incomes',
      name: 'totalIncome',
      desc: '',
      args: [],
    );
  }

  /// `Number Of Clients`
  String get numOfClients {
    return Intl.message(
      'Number Of Clients',
      name: 'numOfClients',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Requests`
  String get transferRequests {
    return Intl.message(
      'Transfer Requests',
      name: 'transferRequests',
      desc: '',
      args: [],
    );
  }

  /// `Previous Requestes`
  String get prevRequest {
    return Intl.message(
      'Previous Requestes',
      name: 'prevRequest',
      desc: '',
      args: [],
    );
  }

  /// `Process The Order Now`
  String get processOrder {
    return Intl.message(
      'Process The Order Now',
      name: 'processOrder',
      desc: '',
      args: [],
    );
  }

  /// `Done Successfully`
  String get done {
    return Intl.message(
      'Done Successfully',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Request Details`
  String get requestDetails {
    return Intl.message(
      'Request Details',
      name: 'requestDetails',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get summary {
    return Intl.message(
      'Summary',
      name: 'summary',
      desc: '',
      args: [],
    );
  }

  /// `Withdrawal Amount`
  String get withdrawalAmount {
    return Intl.message(
      'Withdrawal Amount',
      name: 'withdrawalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Fees`
  String get fees {
    return Intl.message(
      'Fees',
      name: 'fees',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Number`
  String get transferNum {
    return Intl.message(
      'Transfer Number',
      name: 'transferNum',
      desc: '',
      args: [],
    );
  }

  /// `Recipient`
  String get recipient {
    return Intl.message(
      'Recipient',
      name: 'recipient',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Balance`
  String get walletBalance {
    return Intl.message(
      'Wallet Balance',
      name: 'walletBalance',
      desc: '',
      args: [],
    );
  }

  /// `Tracking Services`
  String get trackingServices {
    return Intl.message(
      'Tracking Services',
      name: 'trackingServices',
      desc: '',
      args: [],
    );
  }

  /// `Ongoing`
  String get ongoing {
    return Intl.message(
      'Ongoing',
      name: 'ongoing',
      desc: '',
      args: [],
    );
  }

  /// `Finished`
  String get finished {
    return Intl.message(
      'Finished',
      name: 'finished',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Place`
  String get place {
    return Intl.message(
      'Place',
      name: 'place',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Update`
  String get confirmUpdate {
    return Intl.message(
      'Confirm Update',
      name: 'confirmUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Product`
  String get purchaseProduct {
    return Intl.message(
      'Purchase Product',
      name: 'purchaseProduct',
      desc: '',
      args: [],
    );
  }

  /// `Deliver Product`
  String get delivereProduct {
    return Intl.message(
      'Deliver Product',
      name: 'delivereProduct',
      desc: '',
      args: [],
    );
  }

  /// `Edit The Credit Card`
  String get editCreditCard {
    return Intl.message(
      'Edit The Credit Card',
      name: 'editCreditCard',
      desc: '',
      args: [],
    );
  }

  /// `My Card`
  String get myCard {
    return Intl.message(
      'My Card',
      name: 'myCard',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get withdrawalRequest {
    return Intl.message(
      'Withdraw',
      name: 'withdrawalRequest',
      desc: '',
      args: [],
    );
  }

  /// `Search For a City...`
  String get searchForCity {
    return Intl.message(
      'Search For a City...',
      name: 'searchForCity',
      desc: '',
      args: [],
    );
  }

  /// `Search For a Country...`
  String get searchForCountry {
    return Intl.message(
      'Search For a Country...',
      name: 'searchForCountry',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Aboard!`
  String get loginAlertTitle {
    return Intl.message(
      'Welcome Aboard!',
      name: 'loginAlertTitle',
      desc: '',
      args: [],
    );
  }

  /// `Unlock the full experience! Log in now to discover more and personalize your journey.`
  String get loginAlertMsg {
    return Intl.message(
      'Unlock the full experience! Log in now to discover more and personalize your journey.',
      name: 'loginAlertMsg',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Successfully loggedIn!`
  String get loginSuccessTitle {
    return Intl.message(
      'Successfully loggedIn!',
      name: 'loginSuccessTitle',
      desc: '',
      args: [],
    );
  }

  /// `Failed to login!`
  String get loginErrorTitle {
    return Intl.message(
      'Failed to login!',
      name: 'loginErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `You've successfully logged in! Welcome , enjoy an unforgettable experience.`
  String get loginSuccessMsg {
    return Intl.message(
      'You\'ve successfully logged in! Welcome , enjoy an unforgettable experience.',
      name: 'loginSuccessMsg',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, an error occurred. Please try again later.`
  String get loginErrorMsg {
    return Intl.message(
      'Sorry, an error occurred. Please try again later.',
      name: 'loginErrorMsg',
      desc: '',
      args: [],
    );
  }

  /// `Logout!`
  String get logoutTitle {
    return Intl.message(
      'Logout!',
      name: 'logoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `You Successfully logged out`
  String get logoutMsg {
    return Intl.message(
      'You Successfully logged out',
      name: 'logoutMsg',
      desc: '',
      args: [],
    );
  }

  /// `Error!`
  String get errorTitle {
    return Intl.message(
      'Error!',
      name: 'errorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, an error occurred. Please try again.`
  String get errorMsg {
    return Intl.message(
      'Sorry, an error occurred. Please try again.',
      name: 'errorMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please select a country`
  String get errorEmptyCountry {
    return Intl.message(
      'Please select a country',
      name: 'errorEmptyCountry',
      desc: '',
      args: [],
    );
  }

  /// `Please select a city`
  String get errorEmptyCity {
    return Intl.message(
      'Please select a city',
      name: 'errorEmptyCity',
      desc: '',
      args: [],
    );
  }

  /// `First city and second city cannot be the same`
  String get errorSameCities {
    return Intl.message(
      'First city and second city cannot be the same',
      name: 'errorSameCities',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back,`
  String get welcomeAdmin {
    return Intl.message(
      'Welcome Back,',
      name: 'welcomeAdmin',
      desc: '',
      args: [],
    );
  }

  /// `transfer to request`
  String get transferRequest {
    return Intl.message(
      'transfer to request',
      name: 'transferRequest',
      desc: '',
      args: [],
    );
  }

  /// `from the wallet to the account No.`
  String get fromWalletToAcc {
    return Intl.message(
      'from the wallet to the account No.',
      name: 'fromWalletToAcc',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Offer`
  String get confirmTrip {
    return Intl.message(
      'Confirm Offer',
      name: 'confirmTrip',
      desc: '',
      args: [],
    );
  }

  /// `user`
  String get user {
    return Intl.message(
      'user',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `You're Offline!`
  String get checkConnectionTitle {
    return Intl.message(
      'You\'re Offline!',
      name: 'checkConnectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Turn on mobile data or connect to a Wi-Fi, Or just take a break and try again!`
  String get checkConnectionMsg {
    return Intl.message(
      'Turn on mobile data or connect to a Wi-Fi, Or just take a break and try again!',
      name: 'checkConnectionMsg',
      desc: '',
      args: [],
    );
  }

  /// `Update Username`
  String get updateUsername {
    return Intl.message(
      'Update Username',
      name: 'updateUsername',
      desc: '',
      args: [],
    );
  }

  /// `Update Email`
  String get updateEmail {
    return Intl.message(
      'Update Email',
      name: 'updateEmail',
      desc: '',
      args: [],
    );
  }

  /// `Update Profession`
  String get updateProfession {
    return Intl.message(
      'Update Profession',
      name: 'updateProfession',
      desc: '',
      args: [],
    );
  }

  /// `Please describe your offer`
  String get postOfferDesc {
    return Intl.message(
      'Please describe your offer',
      name: 'postOfferDesc',
      desc: '',
      args: [],
    );
  }

  /// `No reviews available`
  String get noReviewsFound {
    return Intl.message(
      'No reviews available',
      name: 'noReviewsFound',
      desc: '',
      args: [],
    );
  }

  /// `No Previous Trips available`
  String get noPrevTripsFound {
    return Intl.message(
      'No Previous Trips available',
      name: 'noPrevTripsFound',
      desc: '',
      args: [],
    );
  }

  /// `No Previous Offers available`
  String get noPrevOffersFound {
    return Intl.message(
      'No Previous Offers available',
      name: 'noPrevOffersFound',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Confirmed`
  String get tripFinishedTitle {
    return Intl.message(
      'Delivery Confirmed',
      name: 'tripFinishedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for confirming your delivery! The product has been successfully delivered.`
  String get tripFinishedMsg {
    return Intl.message(
      'Thank you for confirming your delivery! The product has been successfully delivered.',
      name: 'tripFinishedMsg',
      desc: '',
      args: [],
    );
  }

  /// `Rate Your Journey`
  String get rateTrip {
    return Intl.message(
      'Rate Your Journey',
      name: 'rateTrip',
      desc: '',
      args: [],
    );
  }

  /// `Send Review`
  String get sendRating {
    return Intl.message(
      'Send Review',
      name: 'sendRating',
      desc: '',
      args: [],
    );
  }

  /// `Write your review here`
  String get reviewDesc {
    return Intl.message(
      'Write your review here',
      name: 'reviewDesc',
      desc: '',
      args: [],
    );
  }

  /// `Update Succeded`
  String get infosUpdatedTitle {
    return Intl.message(
      'Update Succeded',
      name: 'infosUpdatedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your informations has been updated.`
  String get infosUpdatedMsg {
    return Intl.message(
      'Your informations has been updated.',
      name: 'infosUpdatedMsg',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
