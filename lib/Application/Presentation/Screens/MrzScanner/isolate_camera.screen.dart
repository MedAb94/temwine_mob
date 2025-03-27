import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:temwin_front_app/Application/Presentation/Widgets/MrzScanner/camera_overlay_widget.dart';
import 'package:temwin_front_app/Core/Navigation/go_router_navigation.dart';
import 'package:temwin_front_app/Core/extensions/mlkit_extension.dart';
import 'package:temwin_front_app/Core/mrz_scanner_models/process_isolate.dart';
import 'package:temwin_front_app/Core/mrz_scanner_models/process_text_image.model.dart';

class IsolateCameraScreen extends StatefulWidget {
  const IsolateCameraScreen({super.key, required this.isOffline});

  final bool isOffline;

  @override
  State<IsolateCameraScreen> createState() => _IsolateCameraScreenState();
}

class _IsolateCameraScreenState extends State<IsolateCameraScreen> {
  final _imageStreamController = StreamController<AnalysisImage>();
  StreamSubscription<AnalysisImage>? processImageSubscription;
  StreamSubscription<bool>? resultListener;
  PhotoCameraState? cameraState;
  ProcessIsolate processIsolate = ProcessIsolate();
  ProcessTextImage processTextImage = ProcessTextImage();

  @override
  void dispose() {
    processImageSubscription?.cancel();
    processIsolate.closeIsolate();
    _imageStreamController.close();
    processTextImage.dispose();
    resultListener?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    processIsolate.createIsolate();
    _analysisImageStream();
    _resultListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraAwesomeBuilder.custom(
        onImageForAnalysis: (img) async {
          if (!_imageStreamController.isClosed) {
            return _imageStreamController.add(img);
          }
        },
        imageAnalysisConfig: AnalysisConfig(maxFramesPerSecond: 5),
        sensorConfig:
            SensorConfig.single(aspectRatio: CameraAspectRatios.ratio_16_9),
        saveConfig: SaveConfig.photo(),
        builder: (CameraState state, Preview preview) => state.when(
          onPhotoMode: (photoCameraState) => CameraOverlayWidget(
            photoCameraState: photoCameraState,
            onPhotoCameraState: _setCameraStatet,
          ),
        ),
      ),
    );
  }

  void _setCameraStatet(PhotoCameraState state) {
    cameraState ??= state;
  }

  void _analysisImageStream() {
    processImageSubscription = _imageStreamController.stream.listen((image) {
      processIsolate.sendImage(image.toInputImage());
    });
  }

  void _resultListener() {
    resultListener = processIsolate.resultListener().listen((event) {
      if (event) {
        cameraState
            ?.takePhoto()
            .then(_onTakePhoto)
            .catchError((onError) => _onTakeError(onError));
      }
    });
  }

  FutureOr _onTakePhoto(CaptureRequest value) {
    processTextImage
        .photoTextProcess(
            InputImage.fromFilePath(value.path!), widget.isOffline)
        ?.then((value) {
      CustomNavigationHelper.router.pop(value);
      //Navigator.pop(context, value);
    });
  }

  _onTakeError(onError) {
    debugPrint("Take photo error $onError");
  }
}
