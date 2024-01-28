import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alcore/src/app/widgets/app_history/app_history.dart';
import 'package:flutter_alcore/src/app/widgets/color_loader.dart';
import 'package:flutter_alcore/src/app/widgets/custom_currency_input_formatter.dart';
import 'package:flutter_alcore/src/app/widgets/custom_light_theme_widget.dart';
import 'package:flutter_alcore/src/app/widgets/custom_padding.dart';
import 'package:flutter_alcore/src/app/widgets/rounded_elevated_button.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';

Widget spaceH([double h = 10]) {
  return SizedBox(height: h);
}

class SpaceHeight extends StatelessWidget {
  final double height;
  const SpaceHeight({super.key, this.height = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

Widget spaceW([double w = 10]) {
  return SizedBox(width: w);
}

class SpaceWidth extends StatelessWidget {
  final double width;
  const SpaceWidth({super.key, this.width = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

Widget spaceWH([double w = 10, double h = 10]) {
  return SizedBox(
    width: w,
    height: h,
  );
}

InputDecoration customInputDecoration(
    String hintText, String counterText, Widget suffixIcon,
    {TextStyle? hintStyle, TextStyle? errorStyle}) {
  return InputDecoration(
    counterText: counterText,
    suffixIcon: suffixIcon,
    //filled: false,
    //fillColor: color,
    hintStyle: hintStyle,
    errorStyle: errorStyle,
    hintText: hintText,
  );
}

String getMenuImagePath(String cookedName) {
  switch (cookedName) {
    case "inventory":
      return "assets/images/home_menu/inventory.png";
    case "procurement":
      return "assets/images/home_menu/folder.png";

    case "outstanding":
      return "assets/images/approval/outstanding.png";
    case "pending":
      return "assets/images/approval/pending.png";
    case "reject":
      return "assets/images/approval/reject.png";
    case "approved":
      return "assets/images/approval/approved.png";
    case "approval":
      return "assets/images/home_menu/approved.png";
    case "aging":
      return "assets/images/home_menu/aging.png";
    case "purchase":
      return "assets/images/home_menu/purchases.png";
    case "sales":
      return "assets/images/home_menu/sale.png";
    case "accounting":
      return "assets/images/home_menu/accounting.png";
    case "finance":
      return "assets/images/home_menu/finance.png";
    case "asset":
      return "assets/images/home_menu/folder.png";
    case "scan pajak":
      return "assets/images/home_menu/scan.png";
    case "equipment maintenance":
      return "assets/images/home_menu/equipment.png";
    case "minning production":
      return "assets/images/home_menu/prod.png";
    default:
      return "assets/images/home_menu/approved.png";
  }
}

String capitalize(String? str) {
  if (str == null) return '';
  return str[0].toUpperCase() + str.substring(1).toLowerCase();
}

String getCurrency(String value, {String? currencyCode, int? decimalDigits}) {
  CustomCurrencyInputFormatter formatter = CustomCurrencyInputFormatter(
      symbol: currencyCode ?? "", decimalDigits: decimalDigits ?? 2);
  return formatter.reformat(value);
}

num getValueCurrency(String value, {String? currencyCode, int? decimalDigits}) {
  CustomCurrencyInputFormatter formatter = CustomCurrencyInputFormatter(
      symbol: currencyCode ?? "", decimalDigits: decimalDigits ?? 2);
  return formatter.value(value);
}

String getNumber(String value) {
  return NumberFormat.decimalPattern().format(double.parse(value));
}

double getNumber2(String value) {
  return double.parse(value);
}

int getDateInMS(String? dateTime) {
  if (dateTime == null) return 0;
  return DateTime.parse(dateTime).millisecondsSinceEpoch;
}

Widget getKeyValueWidget(String key, String value,
    {double width = 70, bool valueIsHtml = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        width: width,
        child: Text(key),
      ),
      const Text(" : "),
      Expanded(
        child: valueIsHtml
            ? Html(data: value)
            : Text(
                value,
                overflow: TextOverflow.visible,
              ),
      ),
    ],
  );
}

void showSnackBar(BuildContext context, String info) {
  final scaffoldMessengerState = ScaffoldMessenger.of(context);
  scaffoldMessengerState.hideCurrentSnackBar();
  scaffoldMessengerState.showSnackBar(SnackBar(content: Text(info)));
}

void showComingSoonInfo(BuildContext context, String feature) {
  showSnackBar(context, "$feature coming soon...");
}

void showAboutInfo(BuildContext context, String logoAssetPath,
    List<AppHistoryItem> Function() getHistoryList) async {
  final packageInfo = await PackageInfo.fromPlatform();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    showCustomAboutDialog(
        context: context,
        applicationIcon:
            SizedBox(width: 60, height: 60, child: Image.asset(logoAssetPath)),
        applicationName: packageInfo.appName,
        applicationVersion: packageInfo.version,
        children: [
          RoundedElevatedButton(
              onPressed: () {
                pushNewPage(
                    context,
                    (context) => AppHistoryPage(
                          getHistoryList: getHistoryList,
                        ));
              },
              child: const Text("Riwayat Aplikasi"))
        ]);
  });
}

void showCustomAboutDialog({
  required BuildContext context,
  String? applicationName,
  String? applicationVersion,
  Widget? applicationIcon,
  String? applicationLegalese,
  List<Widget>? children,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) {
  showDialog<void>(
    context: context,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext context) {
      final ThemeData theme = Theme.of(context);
      return Theme(
        data: theme.copyWith(
            textTheme: theme.textTheme.copyWith(
          headlineSmall: theme.textTheme.headlineSmall?.copyWith(fontSize: 18),
          bodyMedium: const TextStyle(color: Colors.black),
        )),
        child: AboutDialog(
          applicationName: applicationName,
          applicationVersion: applicationVersion,
          applicationIcon: applicationIcon,
          applicationLegalese: applicationLegalese,
          children: children,
        ),
      );
    },
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
  );
}

DateTime? getDateTime(String? value,
    {String? fromFormat,
    bool isFromUtc = false,
    bool isToUtc = false,
    String? timeZone}) {
  if (value == null) return null;
  if (value.isEmpty) return null;

  if (isFromUtc) {
    if (!value.endsWith("Z")) {
      value = "${value}Z";
    }
  }

  var parsedDate = (fromFormat != null
      ? DateFormat(fromFormat).parse(value, isFromUtc)
      : DateTime.parse(value));

  Duration? offset;

  if (timeZone != null && timeZone.isNotEmpty) {
    offset = getOffsetFromTimeZone(timeZone);
  }

  if (isFromUtc && !isToUtc) {
    if (offset != null) {
      parsedDate = parsedDate.add(offset);
    } else {
      parsedDate = parsedDate.toLocal();
    }
  }

  if (!isFromUtc && isToUtc) {
    if (offset != null) {
      parsedDate = parsedDate.add(offset);
    } else {
      parsedDate = parsedDate.toUtc();
    }
  }

  return parsedDate;
}

String convertDateTime(String? value,
    {String? fromFormat,
    String? toFormat,
    bool isFromUtc = false,
    bool isToUtc = false,
    String? timeZone}) {
  if (value == null) return "-";
  if (value.isEmpty) return "-";

  var parsedDate = (fromFormat != null
      ? DateFormat(fromFormat).parse(value, isFromUtc)
      : DateTime.parse(value));

  Duration? offset;

  if (timeZone != null && timeZone.isNotEmpty) {
    offset = getOffsetFromTimeZone(timeZone);
  }

  if (isFromUtc && !isToUtc) {
    if (offset != null) {
      parsedDate = parsedDate.add(offset);
    } else {
      parsedDate = parsedDate.toLocal();
    }
  }

  if (!isFromUtc && isToUtc) {
    if (offset != null) {
      parsedDate = parsedDate.add(offset);
    } else {
      parsedDate = parsedDate.toUtc();
    }
  }
  return DateFormat(toFormat ?? "dd MMM yyyy").format(parsedDate);
}

String getTimeZoneFromOffset(Duration timezoneOffset, {String separator = ""}) {
  var hours = timezoneOffset.inHours > 0 ? timezoneOffset.inHours : 1;
  var result = "";
  if (!timezoneOffset.isNegative) {
    result =
        "$result+${timezoneOffset.inHours.toString().padLeft(2, '0')}$separator${(timezoneOffset.inMinutes % (hours * 60)).toString().padLeft(2, '0')}";
  } else {
    result =
        "$result-${(-timezoneOffset.inHours).toString().padLeft(2, '0')}$separator${(timezoneOffset.inMinutes % (hours * 60)).toString().padLeft(2, '0')}";
  }
  return result;
}

Duration getOffsetFromTimeZone(String timeZone, {String separator = ""}) {
  timeZone = timeZone.replaceAll(separator, "");
  bool isNegative = timeZone.contains("-");
  int hour = int.parse(timeZone.substring(1, 3));
  int minutes = int.parse(timeZone.substring(3, 5));
  final duration = Duration(hours: hour, minutes: minutes);
  return isNegative ? Duration.zero - duration : duration;
}

String handleNullEmpty(String? value) {
  if (value == null) return "-";
  if (value.isEmpty) return "-";
  return value;
}

Logger logger() {
  return GetIt.I.get<Logger>();
}

void clickedAction(String? payload) {
  if (payload == null || payload.isEmpty) return;
  var arrayString = payload.split(" # ");

  String tt = arrayString[0];
  String numb = arrayString[1];
  String db = arrayString[2];

  String sub_text = tt.substring(0, 2);
}

void notificationResponse(NotificationResponse response) {
  clickedAction(response.payload);
}

String titleCase(String name) {
  final stringBuffer = StringBuffer();

  var capitalizeNext = true;
  for (final letter in name.toLowerCase().codeUnits) {
    // UTF-16: A-Z => 65-90, a-z => 97-122.
    if (capitalizeNext && letter >= 97 && letter <= 122) {
      stringBuffer.writeCharCode(letter - 32);
      capitalizeNext = false;
    } else {
      // UTF-16: 32 == space, 46 == period
      if (letter == 32 || letter == 46) capitalizeNext = true;
      stringBuffer.writeCharCode(letter);
    }
  }

  return stringBuffer.toString();
}

Widget makeScrollable(Widget w,
    {double width = 2000.0, double height = 2000.0}) {
  return Scrollbar(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
              width: width,
              height: height,
              child: ListView(
                children: [
                  SizedBox(
                    width: width,
                    height: height,
                    child: w,
                  )
                ],
              ))));
}

