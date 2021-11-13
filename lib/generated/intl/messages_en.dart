// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "authPageButtonLogin": MessageLookupByLibrary.simpleMessage("Log in"),
        "authPageButtonRegistration":
            MessageLookupByLibrary.simpleMessage("Sign up"),
        "authPageInputPassword":
            MessageLookupByLibrary.simpleMessage("Password"),
        "authPageLoginWithMessage":
            MessageLookupByLibrary.simpleMessage("Log in with"),
        "authPageMessage": MessageLookupByLibrary.simpleMessage(
            "Sign up to save your information"),
        "authPageRetryBtn": MessageLookupByLibrary.simpleMessage("Try again"),
        "authPageRetryLogin": MessageLookupByLibrary.simpleMessage(
            "Unable to login, please try again!"),
        "authPageTitle": MessageLookupByLibrary.simpleMessage("Sign up"),
        "authPageValidatorComparePassword":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "authPageValidatorEmptyPassword":
            MessageLookupByLibrary.simpleMessage("Please enter your password"),
        "authPageValidatorPassword":
            MessageLookupByLibrary.simpleMessage("Incorrect password"),
        "autoLogoutInfo": MessageLookupByLibrary.simpleMessage(
            "Your session has expired. Please log in to your account again."),
        "continueWithoutAccount": MessageLookupByLibrary.simpleMessage(
            "Continue without creating an account"),
        "inputEmailLabel":
            MessageLookupByLibrary.simpleMessage("Email address"),
        "loginButtonNext": MessageLookupByLibrary.simpleMessage("Next"),
        "loginSync": MessageLookupByLibrary.simpleMessage("Syncing data..."),
        "loginValidatorEmptyConfirmCode": MessageLookupByLibrary.simpleMessage(
            "Please enter the confirmation code"),
        "loginValidatorEmptyEmail": MessageLookupByLibrary.simpleMessage(
            "Please enter your email address"),
        "loginValidatorInvalidEmail":
            MessageLookupByLibrary.simpleMessage("Invalid email address"),
        "profileChangeEmailAlertText": MessageLookupByLibrary.simpleMessage(
            "A confirmation email has been sent to your email address"),
        "profileChangeEmailEnterEmailPageText":
            MessageLookupByLibrary.simpleMessage(
                "Enter your new email address"),
        "profileChangeEmailEnterPassPageText":
            MessageLookupByLibrary.simpleMessage(
                "Enter your password to change your email address"),
        "profileChangeEmailErrorEmailBusy": MessageLookupByLibrary.simpleMessage(
            "The email address you entered is already in use. If it is your email address, use it to sign in to your profile."),
        "profileChangeEmailErrorInvalidPassword":
            MessageLookupByLibrary.simpleMessage(
                "Incorrect password. Please try again."),
        "profileChangeEmailErrorUnknown": MessageLookupByLibrary.simpleMessage(
            "An unexpected error occurred. Please check your internet connection and try again."),
        "profileChangeEmailPageTitle":
            MessageLookupByLibrary.simpleMessage("Change email address"),
        "profileEnterNewPassAgainPageMessage":
            MessageLookupByLibrary.simpleMessage(
                "Please re-enter your password"),
        "profileEnterNewPassPageMessage":
            MessageLookupByLibrary.simpleMessage("Create a new password"),
        "profileEnterOldPassPageMessage": MessageLookupByLibrary.simpleMessage(
            "You must enter your current password before you can change it"),
        "profileEnterPassPageTitle":
            MessageLookupByLibrary.simpleMessage("Change password"),
        "profilePageRemindEmailConfirmMessage":
            MessageLookupByLibrary.simpleMessage(
                "Your email has not been confirmed. To confirm it, please click the link that was sent to the email address you used to sign up"),
        "profilePassChangedAlertInfo": MessageLookupByLibrary.simpleMessage(
            "Your password has been changed!"),
        "profileRemoveButton":
            MessageLookupByLibrary.simpleMessage("Delete profile"),
        "profileRemoveCodeFailure": MessageLookupByLibrary.simpleMessage(
            "Incorrect confirmation code. If you did not receive a confirmation code or deleted the email, please use the resend option."),
        "profileRemoveCodeReSent": MessageLookupByLibrary.simpleMessage(
            "A new code has been sent to your email"),
        "profileRemoveCodeSent": MessageLookupByLibrary.simpleMessage(
            "A confirmation code has been sent to your email address. Enter it below to delete your profile."),
        "profileRemoveConfirm": MessageLookupByLibrary.simpleMessage(
            "You are about to delete your account and all its data. This action cannot be undone. Do you want to continue?"),
        "profileRemoveFailure": MessageLookupByLibrary.simpleMessage(
            "Error deleting profile, please try again later."),
        "profileResendRemoveConfirmCode":
            MessageLookupByLibrary.simpleMessage("Resend code"),
        "recoverPageTitle":
            MessageLookupByLibrary.simpleMessage("Recover access"),
        "recoverPagesMessageLogin": MessageLookupByLibrary.simpleMessage(
            "To reset your password, please enter the email address you registered with."),
        "recoverSendEmailPageButtonText":
            MessageLookupByLibrary.simpleMessage("OK"),
        "recoverSendEmailPageMessage": MessageLookupByLibrary.simpleMessage(
            "We have sent you an email with information on how to reset your password"),
        "recoveryPagesMessagePasswordAgain":
            MessageLookupByLibrary.simpleMessage(
                "Please re-enter your password"),
        "recoveryPagesPassChangedAlertInfo":
            MessageLookupByLibrary.simpleMessage(
                "Your password has been changed!"),
        "recoveryPassExpireToken": MessageLookupByLibrary.simpleMessage(
            "The link expired, please try to change your password again"),
        "recoveryPassNotFoundEmail": MessageLookupByLibrary.simpleMessage(
            "We couldn\'t find an account with that email address"),
        "recoveryPassTokenAlreadyUsed": MessageLookupByLibrary.simpleMessage(
            "This password reset link has already been used"),
        "sendEmailPageButtonText": MessageLookupByLibrary.simpleMessage("OK"),
        "sendEmailPageMessage": MessageLookupByLibrary.simpleMessage(
            "Your message has been sent!\nYou will receive a reply soon."),
        "sentConfirmEmailAlertText": MessageLookupByLibrary.simpleMessage(
            "A confirmation email has been sent to your email address"),
        "signInPageLoginSuccessAlert":
            MessageLookupByLibrary.simpleMessage("Log in successful"),
        "signInPageRecovery":
            MessageLookupByLibrary.simpleMessage("Forgot your password?"),
        "signInPageTitle": MessageLookupByLibrary.simpleMessage("Log in"),
        "signInPagesMessageLogin": MessageLookupByLibrary.simpleMessage(
            "Please enter the email address you registered with"),
        "signInPagesMessagePassword":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "signUpPageEmailConfirmMessage": MessageLookupByLibrary.simpleMessage(
            "Your email address has been confirmed"),
        "signUpPageEmailExpiredLinkMessage": MessageLookupByLibrary.simpleMessage(
            "Your email verification link has expired. Do you want to re-send it?"),
        "signUpPageEmailNotConfirmButtonSend":
            MessageLookupByLibrary.simpleMessage("Send"),
        "signUpPageEmailNotConfirmMessage": MessageLookupByLibrary.simpleMessage(
            "You haven\'t confirmed this email address. Resend confirmation email?"),
        "signUpPageSuccessConfirmMessage": MessageLookupByLibrary.simpleMessage(
            "We have sent you a confirmation email."),
        "signUpPageSuccessConfirmTitle": MessageLookupByLibrary.simpleMessage(
            "Thank you, you are now signed up."),
        "signUpPageTitle": MessageLookupByLibrary.simpleMessage("Sign up"),
        "signUpPagesMessageLogin":
            MessageLookupByLibrary.simpleMessage("Enter your email address"),
        "signUpPagesMessagePassword":
            MessageLookupByLibrary.simpleMessage("Create a password"),
        "signUpPagesMessagePasswordAgain": MessageLookupByLibrary.simpleMessage(
            "Please re-enter your password")
      };
}
