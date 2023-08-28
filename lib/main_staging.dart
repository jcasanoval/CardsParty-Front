import 'package:cards_party/app/app.dart';
import 'package:cards_party/bootstrap.dart';
import 'package:cards_party/firebase_options.dart';

void main() {
  bootstrap(
    App.new,
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
  );
}
