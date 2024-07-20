import 'package:toast/toast.dart';

showToast(String msg) {
  Toast.show(
    msg,
    duration: 2,
    gravity: Toast.bottom,
  );
}
