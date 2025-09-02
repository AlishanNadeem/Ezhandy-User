// import 'dart:convert';
// import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:ezhandy_user/module/auth/controller/auth_controller.dart';
// import 'package:ezhandy_user/utils/app_strings.dart';

// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// class SocialAuthGetX {
//   // SocialLoginGetX _socialLoginGetX = SocialLoginGetX();

//   // final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   // Future signInWithGoogle() async {
//   //
//   //
//   // }
//   UserCredential? _userCredential;
//   User? _user;

//   ///-------------------- Firebase Auth Token Function -------------------- ///

//   final FirebaseAuth _firebase_auth = FirebaseAuth.instance;
//   String? token;

//   Future<String?> _firebaseSignIn(AuthCredential authCredential) async {
//     String? token;
//     await _firebase_auth.signInWithCredential(authCredential).then((userCredential) async {
//       token = await userCredential.user!.getIdToken();
//     }).catchError((ex) {
//       print("firebase auth exception: ${ex}");
//       // AppMessage.handleException(ex);
//     });
//     return token;
//   }

//   ///-------------------- Google Sign In -------------------- ///
//   Future<void> signInWithGoogle({context, String? authName}) async {
//     try {
//       GoogleSignIn _googleSignIn = GoogleSignIn(
//         scopes: ['email'],
//       );

//       GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();

//       // GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

//       // var authResult = await _auth.signInWithCredential(credential);
//       // var _user = authResult.user;
//       // assert(!_user!.isAnonymous);
//       // var currentUser = await _auth.currentUser!;
//       //
//       //
//       // print("User Name: ${currentUser.displayName}");
//       // print("User Email ${currentUser.email}");

//       if (_googleSignInAccount != null) {
//         // log("Access Token"+data.accessToken);

//         GoogleSignInAuthentication googleSignInAuthentication = await _googleSignInAccount.authentication;
//         AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );
//         token = await _firebaseSignIn(credential);
//         print("Google Token is: $token");
//         print("Google accessToken is: ${googleSignInAuthentication.accessToken}");
//         print("test");

//         await _googleSignIn.signOut();
//         // print(_googleSignInAccount);
//         print(
//           _googleSignInAccount.id,
//         );
//         print(
//           _googleSignInAccount.displayName,
//         );
//         print(
//           _googleSignInAccount.email,
//         );
//         print(
//           _googleSignInAccount.photoUrl,
//         );
//         //log("Google Sign in Account"+_googleSignInAccount.toString());
//         AuthController.i.socialLoginFunction(
//           context,
//           social_token: googleSignInAuthentication.idToken,
//           social_type: "google",
//           // user_type: AppConstant.is_user?"user": "business",
//         );
//       }
//     } catch (error) {
//       print("error");
//       log(error.toString());
//       // AppDialogs.showToast(message: error.toString());
//     }
//   }

//   ///-------------------- Facebook Sign In -------------------- ///
//   // Future<void> signInWithFacebook(
//   //     {BuildContext? context, String? authName, String? accessTok}) async {
//   //   try {
//   //     final LoginResult result = await FacebookAuth.instance.login(
//   //       permissions: ['public_profile', 'email', 'user_friends'],
//   //     );

//   //     if (result.status == LoginStatus.success) {
//   //       final AccessToken? accessToken = result.accessToken;

//   //       print("result.accessToken!.token");
//   //       print(result.accessToken!.token);

//   //       final OAuthCredential facebookAuthCredential =
//   //           FacebookAuthProvider.credential(result.accessToken!.token);
//   //       token = await _firebaseSignIn(facebookAuthCredential);
//   //       log("token is: $token");

//   //       final graphResponse = await http.get(Uri.parse(
//   //           'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${accessToken!.token}'));

//   //       log("Graph response" + graphResponse.body.toString());
//   //       await FacebookAuth.instance.logOut();

