import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @cont.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get cont;

  /// No description provided for @noUserFound.
  ///
  /// In en, this message translates to:
  /// **'No user found for that email.'**
  String get noUserFound;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'\'t have an Account?'**
  String get dontHaveAnAccount;

  /// No description provided for @createOne.
  ///
  /// In en, this message translates to:
  /// **' Create One'**
  String get createOne;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue With Apple'**
  String get continueWithApple;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue With Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithFacebook.
  ///
  /// In en, this message translates to:
  /// **'Continue With Facebook'**
  String get continueWithFacebook;

  /// No description provided for @emptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emptyMessage;

  /// No description provided for @invalidFormatMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get invalidFormatMessage;

  /// No description provided for @emptyPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get emptyPassword;

  /// No description provided for @minLengthMessage.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get minLengthMessage;

  /// No description provided for @patternMessage.
  ///
  /// In en, this message translates to:
  /// **'Password must contain letters and numbers'**
  String get patternMessage;

  /// No description provided for @pass.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get pass;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **' Reset'**
  String get reset;

  /// No description provided for @enterEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter Email Address'**
  String get enterEmailAddress;

  /// No description provided for @emailIsAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'Email is already in use'**
  String get emailIsAlreadyInUse;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Email is not valid'**
  String get invalidEmail;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak'**
  String get weakPassword;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPassword;

  /// No description provided for @authError.
  ///
  /// In en, this message translates to:
  /// **'Authentication error'**
  String get authError;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @tellUsAboutYourself.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get tellUsAboutYourself;

  /// No description provided for @whoDoYouShopFor.
  ///
  /// In en, this message translates to:
  /// **'Who do you shop for?'**
  String get whoDoYouShopFor;

  /// No description provided for @howoldAreYou.
  ///
  /// In en, this message translates to:
  /// **'How old are you?'**
  String get howoldAreYou;

  /// No description provided for @selectAge.
  ///
  /// In en, this message translates to:
  /// **'Select Age'**
  String get selectAge;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @ecommerceShop.
  ///
  /// In en, this message translates to:
  /// **'Ecommerce Shop'**
  String get ecommerceShop;

  /// No description provided for @professionalAppForYour.
  ///
  /// In en, this message translates to:
  /// **'Professional App for your '**
  String get professionalAppForYour;

  /// No description provided for @ecommerceBusiness.
  ///
  /// In en, this message translates to:
  /// **'Ecommerce Business'**
  String get ecommerceBusiness;

  /// No description provided for @purachaseOnline.
  ///
  /// In en, this message translates to:
  /// **'!!Purachase Online'**
  String get purachaseOnline;

  /// No description provided for @trackOrder.
  ///
  /// In en, this message translates to:
  /// **'!!Track Order'**
  String get trackOrder;

  /// No description provided for @getYourOrder.
  ///
  /// In en, this message translates to:
  /// **'!!Get your order'**
  String get getYourOrder;

  /// No description provided for @shopsmarter.
  ///
  /// In en, this message translates to:
  /// **'Shop Smarter,faster and easier'**
  String get shopsmarter;

  /// No description provided for @fastTransperntAlwaysOnTime.
  ///
  /// In en, this message translates to:
  /// **'Fast, transparent, always on time'**
  String get fastTransperntAlwaysOnTime;

  /// No description provided for @receiveYourOrder.
  ///
  /// In en, this message translates to:
  /// **'Receive your order fast and hassle-free'**
  String get receiveYourOrder;

  /// No description provided for @resetPassText.
  ///
  /// In en, this message translates to:
  /// **'We Sent you an Email to reset'**
  String get resetPassText;

  /// No description provided for @resetPassText2.
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get resetPassText2;

  /// No description provided for @returnToLogin.
  ///
  /// In en, this message translates to:
  /// **'Return to login'**
  String get returnToLogin;

  /// No description provided for @men.
  ///
  /// In en, this message translates to:
  /// **'Men'**
  String get men;

  /// No description provided for @women.
  ///
  /// In en, this message translates to:
  /// **'Women'**
  String get women;

  /// No description provided for @kids.
  ///
  /// In en, this message translates to:
  /// **'Kids'**
  String get kids;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @topSelling.
  ///
  /// In en, this message translates to:
  /// **'Top Selling'**
  String get topSelling;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @bags.
  ///
  /// In en, this message translates to:
  /// **'Bags'**
  String get bags;

  /// No description provided for @shoes.
  ///
  /// In en, this message translates to:
  /// **'Shoes'**
  String get shoes;

  /// No description provided for @shorts.
  ///
  /// In en, this message translates to:
  /// **'Shorts'**
  String get shorts;

  /// No description provided for @shopByCategory.
  ///
  /// In en, this message translates to:
  /// **'Shop by Category'**
  String get shopByCategory;

  /// No description provided for @hoddies.
  ///
  /// In en, this message translates to:
  /// **'Hoddies'**
  String get hoddies;

  /// No description provided for @accessories.
  ///
  /// In en, this message translates to:
  /// **'Accessories'**
  String get accessories;

  /// No description provided for @sale.
  ///
  /// In en, this message translates to:
  /// **'Sale'**
  String get sale;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get order;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No Notification yet'**
  String get noNotifications;

  /// No description provided for @exploreCategories.
  ///
  /// In en, this message translates to:
  /// **'Explore Categories'**
  String get exploreCategories;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @shipped.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get shipped;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @returned.
  ///
  /// In en, this message translates to:
  /// **'Returned'**
  String get returned;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @noOrders.
  ///
  /// In en, this message translates to:
  /// **'No Orders yet'**
  String get noOrders;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get item;

  /// No description provided for @orderItems.
  ///
  /// In en, this message translates to:
  /// **'Order Items'**
  String get orderItems;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @orderPlaced.
  ///
  /// In en, this message translates to:
  /// **'Order Placed'**
  String get orderPlaced;

  /// No description provided for @successfully.
  ///
  /// In en, this message translates to:
  /// **'Successfully'**
  String get successfully;

  /// No description provided for @receiveEmail.
  ///
  /// In en, this message translates to:
  /// **'You will receive a confirmation email'**
  String get receiveEmail;

  /// No description provided for @seeOrderDetails.
  ///
  /// In en, this message translates to:
  /// **'See Order details'**
  String get seeOrderDetails;

  /// No description provided for @shopByCategories.
  ///
  /// In en, this message translates to:
  /// **'Shop by Categories'**
  String get shopByCategories;

  /// No description provided for @s.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get s;

  /// No description provided for @m.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get m;

  /// No description provided for @l.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get l;

  /// No description provided for @xl.
  ///
  /// In en, this message translates to:
  /// **'ْXL'**
  String get xl;

  /// No description provided for @newIn.
  ///
  /// In en, this message translates to:
  /// **'New In'**
  String get newIn;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @shippingAndReturn.
  ///
  /// In en, this message translates to:
  /// **'Shipping and Return'**
  String get shippingAndReturn;

  /// No description provided for @freeStandardShippingAndFreereturn.
  ///
  /// In en, this message translates to:
  /// **'Free Standard Shipping and Free 60-days Return'**
  String get freeStandardShippingAndFreereturn;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get review;

  /// No description provided for @reviewers.
  ///
  /// In en, this message translates to:
  /// **'Reviewers'**
  String get reviewers;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @addToBag.
  ///
  /// In en, this message translates to:
  /// **'Add To Bag'**
  String get addToBag;

  /// No description provided for @addedToBag.
  ///
  /// In en, this message translates to:
  /// **'Added To Bag'**
  String get addedToBag;

  /// No description provided for @proceedToCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get proceedToCheckout;

  /// No description provided for @emptyCart.
  ///
  /// In en, this message translates to:
  /// **'Your Cart is Empty'**
  String get emptyCart;

  /// No description provided for @removeAll.
  ///
  /// In en, this message translates to:
  /// **'Remove All'**
  String get removeAll;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @shippingCost.
  ///
  /// In en, this message translates to:
  /// **'Shipping Cost'**
  String get shippingCost;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @tax.
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @enterCouponCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Coupon Code'**
  String get enterCouponCode;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// No description provided for @addShippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Shipping Address'**
  String get addShippingAddress;

  /// No description provided for @shippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddress;

  /// No description provided for @addPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Add Payment Method'**
  String get addPaymentMethod;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetails;

  /// No description provided for @cardHolderName.
  ///
  /// In en, this message translates to:
  /// **'Card Holder Name'**
  String get cardHolderName;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **' Address'**
  String get address;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **' City'**
  String get city;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State/Region'**
  String get state;

  /// No description provided for @zipCode.
  ///
  /// In en, this message translates to:
  /// **' Zip Code'**
  String get zipCode;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **' Country'**
  String get country;

  /// No description provided for @pleaseEnterCardHolderName.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Card Holder Name'**
  String get pleaseEnterCardHolderName;

  /// No description provided for @pleaseEnterCardNumber.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Card Number'**
  String get pleaseEnterCardNumber;

  /// No description provided for @pleaseEnterExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Expiry Date'**
  String get pleaseEnterExpiryDate;

  /// No description provided for @pleaseEnterAddress.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Address'**
  String get pleaseEnterAddress;

  /// No description provided for @pleaseEnterCity.
  ///
  /// In en, this message translates to:
  /// **'Please Enter City'**
  String get pleaseEnterCity;

  /// No description provided for @pleaseEnterState.
  ///
  /// In en, this message translates to:
  /// **'Please Enter State'**
  String get pleaseEnterState;

  /// No description provided for @pleaseEnterZipCode.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Zip Code'**
  String get pleaseEnterZipCode;

  /// No description provided for @pleaseEnterCountry.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Country'**
  String get pleaseEnterCountry;

  /// No description provided for @validExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid Expiry Date'**
  String get validExpiryDate;

  /// No description provided for @validCvv.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Valid CVV'**
  String get validCvv;

  /// No description provided for @addCard.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get addCard;

  /// No description provided for @zipcodemustbe.
  ///
  /// In en, this message translates to:
  /// **'Zipcode must be between 3 to 10 digits'**
  String get zipcodemustbe;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addAddress;

  /// No description provided for @noorder.
  ///
  /// In en, this message translates to:
  /// **'No order found.'**
  String get noorder;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all the fields'**
  String get pleaseFillAllFields;

  /// No description provided for @failedToPlaceOrder.
  ///
  /// In en, this message translates to:
  /// **'Failed to place order:'**
  String get failedToPlaceOrder;

  /// No description provided for @orderPlacedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order placed successfully! Order ID:'**
  String get orderPlacedSuccessfully;

  /// No description provided for @noAddressProvided.
  ///
  /// In en, this message translates to:
  /// **'No address provided'**
  String get noAddressProvided;

  /// No description provided for @shippingDetails.
  ///
  /// In en, this message translates to:
  /// **'Shipping Details'**
  String get shippingDetails;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