Future<void> showWidgetsInDialog(
    BuildContext context, String title, Widget widget,
    {void Function(BuildContext)? actionFunction,
    String actionTitle = "Retrieve",
    final ThemeData Function(ThemeData)? modifyTheme,
    String closeTitle = "Close"}) async {
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomLightThemeWidget(
          modifyTheme: modifyTheme,
          child: AlertDialog(
            title: AppBar(
              title: Text(title,
                  style: const TextStyle(
                    fontSize: 14,
                  )),
              centerTitle: true,
              primary: false,
              automaticallyImplyLeading: false,
            ),
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(0),
            content: StatefulBuilder(builder: (context, setState) {
              final ScrollController controller = ScrollController();
              return Scrollbar(
                thumbVisibility: true,
                controller: controller,
                child: CustomPadding(
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                        mainAxisSize: MainAxisSize.min, children: [widget]),
                  ),
                ),
              );
            }),
            actions: [
              if (actionFunction != null)
                RoundedElevatedButton(
                    onPressed: () {
                      actionFunction(context);
                    },
                    child: Text(actionTitle)),
              RoundedElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(closeTitle))
            ],
          ),
        );
      });
}

Future<void> showConfirmationDialog(
    BuildContext context, String title, String body,
    {void Function(BuildContext)? actionFunction,
    String actionTitle = "Yes",
    String closeTitle = "No"}) async {
  await showWidgetsInDialog(context, title, Text(body),
      actionFunction: actionFunction,
      actionTitle: actionTitle,
      closeTitle: closeTitle);
}