//   //       final String fbGraphResponse = graphResponse.body;
//   //       if (fbGraphResponse != null) {
//   //         FacebookGraphModel _fbGraphModel =
//   //             FacebookGraphModel.fromJson(jsonDecode(fbGraphResponse));
//   //         print("_fbGraphModel.email");
//   //         print(_fbGraphModel.email);

//   //         AuthController.i.socialLoginFunc(
//   //           name: _fbGraphModel.name,
//   //           email: _fbGraphModel.email,
//   //           socialType: "facebook",
//   //           token: token,
//   //         );
//   //         // _socialLoginMethod(
//   //         //   context!,
//   //         //   authName: authName,
//   //         //   socialToken: token,
//   //         //   email: _fbGraphModel.email ?? "",
//   //         //   userName: _fbGraphModel.name ?? "",
//   //         //   // userFirstName: _fbGraphModel.name ?? "",
//   //         //   // userLastName: "",
//   //         //   // userEmail: _fbGraphModel.email ?? "",
//   //         //
//   //         // );

//   //       }
//   //     } else if (result.status == LoginStatus.failed) {
//   //       AppDialogs.showToast(message: result.message.toString());
//   //       //print(result.message.toString());
//   //     } else if (result.status == LoginStatus.cancelled) {
//   //       AppDialogs.showToast(message: result.message.toString());
//   //       //print(result.message.toString());
//   //     }
//   //   } catch (error) {
//   //     print(error.toString());
//   //     AppDialogs.showToast(message: error.toString());
//   //   }
//   // }

//   // TextEditingController phoneNumber = TextEditingController();
//   TextEditingController otpCode = TextEditingController();
//   // bool isLoading = false;
//   String? verificationId;

//   // /-------------------- Phone Authentication Sign In -------------------- ///
//   // Future<void> signInWithPhoneNumber({BuildContext? context,required String phoneNumber}) async {
//   //   await _firebase_auth.verifyPhoneNumber(
//   //       phoneNumber: phoneNumber,
//   //       verificationCompleted: _onVerificationCompleted,
//   //       verificationFailed: _onVerificationFailed,
//   //       codeSent: _onCodeSent,
//   //       codeAutoRetrievalTimeout: _onCodeTimeout);
//   // }

//   // _onVerificationCompleted(PhoneAuthCredential authCredential) async {
//   //   print("verification completed ${authCredential.smsCode}");
//   //   User? user = FirebaseAuth.instance.currentUser;

//   //   this.otpCode.text = authCredential.smsCode!;
//   //   // setState(() {
//   //   //
//   //   // });
//   //   if (authCredential.smsCode != null) {
//   //     try{
//   //       UserCredential credential =
//   //       await user!.linkWithCredential(authCredential);
//   //     }on FirebaseAuthException catch(e){
//   //       if(e.code == 'provider-already-linked'){
//   //         await _firebase_auth.signInWithCredential(authCredential);
//   //       }
//   //     }
//   //     stopLoader();
//   //     Get.offAllNamed(Paths.BOTTOM_NAVIGATION_BAR_SCREEN_ROUTE);
//   //   }
//   // }

//   // _onVerificationFailed(FirebaseAuthException exception) {
//   //   if (exception.code == 'invalid-phone-number') {
//   //     // showMessage("The phone number entered is invalid!");
//   //     Get.snackbar("ERROR", "The phone number entered is invalid!");
//   //   }
//   // }

//   // _onCodeSent(String verificationId, int? forceResendingToken) {
//   //   this.verificationId = verificationId;
//   //   print(forceResendingToken);
//   //   print("code sent");
//   //   Get.offNamed(Paths.OTP_VERIFICATION_SCREEN_ROUTE,arguments: 'phone');
//   // }

//   // _onCodeTimeout(String timeout) {
//   //   return null;
//   // }

