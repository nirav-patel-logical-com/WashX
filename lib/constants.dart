import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class Constants {
  static String constJson;
  static var object;

  static void initialize(RemoteConfigValue jsoon) {
    constJson = jsoon.asString();
    object = jsonDecode(
      constJson,
    );
    var authConstants = object['AuthConstants'];
    var setupConstants = object['SetupConstants'];

    _fillValues(authConstants, setupConstants);
  }

  static void _fillValues(Map authConstants, Map setupConstants) {
    emailAlreadyExists = authConstants['emailAlreadyExists'];
    emailNotFound = authConstants['emailNotFound'];
    invalidLoginCredentials = authConstants['invalidLoginCredentials'];
    compleateSignUpProcess = authConstants['compleateSignUpProcess'];
    textSpan1 = authConstants['textSpan1'];
    textSpan2 = authConstants['textSpan2'];
    textSpan3 = authConstants['textSpan3'];
    fbLoginCancelled = authConstants['fbLoginCancelled'];
    fbFatalError = authConstants['fbFatalError'];
    forgotPwdCheckEmail = authConstants['forgotPwdCheckEmail'];
    forgotPwdEmailNotFound = authConstants['forgotPwdEmailNotFound'];
    forgotPwdEnterDetails = authConstants['forgotPwdEnterDetails'];
    setupBeforeweplaceMsg = setupConstants['setupBeforeweplaceMsg'];
    setupBeforeWeStartMsg = setupConstants['setupBeforeWeStartMsg'];
    setupYourAssistantMsg = setupConstants['setupYourAssistantMsg'];
    setupLetsStartMsg = setupConstants['setupLetsStartMsg'];
    setupLetsSetupMsg = setupConstants['setupLetsSetupMsg'];
    setupPaymentMethod = setupConstants['setupPaymentMethod'];
    setupWardrobe = setupConstants['setupWardrobe'];
  }

//Authentication Screen --start

  static String emailAlreadyExists =
      'Email already exist, please try another email.';
  static String emailNotFound =
      'Email not found in our database. Signup process started.';
  static String invalidLoginCredentials =
      'Invalid username and password combinations.';
  static String compleateSignUpProcess =
      "Please enter few more informations to compleate signup process.";
//TextSpan --start
  static String textSpan1 = "We did not find a match,";
  static String textSpan2 = "you are now creating a new account.";
  static String textSpan3 =
      "if you already have an account please try something different or login with Google.";
//TextSpan --end

//Facebook Login --start
  static String fbLoginCancelled = "faceBook login cancelled by user.";
  static String fbFatalError = "facebook fatal error.";
//Facebook Login --end
//Forgot password --start
  static String forgotPwdCheckEmail =
      "Please check your registered email to reset the password.";
  static String forgotPwdEmailNotFound =
      "We do not recognize this email address.";
  static String forgotPwdEnterDetails =
      "Please enter registered EMAIL/PHONE/USERNAME to reset Password.";
//Forgot password --end
//Authentication Screen --start

//Setup Screen --start
  static String setupBeforeweplaceMsg =
      "Before you place your first pages.wash, let's setup your account.";
  static String setupBeforeWeStartMsg =
      "Before we start let me introduce myself.";
  static String setupYourAssistantMsg = "I'm your assistant, give me a try.";
  static String setupLetsStartMsg =
      "Let's start by putting a face to that name.";
  static String setupLetsSetupMsg = "Let's setup your account.";
  static String setupPaymentMethod = "Payment Method";
  static String setupWardrobe = "Wardrobe";

//Setup Screen --end

//regEx constants --start
  static String regexEmail = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String regexNumber = r"^[-+]?\d*$";
  static String regexPhone = r"^[-+]?\d*$";
  static String regexTrimSpaces = r"\s+\b|\b\s";
//regEx constants --end

// Firebase Remote config parameters --start
  static const String firebaseUserOption = 'user_option_menu';
  static const String firebaseAppOption = 'app_option_menu';
  static const String firebaseFeedbackMenu = 'app_feedback_menu';
  static const String firebaseIsVoiceAssistantVisible='isVoiceAssistantVisible';
  static const String firebaseIsWashMoreVisible='isWashMoreVisible';
  static const String firebaseIsSwipeFunctionAvailable='isSwipeFunctionAvailable';
  static const String firebaseHelpCenterHome = 'helpCenterHome';

  static const String RES_IS_ACTIVE = 'is_active';
  static const String RES_MENU_ID = 'menu_id';
  static const String RES_MENU_IMAGE = 'menu_image';
  static const String RES_MENU_TITLE = 'menu_title';
// Firebase Remote config parameters --end

//WardrobePage --start
  static const String wardrobeBottomDescriptionDefault = "WashCome,";
  static const String wardrobeBottomTrailDescriptionDefault =
      " let's get you setup.";
  static const String wardrobeBottomCaptureDescriptionDefault =
      "Your camera can help me understand things better.";
  static const String wardrobeTypeOfClothesAdding =
      "What types of clothes are you adding?,";
  static const String wardrobeChooseType = "Please choose a type";

  static const String wardrobeItemAddedMessage =
      "You have successfully added item.";

//  static const String wardrobeSuccessLabel = "SUCCESS";
  static const String wardrobeOkLabel = "OK";

  //for enter name step
  static const String wardrobeNameLabel = "";
  static const String wardrobeNameBtnLabel = "";
  //for select brand step
  static const String wardrobeBrandLabel = "BRAND";
  static const String wardrobeBrandBtnLabel = "";
  //for selecting category step
  static const String wardrobeCategoryLabel = "";
  static const String wardrobeCategoryBtnLabel = "";
  //for selecting color step
  static const String wardrobeColorLabel = "COLORS";
  static const String wardrobeColorBtnLabel = "";
  //for selecting pattern
  static const String wardrobePatternLabel = "PATTERNS";
  static const String wardrobePatternBtnLabel = "";
  //for entering description of the product
  static const String wardrobeDescLabel = "DESCRIPTION";
  static const String wardrobeDescBtnLabel = "NEXT";
  static const String wardrobeDescItemMessage = "Describe it, point out things that stands out, remember we already know things like brand, color patterns.";
  static const String wardrobeDescItemTrailMessage = "";
// for confirmation step
  static const String wardrobeConfirmLabel = "";
  static const String wardrobeConfirmBtnLabel = "CONFIRM";
  static const String wardrobeConfirmItemMessage =
      "You are all done just double check that it's all right.";
  static const String wardrobeConfirmItemTrailMessage = "";

  //for item added successfully added step
   static const String wardrobeSuccessLabel = "SUCCESS";
  static const String wardrobeSuccessBtnLabel = "OK";
  static const String wardrobeSuccessMessage =
      "you have successfully added this item to your wardrobe.";

//for item added successfully imported step
   static const String wardrobeSuccessImportLabel = "SUCCESS";
  static const String wardrobeSuccessImportBtnLabel = "OK";
  static const String wardrobeSuccessImportMessage =
      "you have successfully imported this item to your wardrobe.";

  //for capture step
  static const String wardrobeCaptureLabel = "CAPTURE";
  static const String wardrobeCaptureBtnLabel = "SKIP";
  //for import step
  static const String wardrobeImportLabel = "";
  static const String wardrobeImportBtnLabel = "IMPORT";
  //for match no match found step
  static const String wardrobeNoMatchLabel = "";
  static const String wardrobeNoMatchBtnLabel = "NEXT";
  static const String wardrobeItemNotFoundMessage =
      "we could not find any data, please enter it manually.";

//WardrobePage --end
}
