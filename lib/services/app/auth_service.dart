import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
import 'package:house_hub/core/providers/firebase_providers/firebase_providers.dart';
import 'package:house_hub/core/providers/toast.dart';



// ignore: non_constant_identifier_names
final AuthenticationServiceProvider = Provider((ref) => AuthenticationService(auth: ref.read(firebaseAuthProvider)));


class AuthenticationService {
  
  final FirebaseAuth _auth;
  // AuthenticationService({required auth}): _auth = auth;
  // late PhoneAuthCredential _authCredential;
    late String verificationId;
    int? resendToken;

  AuthenticationService({ required auth,} ) : _auth = auth ;

void getOtp(String phone) async{
    // _auth.verifyPhoneNumber(verificationCompleted: verificationCompleted, verificationFailed: verificationFailed, codeSent: codeSent, codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
      try{
        await _auth.verifyPhoneNumber(
              phoneNumber: phone,
              timeout: const Duration(seconds: 120),
              verificationCompleted: (PhoneAuthCredential credential) {
                  
              },
              verificationFailed: (FirebaseAuthException e) {
                Toast.show(e.message.toString());
              },

              codeSent: (String verificationId, int? resendToken) {
                  this.verificationId = verificationId;
                  this.resendToken = resendToken;
              },
              codeAutoRetrievalTimeout: (String verificationId) {
                Toast.show("Timed out waiting for SMS");
              },
            );
            return;
      }on FirebaseAuthException catch(e){
      throw e.message!;
      }catch(e){
          rethrow;
        }
  }

Future<dynamic> verifyOtp(String otp) async{
    try{
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
        // Sign the user in (or link) with the credential
        final response =  await _auth.signInWithCredential(credential);
        return  response;
    } on FirebaseAuthException catch(e){
      throw e.message!;
    }
    catch(e){
      rethrow;
    }
}
}