//   // void showMessage(String errorMessage, context) {
//   //   showDialog(
//   //       context: context,
//   //       builder: (BuildContext builderContext) {
//   //         return AlertDialog(
//   //           title: Text("Error"),
//   //           content: Text(errorMessage),
//   //           actions: [
//   //             TextButton(
//   //               child: Text("Ok"),
//   //               onPressed: () async {
//   //                 Navigator.of(builderContext).pop();
//   //               },
//   //             )
//   //           ],
//   //         );
//   //       }).then((value) {
//   //     // setState(() {
//   //    stopLoader();
//   //     // });
//   //   });
//   // }

//   //-------------------- Apple Sign In -------------------- //

//   Future<void> signInWithApple({BuildContext? context, String? authName}) async {
//     try {
//       log("apple data");
//       final credential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//       );

//       final AuthCredential authCredential = OAuthProvider("apple.com").credential(
//         idToken: credential.identityToken,
//         //  rawNonce: rawNonce,
//       );

//       token = await _firebaseSignIn(authCredential);
//       if (credential != null) {
//         log("credential.email");
//         log(credential.email.toString());
//         log("credential.givenName");
//         log(credential.givenName.toString());
//         // log("Apple Credentail:${credential}");
//         // log("Auth text:${authName}");
//         // log("Social Token:${credential.identifier}");
//         // log("User Name:${credential.givenName}");
//         // log("family Name:${credential.familyName}");
//         // log("Email Name:${credential.email}");
//         AuthController.i.socialLoginFunction(
//           context,
//           social_token: credential.identityToken,
//           social_type: "apple",
//           // user_type: AppConstant.is_user?"user": "business",
//           firstName: credential.givenName ?? "New",
//           lastName: credential.familyName ?? "User",
//         );
//         // _socialLoginMethod(
//         //   context!,
//         //   authName: authName,
//         //   socialToken: credential.identifier,
//         //   // userFirstName: credential.givenName ?? "",
//         //   // userLastName: credential.familyName ?? "",
//         //   // userEmail: credential.email ?? "",
//         //
//         // );
//       }
//     } catch (error) {
//       print(error.toString());
//       // Get.snackbar("Alert", error.toString());
//       // AppDialogs.showToast(message: error.toString());
//     }
//   }

//   // ////////////////////////// Phone Sign In //////////////////////////////////
//   // Future<void> signInWithPhone(
//   //     {required BuildContext context,
//   //     required String iso_code,
//   //     required String country_code,
//   //     required String phoneNumber,
//   //     required VoidCallback setProgressBar,
//   //     required VoidCallback cancelProgressBar}) async {
//   //   try {
//   //     log("phoneNumber");
//   //     log(country_code + phoneNumber);
//   //     setProgressBar();
//   //     FirebaseAuth.instance.verifyPhoneNumber(
//   //         phoneNumber: country_code + phoneNumber,
//   //         timeout: Duration(seconds: 60),
//   //         verificationCompleted: (AuthCredential authCredential) async {
//   //           print("verification completed");
//   //         },
//   //         verificationFailed: (FirebaseAuthException authException) {
//   //           if (authException.code == AppStrings.INVALID_PHONE) {
//   //             cancelProgressBar();

//   //             Toast_Message(toastmsg: AppStrings.INVALID_PHONE);
//   //           } else {
//   //             cancelProgressBar();
//   //             Toast_Message(toastmsg: authException.message.toString());
//   //           }
//   //           //print(authException.message);
//   //         },
//   //         codeSent: (String verificationId, int? forceResendingToken) {
//   //           //log("Verification Id:${verificationId}");
//   //           cancelProgressBar();
//   //           Get.offNamed(Paths.OTP_VERIFICATION_SCREEN_ROUTE, arguments: [
//   //             verificationId,
//   //             phoneNumber,
//   //             iso_code,
//   //             country_code,
//   //             'phone',
//   //           ]);
//   //           // AppNavigation.navigateTo(context, AppRouteName.VERIFY_OTP_SCREEN_ROUTE,
//   //           //     arguments: OtpArguments(
//   //           //         checkOtpType: AppStrings.PHONE_OTP_CHECK_TEXT,
//   //           //         phoneNumber: phoneNumber,
//   //           //         verificationId: verificationId
//   //           //     )
//   //           // );
//   //         },
//   //         codeAutoRetrievalTimeout: (String verificationId) {
//   //           log("Timeout Verification id:${verificationId.toString()}");
//   //         });
//   //   } catch (error) {
//   //     log("error");
//   //     cancelProgressBar();
//   //     Toast_Message(toastmsg: error.toString());
//   //   }
//   // }