Future<void> showStatefullWidgetsInDialog<I extends Object, O extends Object>(
  BuildContext context,
  String title,
  Widget Function(BuildContext context, I? request, StateSetter stateSetter)
      bodyBuilder, {
  Future<O> Function(BuildContext context, I? request, StateSetter stateSetter)?
      actionFunction,
  String actionTitle = "Retrieve",
  String closeTitle = "Close",
  I? Function(BuildContext context)? getRequest,
  Widget Function(BuildContext context, I? request, StateSetter stateSetter)?
      titleBuilder,
  List<Widget> Function(
          BuildContext context,
          I? request,
          Future<O> Function(
                  BuildContext context, I? request, StateSetter stateSetter)?
              actionFunction,
          StateSetter stateSetter)?
      actionBuilder,
  final ThemeData Function(ThemeData)? modifyTheme,
}) async {
  await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      // transitionBuilder: (context, animation, secondaryAnimation, child) {
      //   const begin = Offset(0.0, 1.0);
      //   const end = Offset.zero;
      //   const curve = Curves.ease;

      //   final tween = Tween(begin: begin, end: end);
      //   final curvedAnimation = CurvedAnimation(
      //     parent: animation,
      //     curve: curve,
      //   );

      //   return SlideTransition(
      //     position: tween.animate(curvedAnimation),
      //     child: child,
      //   );
      // },
      pageBuilder: (BuildContext context, animIn, animOut) {
        I? request = getRequest?.call(context);
        return CustomLightThemeWidget(
          modifyTheme: modifyTheme,
          child: StatefulBuilder(builder: (context, setState) {
            final ScrollController controller = ScrollController();
            return WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: AlertDialog(
                title: AppBar(
                  title: titleBuilder != null
                      ? titleBuilder.call(context, request, setState)
                      : Text(title,
                          overflow: TextOverflow.visible,
                          softWrap: true,
                          style: const TextStyle(fontSize: 14, height: 1.2)),
                  centerTitle: true,
                  primary: false,
                  automaticallyImplyLeading: false,
                ),
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: Scrollbar(
                  thumbVisibility: true,
                  controller: controller,
                  child: CustomPadding(
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [bodyBuilder(context, request, setState)]),
                    ),
                  ),
                ),
                actions: actionBuilder != null
                    ? actionBuilder.call(
                        context, request, actionFunction, setState)
                    : [
                        if (actionFunction != null)
                          RoundedElevatedButton(
                              onPressed: () async {
                                await actionFunction(
                                    context, request, setState);
                              },
                              child: Text(actionTitle)),
                        RoundedElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(closeTitle))
                      ],
              ),
            );
          }),
        );
      });
}

