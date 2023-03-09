import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class PatgptFirebaseUser {
  PatgptFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

PatgptFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<PatgptFirebaseUser> patgptFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<PatgptFirebaseUser>(
      (user) {
        currentUser = PatgptFirebaseUser(user);
        return currentUser!;
      },
    );
