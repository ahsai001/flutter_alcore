import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/empty_widget.dart';
import 'package:flutter_alcore/src/app/widgets/error_widget.dart';
import 'package:flutter_alcore/src/app/widgets/loading_widget.dart';
import 'package:flutter_alcore/src/extensions/custom_extension.dart';
import 'package:loading_more_list_library/loading_more_list_library.dart';

class CustomLoadingMoreListIndicatorWidget extends StatelessWidget {
  const CustomLoadingMoreListIndicatorWidget(
    this.status, {
    super.key,
    this.firstTryAgain,
    this.moreTryAgain,
    this.backgroundColor = Colors.transparent,
    this.isSliver = false,
  });

  ///Status of indicator
  final IndicatorStatus status;

  ///call back of loading failed
  final void Function()? firstTryAgain;
  final void Function()? moreTryAgain;

  ///background color
  final Color? backgroundColor;

  ///whether it need sliver as container
  final bool isSliver;

  @override
  @override
  Widget build(BuildContext context) {
    Widget? widget;
    switch (status) {
      case IndicatorStatus.none:
        widget = Container(height: 0.0);
        break;
      case IndicatorStatus.loadingMoreBusying:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 5.0),
              child: getIndicator(context),
            ),
          ],
        );
        widget = _setbackground(false, widget, null);
        break;
      case IndicatorStatus.fullScreenBusying:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 0.0),
              child: getIndicator(context),
            ),
          ],
        );
        widget = _setbackground(true, widget, double.infinity);
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
      case IndicatorStatus.error:
        widget = CustomErrorWidget(
          onAction: moreTryAgain,
        );
        widget = _setbackground(false, widget, null);

        break;
      case IndicatorStatus.fullScreenError:
        widget = CustomErrorWidget(onAction: firstTryAgain);
        widget = _setbackground(true, widget, double.infinity);

        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
      case IndicatorStatus.noMoreLoad:
        widget = const Text('No more items.');
        widget = _setbackground(false, widget, 35.0);
        break;
      case IndicatorStatus.empty:
        widget = const CustomEmptyWidget(
            // emptyIcon: SizedBox(
            //     height: 180.0,
            //     width: 180.0,
            //     child: Image.asset(
            //       'assets/empty.jpeg',
            //       package: 'loading_more_list',
            //     )),
            );
        widget = _setbackground(true, widget, null);
        if (isSliver) {
          widget = SliverFillRemaining(
            child: widget,
          );
        } else {
          widget = CustomScrollView(
            slivers: <Widget>[
              SliverFillRemaining(
                child: widget,
              )
            ],
          );
        }
        break;
    }
    return widget;
  }

  Widget _setbackground(bool full, Widget widget, double? height) {
    widget = Container(
        width: double.infinity,
        height: height,
        color: backgroundColor ?? Colors.grey[200],
        alignment: Alignment.center,
        child: widget);
    return widget;
  }

  Widget getIndicator(BuildContext context) {
    return CustomLoadingWidget(
      loadingMessage: "loading",
      textColor: context.primaryColor,
    );
  }

  // Widget getIndicator(BuildContext context) {
  //   final ThemeData theme = Theme.of(context);
  //   return theme.platform == TargetPlatform.iOS
  //       ? const CupertinoActivityIndicator(
  //           animating: true,
  //           radius: 16.0,
  //         )
  //       : CircularProgressIndicator(
  //           strokeWidth: 2.0,
  //           valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
  //         );
  // }
}
