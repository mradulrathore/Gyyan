// Dart imports:
import 'dart:typed_data';
import 'dart:ui' as ui;

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gyaan/controller/provider.dart';

void convertWidgetToImageAndShare(BuildContext context, containerKey) async {
  RenderRepaintBoundary renderRepaintBoundary =
      containerKey.currentContext.findRenderObject();
  ui.Image boxImage = await renderRepaintBoundary.toImage(pixelRatio: 1);
  ByteData byteData = await boxImage.toByteData(format: ui.ImageByteFormat.png);
  Uint8List uInt8List = byteData.buffer.asUint8List();
  try {
    await Share.file('mradulrathore/gyaan', 'gyan.png', uInt8List, 'image/png',
        text: 'This message sent from *gyaan*');
  } catch (e) {
    print('error: $e');
  }

  Provider.of<FeedProvider>(context, listen: false).setWatermarkVisible(false);
}