//   // Future<void> verifyPhoneCode(
//   //     {required BuildContext context,
//   //     String? iso_code,
//   //     String? country_code,
//   //     String? socialType,
//   //     String? phone_number,
//   //     required String verificationId,
//   //     required String verificationCode}) async {
//   //   try {
//   //     print("Verify Phone Code Starts");

//   //     AuthCredential _credential = PhoneAuthProvider.credential(
//   //         verificationId: verificationId, smsCode: verificationCode);

//   //     _userCredential = await _firebase_auth.signInWithCredential(_credential);

//   //     _user = _userCredential?.user;

//   //     if (_user != null) {
//   //       await firebaseUserSignOut();

//   //       log("Social Type: $socialType");
//   //       log("Social Token: ${_user!.uid}");

//   //       // API Call Here
//   //       _socialLoginMethod(context,
//   //           socialToken: _user!.uid,
//   //           iso_code: iso_code,
//   //           country_code: country_code,
//   //           phone_number: phone_number);
//   //     }
//   //   } catch (error) {
//   //     print(error);
//   //     if(error.toString()=="[firebase_auth/invalid-verification-code] The multifactor verification code used to create the auth credential is invalid.Re-collect the verification code and be sure to use the verification code provided by the user."){

//   //     Toast_Message(toastmsg: "Invalid Otp");
//   //     }else{

//   //     Toast_Message(toastmsg: error.toString());
//   //     }
//   //   }
//   // }

//   // Future<void> resendPhoneCode(
//   //     {required BuildContext context,
//   //     String? iso_code,
//   //     String? country_code,
//   //     required String phoneNumber,
//   //     required ValueChanged<String?> getVerificationId,
//   //     required VoidCallback setProgressBar,
//   //     required VoidCallback cancelProgressBar}) async {
//   //   setProgressBar();
//   //   try {
//   //     _firebase_auth.verifyPhoneNumber(
//   //         phoneNumber: country_code! + phoneNumber,
//   //         timeout: Duration(seconds: 60),
//   //         verificationCompleted: (AuthCredential authCredential) async {},
//   //         verificationFailed: (FirebaseAuthException authException) {
//   //           cancelProgressBar();
//   //           Toast_Message(toastmsg: authException.message.toString());
//   //           //print(authException.message);
//   //         },
//   //         codeSent: (String verificationId, int? forceResendingToken) {
//   //           cancelProgressBar();
//   //           getVerificationId(verificationId);
//   //           Toast_Message(toastmsg: "Verification Code resend");
//   //           AuthController.i.countDownController.value.start();
//   //         },
//   //         codeAutoRetrievalTimeout: (String verificationId) {
//   //           log(verificationId.toString());
//   //         });
//   //   } catch (error) {
//   //     cancelProgressBar();
//   //     Toast_Message(toastmsg: error.toString());
//   //   }
//   // }

//   // void _socialLoginMethod(
//   //   BuildContext context, {
//   //   String? socialToken,
//   //   String? phone_number,
//   //   String? country_code,
//   //   String? iso_code,
//   // }) {
//   //   AuthController.i.socialLoginFunction(
//   //     iso_code: iso_code,
//   //     country_code: country_code,
//   //     phone_number: phone_number,
//   //     social_token: socialToken,
//   //     social_type: "phone",
//   //     // user_type: AppConstant.is_user?"user": "business",
//   //   );
//   // }

//   ///-------------------- Sign Out -------------------- ///
//   Future<void> firebaseUserSignOut() async {
//     await _firebase_auth.signOut();
//   }
// }