enum ProcessDialogState {
  initial,
  processing,
  success,
  error,
}

extension ProcessDialogStateExtension on ProcessDialogState {
  Icon getIconBasedOnProcessState() {
    return Icon(
      switch (this) {
        ProcessDialogState.initial => Icons.info,
        ProcessDialogState.processing => Icons.wifi_protected_setup_sharp,
        ProcessDialogState.success => Icons.done,
        ProcessDialogState.error => Icons.error,
      },
      size: 35,
    );
  }

  String getFullTitleBasedOnProcessState(String title) {
    return switch (this) {
      ProcessDialogState.initial => "$title Confirmation",
      ProcessDialogState.processing => "$title Processing",
      ProcessDialogState.success => "$title Success",
      ProcessDialogState.error => "$title Error",
    };
  }

  bool isProcessing() {
    return this == ProcessDialogState.processing;
  }

  bool isSuccess() {
    return this == ProcessDialogState.success;
  }

  bool isError() {
    return this == ProcessDialogState.error;
  }
}

Future<void>
    showConfirmationAndProcessingDialog<I extends Object, O extends Object>(
        BuildContext context, String title, String confirmationBody,
        {required Future<O> Function(BuildContext context, I? request)
            actionFunction,
        required bool Function(O response) isSuccessfull,
        required String Function(O response) getMessage,
        String actionTitle = "Yes",
        String closeTitle = "No",
        String retryTitle = "Retry",
        Widget Function(BuildContext context, I? request,
                ProcessDialogState processState, StateSetter stateSetter)?
            extraBodyBuilder,
        I? Function(BuildContext context)? getRequest,
        void Function(I? request, O? response, String? message,
                ProcessDialogState state)?
            resultCallback,
        String processingBody = "Please wait, processing your request",
        String successBody = "Good, Result is okay",
        String errorBody = "Oops, There is an error",
        String doneTitle = "Done"}) async {
  ProcessDialogState processState = ProcessDialogState.initial;
  O? result;
  String? message;

  await showStatefullWidgetsInDialog<I, O>(
      context,
      title,
      (context, request, stateSetter) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (extraBodyBuilder != null)
              extraBodyBuilder.call(
                  context, request, processState, stateSetter),
            if (extraBodyBuilder != null) const SpaceHeight(),
            Text(switch (processState) {
              ProcessDialogState.initial => confirmationBody,
              ProcessDialogState.processing => processingBody,
              ProcessDialogState.success => message ?? successBody,
              ProcessDialogState.error => message ?? errorBody,
            }),
          ],
        );
      },
      getRequest: getRequest,
      actionFunction: (context, request, stateSetter) async {
        return actionFunction.call(context, request);
      },
      titleBuilder: (context, request, stateSetter) {
        return Row(
          children: [
            processState.getIconBasedOnProcessState(),
            const SpaceWidth(),
            Expanded(
              child: Text(processState.getFullTitleBasedOnProcessState(title),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: const TextStyle(fontSize: 14, height: 1.2)),
            ),
          ],
        );
      },
      actionBuilder: (context, request, actionFunction, stateSetter) {
        return [
          if (actionFunction != null && !processState.isSuccess())
            RoundedElevatedButton(
                onPressed: processState.isProcessing()
                    ? null
                    : () async {
                        try {
                          stateSetter.call(
                            () {
                              processState = ProcessDialogState.processing;
                            },
                          );
                          result = await actionFunction.call(
                              context, request, stateSetter);
                          if (isSuccessfull(result!)) {
                            stateSetter.call(
                              () {
                                message = getMessage(result!);
                                processState = ProcessDialogState.success;
                              },
                            );
                            resultCallback?.call(
                                request,
                                result,
                                getMessage(result!),
                                ProcessDialogState.success);
                          } else {
                            stateSetter.call(
                              () {
                                message = getMessage(result!);
                                processState = ProcessDialogState.error;
                              },
                            );
                            resultCallback?.call(request, result,
                                getMessage(result!), ProcessDialogState.error);
                          }
                        } on Exception catch (e) {
                          stateSetter.call(
                            () {
                              message = e.toString();
                              processState = ProcessDialogState.error;
                            },
                          );
                          resultCallback?.call(request, result, e.toString(),
                              ProcessDialogState.error);
                        }
                      },
                child: processState.isProcessing()
                    ? const ColorLoader(
                        radius: 12,
                      )
                    : Text(processState.isError() ? retryTitle : actionTitle)),
          RoundedElevatedButton(
              onPressed: processState.isProcessing()
                  ? null
                  : () {
                      Navigator.of(context).pop();
                    },
              child: Text(processState.isSuccess() ? doneTitle : closeTitle))
        ];
      },
      actionTitle: actionTitle,
      closeTitle: closeTitle);
}

