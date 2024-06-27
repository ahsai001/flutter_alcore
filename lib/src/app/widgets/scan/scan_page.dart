import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_alcore/src/app/widgets/color_loader.dart';
import 'package:flutter_alcore/src/app/widgets/scan/scanner_error_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// updated 02 december 2023
class ScannerPage extends StatefulWidget {
  final String? title;
  final Future<void> Function(BuildContext context, String code,
      Barcode barcode, BarcodeCapture? argument)? onSuccessCallback;
  final void Function(BuildContext context)? onFailedCallback;
  final MobileScannerController controller;
  final bool manualScan;
  final String? messageWhenProcessingResult;
  final Widget? loadingWidgetWhenProcessingResult;
  final List<Widget>? customVerticalWidgets;
  final String? assetImage;
  const ScannerPage(
      {Key? key,
      this.title,
      this.onSuccessCallback,
      this.onFailedCallback,
      required this.controller,
      this.manualScan = false,
      this.messageWhenProcessingResult,
      this.loadingWidgetWhenProcessingResult,
      this.customVerticalWidgets,
      this.assetImage})
      : super(key: key);

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  Barcode? barcode;
  BarcodeCapture? capture;
  //double _progress = 0.0;
  late Animation<double> animation;
  bool manualScanActive = false;
  bool isProcessingResult = false;

