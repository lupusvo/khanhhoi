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

  /// `Next`
  String get loginButtonNext {
    return Intl.message(
      'Next',
      name: 'loginButtonNext',
      desc: '',
      args: [],
    );
  }

  /// `Recover access`
  String get recoverPageTitle {
    return Intl.message(
      'Recover access',
      name: 'recoverPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `To reset your password, please enter the email address you registered with.`
  String get recoverPagesMessageLogin {
    return Intl.message(
      'To reset your password, please enter the email address you registered with.',
      name: 'recoverPagesMessageLogin',
      desc: '',
      args: [],
    );
  }

  /// `We have sent you an email with information on how to reset your password`
  String get recoverSendEmailPageMessage {
    return Intl.message(
      'We have sent you an email with information on how to reset your password',
      name: 'recoverSendEmailPageMessage',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get recoverSendEmailPageButtonText {
    return Intl.message(
      'OK',
      name: 'recoverSendEmailPageButtonText',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't find an account with that email address`
  String get recoveryPassNotFoundEmail {
    return Intl.message(
      'We couldn\'t find an account with that email address',
      name: 'recoveryPassNotFoundEmail',
      desc: '',
      args: [],
    );
  }

  /// `The link expired, please try to change your password again`
  String get recoveryPassExpireToken {
    return Intl.message(
      'The link expired, please try to change your password again',
      name: 'recoveryPassExpireToken',
      desc: '',
      args: [],
    );
  }

  /// `This password reset link has already been used`
  String get recoveryPassTokenAlreadyUsed {
    return Intl.message(
      'This password reset link has already been used',
      name: 'recoveryPassTokenAlreadyUsed',
      desc: '',
      args: [],
    );
  }

  /// `Please re-enter your password`
  String get recoveryPagesMessagePasswordAgain {
    return Intl.message(
      'Please re-enter your password',
      name: 'recoveryPagesMessagePasswordAgain',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been changed!`
  String get recoveryPagesPassChangedAlertInfo {
    return Intl.message(
      'Your password has been changed!',
      name: 'recoveryPagesPassChangedAlertInfo',
      desc: '',
      args: [],
    );
  }

  /// `A confirmation email has been sent to your email address`
  String get sentConfirmEmailAlertText {
    return Intl.message(
      'A confirmation email has been sent to your email address',
      name: 'sentConfirmEmailAlertText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get authPageValidatorEmptyPassword {
    return Intl.message(
      'Please enter your password',
      name: 'authPageValidatorEmptyPassword',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password`
  String get authPageValidatorPassword {
    return Intl.message(
      'Incorrect password',
      name: 'authPageValidatorPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get authPageValidatorComparePassword {
    return Intl.message(
      'Passwords do not match',
      name: 'authPageValidatorComparePassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get authPageInputPassword {
    return Intl.message(
      'Password',
      name: 'authPageInputPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get authPageTitle {
    return Intl.message(
      'Sign up',
      name: 'authPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get signInPageTitle {
    return Intl.message(
      'Log in',
      name: 'signInPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get signInPageRecovery {
    return Intl.message(
      'Forgot your password?',
      name: 'signInPageRecovery',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get authPageButtonRegistration {
    return Intl.message(
      'Sign up',
      name: 'authPageButtonRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUpPageTitle {
    return Intl.message(
      'Sign up',
      name: 'signUpPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address`
  String get signUpPagesMessageLogin {
    return Intl.message(
      'Enter your email address',
      name: 'signUpPagesMessageLogin',
      desc: '',
      args: [],
    );
  }

  /// `Create a password`
  String get signUpPagesMessagePassword {
    return Intl.message(
      'Create a password',
      name: 'signUpPagesMessagePassword',
      desc: '',
      args: [],
    );
  }

  /// `Please re-enter your password`
  String get signUpPagesMessagePasswordAgain {
    return Intl.message(
      'Please re-enter your password',
      name: 'signUpPagesMessagePasswordAgain',
      desc: '',
      args: [],
    );
  }

  /// `Your email address has been confirmed`
  String get signUpPageEmailConfirmMessage {
    return Intl.message(
      'Your email address has been confirmed',
      name: 'signUpPageEmailConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `You haven't confirmed this email address. Resend confirmation email?`
  String get signUpPageEmailNotConfirmMessage {
    return Intl.message(
      'You haven\'t confirmed this email address. Resend confirmation email?',
      name: 'signUpPageEmailNotConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your email verification link has expired. Do you want to re-send it?`
  String get signUpPageEmailExpiredLinkMessage {
    return Intl.message(
      'Your email verification link has expired. Do you want to re-send it?',
      name: 'signUpPageEmailExpiredLinkMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your email has not been confirmed. To confirm it, please click the link that was sent to the email address you used to sign up`
  String get profilePageRemindEmailConfirmMessage {
    return Intl.message(
      'Your email has not been confirmed. To confirm it, please click the link that was sent to the email address you used to sign up',
      name: 'profilePageRemindEmailConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get signUpPageEmailNotConfirmButtonSend {
    return Intl.message(
      'Send',
      name: 'signUpPageEmailNotConfirmButtonSend',
      desc: '',
      args: [],
    );
  }

  /// `We have sent you a confirmation email.`
  String get signUpPageSuccessConfirmMessage {
    return Intl.message(
      'We have sent you a confirmation email.',
      name: 'signUpPageSuccessConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Thank you, you are now signed up.`
  String get signUpPageSuccessConfirmTitle {
    return Intl.message(
      'Thank you, you are now signed up.',
      name: 'signUpPageSuccessConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get authPageButtonLogin {
    return Intl.message(
      'Log in',
      name: 'authPageButtonLogin',
      desc: '',
      args: [],
    );
  }

  /// `Log in with`
  String get authPageLoginWithMessage {
    return Intl.message(
      'Log in with',
      name: 'authPageLoginWithMessage',
      desc: '',
      args: [],
    );
  }

  /// `Continue without creating an account`
  String get continueWithoutAccount {
    return Intl.message(
      'Continue without creating an account',
      name: 'continueWithoutAccount',
      desc: '',
      args: [],
    );
  }

  /// `Unable to login, please try again!`
  String get authPageRetryLogin {
    return Intl.message(
      'Unable to login, please try again!',
      name: 'authPageRetryLogin',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get authPageRetryBtn {
    return Intl.message(
      'Try again',
      name: 'authPageRetryBtn',
      desc: '',
      args: [],
    );
  }

  /// `Sign up to save your information`
  String get authPageMessage {
    return Intl.message(
      'Sign up to save your information',
      name: 'authPageMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the email address you registered with`
  String get signInPagesMessageLogin {
    return Intl.message(
      'Please enter the email address you registered with',
      name: 'signInPagesMessageLogin',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get signInPagesMessagePassword {
    return Intl.message(
      'Enter your password',
      name: 'signInPagesMessagePassword',
      desc: '',
      args: [],
    );
  }

  /// `Log in successful`
  String get signInPageLoginSuccessAlert {
    return Intl.message(
      'Log in successful',
      name: 'signInPageLoginSuccessAlert',
      desc: '',
      args: [],
    );
  }

  /// `Your message has been sent!\nYou will receive a reply soon.`
  String get sendEmailPageMessage {
    return Intl.message(
      'Your message has been sent!\nYou will receive a reply soon.',
      name: 'sendEmailPageMessage',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get sendEmailPageButtonText {
    return Intl.message(
      'OK',
      name: 'sendEmailPageButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get inputEmailLabel {
    return Intl.message(
      'Email address',
      name: 'inputEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get loginValidatorInvalidEmail {
    return Intl.message(
      'Invalid email address',
      name: 'loginValidatorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address`
  String get loginValidatorEmptyEmail {
    return Intl.message(
      'Please enter your email address',
      name: 'loginValidatorEmptyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Syncing data...`
  String get loginSync {
    return Intl.message(
      'Syncing data...',
      name: 'loginSync',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get profileEnterPassPageTitle {
    return Intl.message(
      'Change password',
      name: 'profileEnterPassPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `You must enter your current password before you can change it`
  String get profileEnterOldPassPageMessage {
    return Intl.message(
      'You must enter your current password before you can change it',
      name: 'profileEnterOldPassPageMessage',
      desc: '',
      args: [],
    );
  }

  /// `Create a new password`
  String get profileEnterNewPassPageMessage {
    return Intl.message(
      'Create a new password',
      name: 'profileEnterNewPassPageMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please re-enter your password`
  String get profileEnterNewPassAgainPageMessage {
    return Intl.message(
      'Please re-enter your password',
      name: 'profileEnterNewPassAgainPageMessage',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been changed!`
  String get profilePassChangedAlertInfo {
    return Intl.message(
      'Your password has been changed!',
      name: 'profilePassChangedAlertInfo',
      desc: '',
      args: [],
    );
  }

  /// `Change email address`
  String get profileChangeEmailPageTitle {
    return Intl.message(
      'Change email address',
      name: 'profileChangeEmailPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password to change your email address`
  String get profileChangeEmailEnterPassPageText {
    return Intl.message(
      'Enter your password to change your email address',
      name: 'profileChangeEmailEnterPassPageText',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new email address`
  String get profileChangeEmailEnterEmailPageText {
    return Intl.message(
      'Enter your new email address',
      name: 'profileChangeEmailEnterEmailPageText',
      desc: '',
      args: [],
    );
  }

  /// `A confirmation email has been sent to your email address`
  String get profileChangeEmailAlertText {
    return Intl.message(
      'A confirmation email has been sent to your email address',
      name: 'profileChangeEmailAlertText',
      desc: '',
      args: [],
    );
  }

  /// `The email address you entered is already in use. If it is your email address, use it to sign in to your profile.`
  String get profileChangeEmailErrorEmailBusy {
    return Intl.message(
      'The email address you entered is already in use. If it is your email address, use it to sign in to your profile.',
      name: 'profileChangeEmailErrorEmailBusy',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password. Please try again.`
  String get profileChangeEmailErrorInvalidPassword {
    return Intl.message(
      'Incorrect password. Please try again.',
      name: 'profileChangeEmailErrorInvalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please check your internet connection and try again.`
  String get profileChangeEmailErrorUnknown {
    return Intl.message(
      'An unexpected error occurred. Please check your internet connection and try again.',
      name: 'profileChangeEmailErrorUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Delete profile`
  String get profileRemoveButton {
    return Intl.message(
      'Delete profile',
      name: 'profileRemoveButton',
      desc: '',
      args: [],
    );
  }

  /// `Resend code`
  String get profileResendRemoveConfirmCode {
    return Intl.message(
      'Resend code',
      name: 'profileResendRemoveConfirmCode',
      desc: '',
      args: [],
    );
  }

  /// `You are about to delete your account and all its data. This action cannot be undone. Do you want to continue?`
  String get profileRemoveConfirm {
    return Intl.message(
      'You are about to delete your account and all its data. This action cannot be undone. Do you want to continue?',
      name: 'profileRemoveConfirm',
      desc: '',
      args: [],
    );
  }

  /// `A confirmation code has been sent to your email address. Enter it below to delete your profile.`
  String get profileRemoveCodeSent {
    return Intl.message(
      'A confirmation code has been sent to your email address. Enter it below to delete your profile.',
      name: 'profileRemoveCodeSent',
      desc: '',
      args: [],
    );
  }

  /// `A new code has been sent to your email`
  String get profileRemoveCodeReSent {
    return Intl.message(
      'A new code has been sent to your email',
      name: 'profileRemoveCodeReSent',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the confirmation code`
  String get loginValidatorEmptyConfirmCode {
    return Intl.message(
      'Please enter the confirmation code',
      name: 'loginValidatorEmptyConfirmCode',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect confirmation code. If you did not receive a confirmation code or deleted the email, please use the resend option.`
  String get profileRemoveCodeFailure {
    return Intl.message(
      'Incorrect confirmation code. If you did not receive a confirmation code or deleted the email, please use the resend option.',
      name: 'profileRemoveCodeFailure',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting profile, please try again later.`
  String get profileRemoveFailure {
    return Intl.message(
      'Error deleting profile, please try again later.',
      name: 'profileRemoveFailure',
      desc: '',
      args: [],
    );
  }

  /// `Your session has expired. Please log in to your account again.`
  String get autoLogoutInfo {
    return Intl.message(
      'Your session has expired. Please log in to your account again.',
      name: 'autoLogoutInfo',
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
      Locale.fromSubtags(languageCode: 'vi'),
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