void restartApp(BuildContext context, Widget Function(BuildContext) builder) {
  Navigator.of(context, rootNavigator: true)
      .pushAndRemoveUntil(MaterialPageRoute(builder: builder), (route) {
    return false;
  });
}

int get globalYearPeriodSelection => 20;

Future<T?> pushNewPage<T extends Object?>(
    BuildContext context, WidgetBuilder builder,
    {bool rootNavigator = false, bool useTransition = false}) {
  if (useTransition) return pushNewPageWithTransition(context, builder);
  return Navigator.of(context, rootNavigator: rootNavigator)
      .push(MaterialPageRoute(builder: builder));
}

Future<T?> pushNewPageWithTransition<T extends Object?>(
    BuildContext context, WidgetBuilder builder,
    {bool rootNavigator = false}) {
  return Navigator.of(context, rootNavigator: rootNavigator)
      .push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return builder(context);
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  ));
}

Future<T?> pushReplaceNewPage<T extends Object?>(
    BuildContext context, WidgetBuilder builder,
    {bool rootNavigator = false}) {
  return Navigator.of(context, rootNavigator: rootNavigator)
      .pushReplacement(MaterialPageRoute(builder: builder));
}

Future<T?> pushNewPageRemoveUntil<T extends Object?>(
    BuildContext context, WidgetBuilder builder, RoutePredicate predicate,
    {bool rootNavigator = false}) {
  return Navigator.of(context, rootNavigator: rootNavigator)
      .pushAndRemoveUntil(MaterialPageRoute(builder: builder), predicate);
}