  Future<void> onDetect(BarcodeCapture barcode) async {
    if (widget.manualScan && manualScanActive == false) {
      return;
    }
    capture = barcode;
    setState(() => this.barcode = barcode.barcodes.first);
    if (barcode.barcodes.first.rawValue == null) {
      debugPrint('Failed to scan Barcode');
      widget.onFailedCallback?.call(context);
    } else {
      final String code = barcode.barcodes.first.rawValue!;
      debugPrint('Barcode found! $code');
      widget.controller.stop();
      if (widget.onSuccessCallback != null) {
        setState(() {
          this.barcode = null;
          if (widget.manualScan) {
            manualScanActive = false;
          }
          isProcessingResult = true;
        });

        await widget.onSuccessCallback!(
            context, code, barcode.barcodes.first, barcode);
        setState(() {
          isProcessingResult = false;
        });
      } else {
        Navigator.of(context).pop(code);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.of(context).size.center(Offset.zero),
      width: 200,
      height: 200,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Builder(
        builder: (context) {
          return Stack(
            fit: StackFit.expand,
            children: [
              RotatedBox(
                quarterTurns:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 0
                        : 3,
                child: MobileScanner(
                  fit: BoxFit.contain,
                  scanWindow: scanWindow,
                  controller: widget.controller,
                  errorBuilder: (context, exception, widget) {
                    return ScannerErrorWidget(error: exception);
                  },
                  placeholderBuilder: ((context, widget) {
                    return Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: this.widget.assetImage != null
                          ? Image.asset(
                              this.widget.assetImage!,
                              width: scanWindow.width,
                              height: scanWindow.height,
                            )
                          : null,
                    );
                  }),
                  onDetect: onDetect,
                ),
              ),
              if (barcode != null && barcode?.corners != null)
                CustomPaint(
                  painter: BarcodeOverlay(
                    barcode: barcode!,
                    boxFit: BoxFit.contain,
                    capture: capture!,
                  ),
                ),
              if (widget.manualScan && manualScanActive) MovingLine(scanWindow),
              if (!widget.manualScan) MovingLine(scanWindow),
              CustomPaint(
                painter: ScannerOverlay(scanWindow),
              ),
              if (isProcessingResult)
                Center(
                  child: (widget.loadingWidgetWhenProcessingResult ??
                      const ColorLoader()),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MediaQuery.of(context).orientation ==
                        Orientation.portrait
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          !widget.manualScan
                              ? Text(
                                  widget.title ?? "Scan QR Code",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.white, fontSize: 18),
                                )
                              : ElevatedButton.icon(
                                  onPressed: isProcessingResult
                                      ? null
                                      : () {
                                          setState(() {
                                            if (manualScanActive) {
                                              manualScanActive = false;
                                            } else {
                                              manualScanActive = true;
                                            }
                                          });
                                        },
                                  icon: manualScanActive
                                      ? const Icon(Icons.stop)
                                      : const Icon(Icons.play_arrow),
                                  label: Text(
                                    isProcessingResult
                                        ? (widget.messageWhenProcessingResult ??
                                            "Processing...")
                                        : (widget.title ?? "Scan QR Code"),
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: Colors.white, fontSize: 18),
                                  )),
                          ...(widget.customVerticalWidgets ?? [])
                        ],
                      )
                    : Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          !widget.manualScan
                              ? Text(
                                  widget.title ?? "Scan QR Code",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.white, fontSize: 18),
                                )
                              : ElevatedButton.icon(
                                  onPressed: isProcessingResult
                                      ? null
                                      : () {
                                          setState(() {
                                            if (manualScanActive) {
                                              manualScanActive = false;
                                            } else {
                                              manualScanActive = true;
                                            }
                                          });
                                        },
                                  icon: manualScanActive
                                      ? const Icon(Icons.stop)
                                      : const Icon(Icons.play_arrow),
                                  label: Text(
                                    isProcessingResult
                                        ? (widget.messageWhenProcessingResult ??
                                            "Processing...")
                                        : (widget.title ?? "Scan QR Code"),
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            color: Colors.white, fontSize: 18),
                                  )),
                          ...(widget.customVerticalWidgets ?? [])
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var newWindow = scanWindow.inflate(4);

    final roundedPath = Path()
      ..addRRect(RRect.fromRectAndRadius(newWindow, const Radius.circular(10)));
    final removerPath = Path()
      ..addRRect(RRect.fromRectAndRadius(scanWindow, const Radius.circular(10)))
      ..addPolygon([
        Offset(newWindow.left + 30, newWindow.top),
        Offset(newWindow.right - 30, newWindow.top),
        Offset(newWindow.right, newWindow.top + 30),
        Offset(newWindow.right, newWindow.bottom - 30),
        Offset(newWindow.right - 30, newWindow.bottom),
        Offset(newWindow.left + 30, newWindow.bottom),
        Offset(newWindow.left, newWindow.bottom - 30),
        Offset(newWindow.left, newWindow.top + 30),
      ], false);

    final roundedWithCutout = Path.combine(
      PathOperation.difference,
      roundedPath,
      removerPath,
    );

    canvas.drawPath(roundedWithCutout, whitePaint);

    //canvas.drawPath(removerPath, whitePaint..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BarcodeOverlay extends CustomPainter {
  BarcodeOverlay({
    required this.barcode,
    required this.boxFit,
    required this.capture,
  });

  final BarcodeCapture capture;
  final Barcode barcode;
  final BoxFit boxFit;

  @override
  void paint(Canvas canvas, Size size) {
    if (barcode.corners == null) return;
    final adjustedSize = applyBoxFit(boxFit, capture.size, size);

    double verticalPadding = size.height - adjustedSize.destination.height;
    double horizontalPadding = size.width - adjustedSize.destination.width;
    if (verticalPadding > 0) {
      verticalPadding = verticalPadding / 2;
    } else {
      verticalPadding = 0;
    }

    if (horizontalPadding > 0) {
      horizontalPadding = horizontalPadding / 2;
    } else {
      horizontalPadding = 0;
    }

    final ratioWidth = (capture.size.width!) / adjustedSize.destination.width;
    final ratioHeight =
        (capture.size.height!) / adjustedSize.destination.height;

    final List<Offset> adjustedOffset = [];
    for (final offset in barcode.corners!) {
      adjustedOffset.add(
        Offset(
          offset.dx / ratioWidth + horizontalPadding,
          offset.dy / ratioHeight + verticalPadding,
        ),
      );
    }
    final cutoutPath = Path()..addPolygon(adjustedOffset, true);

    final backgroundPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    canvas.drawPath(cutoutPath, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MovingLine extends StatefulWidget {
  final Rect scanWindow;

  const MovingLine(this.scanWindow, {super.key});

  @override
  State<StatefulWidget> createState() => _MovingLineState();
}

class _MovingLineState extends State<MovingLine>
    with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      });

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: LinePainter(widget.scanWindow, _progress));
  }
}

class LinePainter extends CustomPainter {
  late Paint _paint;
  final Rect scanWindow;
  final double _progress;

  LinePainter(this.scanWindow, this._progress) {
    _paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
        Offset(scanWindow.left, scanWindow.top + scanWindow.height * _progress),
        Offset(
            scanWindow.right, scanWindow.top + scanWindow.height * _progress),
        _paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}
