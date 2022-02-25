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

  /// `Farmer market`
  String get farmerMarket {
    return Intl.message(
      'Farmer market',
      name: 'farmerMarket',
      desc: '',
      args: [],
    );
  }

  /// `Add product`
  String get addProductScreen_addProduct {
    return Intl.message(
      'Add product',
      name: 'addProductScreen_addProduct',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get addProductScreen_product {
    return Intl.message(
      'Product',
      name: 'addProductScreen_product',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get addProductScreen_description {
    return Intl.message(
      'Description',
      name: 'addProductScreen_description',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get addProductScreen_price {
    return Intl.message(
      'Price',
      name: 'addProductScreen_price',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get addProductScreen_save {
    return Intl.message(
      'Save',
      name: 'addProductScreen_save',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phoneEnterScreen_phone {
    return Intl.message(
      'Phone',
      name: 'phoneEnterScreen_phone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct phone number`
  String get phoneEnterScreen_enterCorrectPhone {
    return Intl.message(
      'Please enter correct phone number',
      name: 'phoneEnterScreen_enterCorrectPhone',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get phoneEnterScreen_sendCode {
    return Intl.message(
      'Send Code',
      name: 'phoneEnterScreen_sendCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Code`
  String get phoneEnterScreen_confirmCode {
    return Intl.message(
      'Confirm Code',
      name: 'phoneEnterScreen_confirmCode',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong with server response, please try later`
  String get phoneEnterScreen_serverResponseGaveBad {
    return Intl.message(
      'Something went wrong with server response, please try later',
      name: 'phoneEnterScreen_serverResponseGaveBad',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get userDetailScreen_name {
    return Intl.message(
      'Name',
      name: 'userDetailScreen_name',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get userDetailScreen_description {
    return Intl.message(
      'Description',
      name: 'userDetailScreen_description',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get userDetailScreen_address {
    return Intl.message(
      'Address',
      name: 'userDetailScreen_address',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong with server response, please try later`
  String get userDetailScreen_serverResponseGaveBad {
    return Intl.message(
      'Something went wrong with server response, please try later',
      name: 'userDetailScreen_serverResponseGaveBad',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get userDetailScreen_save {
    return Intl.message(
      'Save',
      name: 'userDetailScreen_save',
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
      Locale.fromSubtags(languageCode: 'ru'),
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
