import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class OcrScan extends StatefulWidget {
  const OcrScan({super.key});

  @override
  State<OcrScan> createState() => _OcrScanState();
}

class _OcrScanState extends State<OcrScan> with WidgetsBindingObserver {
  bool _isPermissonGranted = false;

  late final Future<void> _future;

  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _future = _requestCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _stopCamera();
    } else if (state == AppLifecycleState.resumed &&
        _cameraController != null &&
        _cameraController!.value.isInitialized) {
      _startCamera();
    }
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _isPermissonGranted = status == PermissionStatus.granted;
  }

  void _startCamera() {
    if (_cameraController != null) {
      _cameraSelected(_cameraController!.description);
    }
  }

  void _stopCamera() {
    if (_cameraController != null) {
      _cameraController?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        return Stack(
          children: [
            if (_isPermissonGranted)
              FutureBuilder<List<CameraDescription>>(
                future: availableCameras(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _initCameraController(snapshot.data!);

                    return Center(
                      child: CameraPreview(_cameraController!),
                    );
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),

              Scaffold(
                body: _isPermissonGranted 
                ? Column(
                  children: [
                    Expanded(child: Container()), 
                    Container(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: const Center(
                        child: ElevatedButton(
                          onPressed: null, 
                          child: Text('Scan Text'),
                        ),
                      ),
                    ),
                  ],
                )
                : Center(
                  child: Container(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                    child: const Text(
                      'Camera permission denied', 
                      textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              )
          ],
        );
      },
    );
  }

  void _initCameraController(List<CameraDescription> cameras) {
    if (_cameraController != null) {
      return;
    }

    CameraDescription? camera;

    for (var i = 0; i < cameras.length; i++) {
      final CameraDescription current = cameras[i];
      if (current.lensDirection == CameraLensDirection.back) {
        camera = current;
        break;
      }
    }

    if (camera != null) {
      _cameraSelected(camera);
    }
  }

  Future<void> _cameraSelected(CameraDescription camera) async {
    _cameraController =
        CameraController(camera, ResolutionPreset.max, enableAudio: false);
    await _cameraController?.initialize();

    if (!mounted) {
      return;
    }

    setState(() {});
  }
}