void popBack<T extends Object?>(BuildContext context,
    {bool rootNavigator = false, T? result}) {
  Navigator.of(context, rootNavigator: rootNavigator).pop(result);
}

Future<bool> isInternetConnected() async {
  bool isDeviceConnected = false;
  final connectionStatus = await Connectivity().checkConnectivity();
  if (connectionStatus != ConnectivityResult.none) {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
  }
  return isDeviceConnected;
}

Future<LocationData> getLatestPosition() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return Future.error('Location permissions are denied');
    }
  }

  return await location.getLocation();
}

Stream<LocationData> getStreamPosition(
    {void Function()? callbackAfterPermissionDone}) async* {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      yield* Stream.error('Location services are disabled.');
    }
  }
  if (serviceEnabled) {
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted == PermissionStatus.denied) {
        yield* Stream.error('Location permissions are denied');
      } else if (permissionGranted == PermissionStatus.deniedForever) {
        yield* Stream.error(
            'Location permissions are denied forever, you can enabled it from application setting');
      }
    }

    callbackAfterPermissionDone?.call();

    if (permissionGranted == PermissionStatus.granted) {
      location.changeSettings(interval: 5000);
      yield* location.onLocationChanged;
    }
  } else {
    callbackAfterPermissionDone?.call();
  }
}

// Future<Position> getLatestPosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
// }

double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
  double radEarth = 6.3781 * (pow(10.0, 6.0));
  double phi1 = lat1 * (pi / 180);
  double phi2 = lat2 * (pi / 180);

  double delta1 = (lat2 - lat1) * (pi / 180);
  double delta2 = (lng2 - lng1) * (pi / 180);

  double cal1 = sin(delta1 / 2) * sin(delta1 / 2) +
      (cos(phi1) * cos(phi2) * sin(delta2 / 2) * sin(delta2 / 2));

  double cal2 = 2 * atan2((sqrt(cal1)), (sqrt(1 - cal1)));
  double distance = radEarth * cal2;

  return distance;
}

class DeviceDetailInfo {
  final String? deviceId;
  final String? deviceBrand;
  final String? deviceModel;
  final String? osName;
  final String? osVersion;
  const DeviceDetailInfo(this.deviceId, this.deviceBrand, this.deviceModel,
      this.osName, this.osVersion);
}

Future<DeviceDetailInfo?> getDeviceDetailInfo() async {
  DeviceDetailInfo? deviceDetailInfo;
  try {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      deviceDetailInfo = DeviceDetailInfo(androidInfo.id, androidInfo.brand,
          androidInfo.model, "android", androidInfo.version.release);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceDetailInfo = DeviceDetailInfo(
          iosInfo.identifierForVendor,
          iosInfo.localizedModel,
          iosInfo.name,
          iosInfo.systemName,
          iosInfo.systemVersion);
    }
  } on PlatformException {
    deviceDetailInfo = null;
  }
  return deviceDetailInfo;
}
