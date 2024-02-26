import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram/src/core/utils/app_colors.dart';
import 'package:instagram/src/core/utils/app_enums.dart';
import 'package:instagram/src/core/utils/app_extensions.dart';

Future<bool?> buildToast({
  required ToastType toastType,
  required String msg,
}) {
  return Fluttertoast.showToast(
    msg: msg,
    backgroundColor: toastType.getColor(),
    textColor: AppColors.white,
  );
}
