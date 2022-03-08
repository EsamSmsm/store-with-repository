import 'package:flutter/material.dart';
import 'package:hospital25/core/languages/language_ar.dart';

abstract class Languages {
  static Languages of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages) ?? LanguageAr();
  }

  String get appName;

  String get locationUpdated;
  String get selectLocation;
  String get myLocation;

  String get update;
  String get newUpdate;
  String get updateSentence;
  String get updateFrom;
  String get to;
  String get later;

  /// On Boarding Screen Text
  String get start;

  /// Auth Screen Text
  String get back;
  String get arabic;
  String get english;
  String get register;
  String get newRegister;
  String get login;
  String get username;
  String get email;
  String get usernameOrEmail;
  String get pass;
  String get confirmPass;
  String get lostYourPass;
  String get resetPass;
  String get cancel;
  String get pleaseEnterEmail;
  String get pleaseEnterValidEmail;
  String get pleaseEnterPass;
  String get pleaseEnterUsername;
  String get passShort;
  String get passNotMatch;
  String get privacySentence;
  String get privacyPolicy;
  String get rememberMe;
  String get getTxt;

  /// Home Layout Text
  String get home;
  String get myWishList;
  String get cart;
  String get notify;
  String get profile;
  String get contactUs;
  String get aboutUs;

  /// Profile Tab Text
  String get notifications;
  String get darkMode;
  String get support;
  String get language;
  String get myProfile;
  String get orders;
  String get downloads;
  String get addresses;
  String get accountDetails;

  /// About Us Screen Text
  String get about;
  String get aboutDescription;

  /// Contact Us Screen Text
  String get callUs;
  String get quickContact;
  String get fullName;
  String get emailAddress;
  String get subject;
  String get message;
  String get sendMessage;
  String get filedIsRequired;
  String get location;
  String get followUs;
  String get messageSent;

  /// Support Screen Text
  String get needHelp;
  String get searchInFAQ;
  String get fAQ;
  String get all;
  String get customerService;
  String get delivery;
  String get order;
  String get payment;
  String get returning;
  String get question1;
  String get question2;
  String get question3;
  String get question4;
  String get question5;
  String get question6;
  String get question7;
  String get question8;
  String get question9;
  String get question10;
  String get question11;
  String get question12;
  String get question13;
  String get answer1;
  String get answer2;
  String get answer3;
  String get answer4;
  String get answer5;
  String get answer6;
  String get answer7;
  String get answer8;
  String get answer9;
  String get answer10;
  String get answer11;
  String get answer12;
  String get answer13;

  /// Notification Screen Text
  String get newTxt;
  String get newNotify1;
  String get earlier;
  String get earlierNotify1;
  String get timeAgo1;
  String get timeAgo2;
  String get shopNow;

  /// Cart Screen Text
  String get product;
  String get price;
  String get quantity;
  String get subtotal;
  String get currency;
  String get updateCart;
  String get total;
  String get proceedToCheckout;
  String get emptyCart;
  String get backToStore;
  String get backToStoreSentence;
  String get discountCoupon;
  String get cartTotal;
  String get vat;
  String get estimatedFor;
  String get estimatedForEgypt;
  String get enterCouponCode;
  String get continueShopping;
  String get freeShipping;
  String get spend;
  String get freeShippingSentence1;
  String get freeShippingSentence2;
  String get couponCode;
  String get applyCoupon;
  String get removeCoupon;
  String get emptyCartSentence;

  /// Product Details Screen Text
  String get review;
  String get oneReview;
  String get selectQuantity;
  String get sKU;
  String get categories;
  String get reviews;
  String get addReview;
  String get willNotShareEmail;
  String get yourReview;
  String get addToCart;
  String get inCart;
  String get name;
  String get submit;
  String get noReviewsYet;
  String get beTheFirstReview;
  String get yourRating;
  String get pleaseSelectOption;
  String get thisOptionNotAvailable;
  String get pleaseSelectYourRating;
  String get pleaseWriteYourReview;
  String get reviewIsAwaitingApproval;
  String get discount;
  String get additionalInfo;
  String get featuredProduct;
  String get dimensions;
  String get material;
  String get season;
  String get backToProducts;
  String get soldInLast;
  String get hours;
  String get colors;
  String get sizes;
  String get aboutProduct;
  String get relatedProducts;

  /// Home Screen Text
  String get searchForProduct;
  String get shoeRoomStore;
  String get searchForBestPrice;
  String get topCategories;
  String get allCategories;

  String get topOffers;
  String get seeAll;
  String get shoes;
  String get bags;
  String get accessories;
  String get theNewParty;
  String get howToDress;
  String get welcomeBack;

  /// WishList Screen Text
  String get emptyWishlist;
  String get productName;
  String get unitPrice;
  String get stockStatus;
  String get productRemoved;
  String get productAdded;

  // Orders Screen Text
  String get myOrders;
  String get noOrders;
  String get noOrdersSentence;
  String get browseProducts;
  String get status;
  String get action;
  String get view;
  String get items;
  String get forTxt;
  String get date;

  //Checkout layout
  String get checkout;
  String get finish;
  String get orderDetails;
  String get youMustAgreesToReturn;
  String get iHaveReadAndAgree;
  String get returnPolicy;
  String get allTransactionsSecure;
  String get shipping;
  String get shippingFees;
  String get addressInformation;
  String get continueToPaymentMethod;
  String get paymentDetails;
  String get addNewCard;
  String get yourPersonalDataSentence;

  /// Downloads Screen Text
  String get myDownloads;
  String get noDownloads;
  String get noDownloadsSentence;

  /// Addresses Screen Text
  String get myAddresses;
  String get addressSentence;
  String get billingAddress;
  String get add;
  String get noAddressYet;
  String get shippingAddress;

  /// Account Details Screen Text
  String get myAccount;
  String get firstName;
  String get lastName;
  String get passwordChange;
  String get currentPassword;
  String get newPassword;
  String get confirmNewPassword;
  String get saveChanges;

  /// Checkout Screen Text
  String get haveCoupon;
  String get clickToEnterCode;
  String get ifHaveCoupon;
  String get billingDetails;
  String get companyName;
  String get countryRegion;
  String get streetAddress;
  String get houseNumber;
  String get apartmentSuite;
  String get townCity;
  String get stateCountry;
  String get postcodeZIP;
  String get phone;
  String get shipToDifferent;
  String get orderNotes;
  String get orderNotesSentence;
  String get yourOrder;
  String get cashOnDelivery;
  String get payWithCash;
  String get placeOrder;
  String get pleaseEnterCouponCode;
  String get coupon;
  String get notExist;
  String get shippingTo;
  String get changeAddress;

  ///Order Placed Screen Text
  String get thankYouOrderReceived;
  String get orderReceived;
  String get orderNo;
  String get paymentMethod;

  /// All Products Screen Text
  String get products;

  ///Offers Screen Text
  String get offers;

  /// Search Screen Text
  String get recentlySearchedIn;
  String get empty;
  String get enterFewWordsSentence;

  /// Reset Password Screen Text
  String get resetPassword;
  String get resetPasswordSentence;

  /// Order Details Screen Text
  String get wasPlacedOn;
  String get andIsCurrently;
  String get connectionFailed;
  String get logout;

  /// Sorting Types Text
  String get defaultSorting;
  String get sortByPopularity;
  String get sortByAverageRating;
  String get sortByLatest;
  String get sortByPriceLow;
  String get sortByPriceHigh;
  String get showing;
  String get results;
  String get ofTxt;
  String get allTxt;
  String get theResults;

  ///
  String get warning;
  String get error;
  String get tryAgain;
  String get connectYourDevice;
  String get exitTxt;
  String get edit;
  String get skip;

  ///OTP Screen
  String get verifyNum;
  String get codeSent;
  String get labelContinue;
  String get resendCode;
  String get expEndWithin;

  //Filtration Screen
  String get topBrands;
  String get hotTrends;
  String get bestSeller;
  String get productsFiltration;

  //Product Item
  String get hotDeals;

  //Filter Menu
  String get filterBy;
  String get byCategory;
  String get byPrice;
  String get bySize;
  String get byColor;
  String get applyFilter;

  //SnackBar Text
  String get currentPassIsIncorrect;
  String get yourProfileUpdated;
  String get failedToLogin;
  String get pleaseCompleteAddress;
  String get failedToCreateOrder;
  String get bankCards;
  String get unverifiedEmailPleaseVerify;
  String get verify;
  String get sendingVerificationEmail;
  String get verificationMailSent;
  String get doubleTapToClose;
  String get needToLoginFirst;
  String get addressUpdated;
  String get isInvalidNumber;
  String get sendResetCode;
  String get haveAccount;
  String get haveVerificationCode;
  String get changePassword;

  String get startShopping;
  String get loginHere;
  String get youSuccessfullyVerifyYourAccount;
  String get byRegister;
  String get and;
  String get yourEmailAddress;
  String get byLogin;
  String get loginBySocialMedia;
  String get termsAndConditions;

  //Card Text
  String get cardNumber;
  String get enterValidCardNumber;
  String get enterValidMonth;
  String get enterValidYear;
  String get enterValidCVV;
  String get expireDate;
  String get saveCard;
  String get applied;
  String get removed;
  String get failed;
  String get shippingPolicy;

  //
  String get mobileVerification;
  String get pleaseEnterYourNumberSentence;
  String get enterValidNumber;
  String get sendingVerificationCode;
  String get verificationCode;
  String get enterThemCodeBelow;
  String get confirm;
  String get loadMore;
  String get noNotification;
  String get details;
  String get description;
  String get shortDescription;
  String get outOfStock;
  String get badges;
  String get clearSelection;
  String get sale;
  String get featured;
  String get soldOut;
  String get asBillingAddress;
  String get notPurchasableProduct;
  String get stockQuantity;
  String get shippingNotAvailable;
  String get itemsLeftInStock;
  String get peopleViewing;
  String get only;
  String get estimatedDelivery;
  String get bulkSavings;
  String get buy;
  String get quantityUpdated;
  String get selectedYourCountry;
  String get selectedYourState;

  ///////
  String get address;
  String get amount;
  String get bills;
  String get phoneNumber;
  String get restorePass;
  String get restorePassSentence;
  String get searchProduct;
  String get search;
  String get save;
  String get time;
}
