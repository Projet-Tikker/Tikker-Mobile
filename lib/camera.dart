import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:camera/camera.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path/path.dart' show join;

class MyCamera extends StatefulWidget {
  final List<CameraDescription> cameras;
  const MyCamera({super.key, required this.cameras});

  @override
  State<MyCamera> createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  late Future<void> _initializeControllerFuture;
  late CameraController _controller;
  int _selectedCameraIndex = -1;
  String _lastImage = "";
  bool _loading = false;

  Future<void> initCamera(CameraDescription camera) async {
    _controller = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    _controller.addListener(() {
      if (mounted) {
        setState(() {}); // Ca nous sert de F5 => une sorte de refresh
      }
    });

    if (_controller.value.hasError) {
      print('Erreur Camera ${_controller.value.errorDescription}');
    }

    _initializeControllerFuture = _controller.initialize();

    if (mounted) {
      setState(() {}); // Ca nous sert de F5 => une sorte de refresh
    }
  }

  Future<void> _cameraToggle() async {
    if (_lastImage != "") {
      _lastImage = "";
    }
    setState(() {
      _selectedCameraIndex = _selectedCameraIndex > -1
          ? _selectedCameraIndex == 0
              ? 1
              : 0
          : 0;
    });
    await initCamera(
      widget.cameras[_selectedCameraIndex],
    );
  }

  Future<void> _TakePicture() async {
    try {
      await _initializeControllerFuture;
      String pathImage = join((await getTemporaryDirectory()).path,
          '${DateTime.now().millisecondsSinceEpoch}.jpeg');

      await _controller.takePicture(/* pathImage */);

      setState(() => _lastImage = pathImage);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _cameraToggle();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: _lastImage != ""
            ? TextButton(
                onPressed: () => setState(() => _lastImage = ""),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              )
            : null,
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Transform.scale(
                  scale: _controller.value.aspectRatio / size.aspectRatio,
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 0.92 / _controller.value.aspectRatio,
                      child: _lastImage != ""
                          ? Image(
                              image: FileImage(
                                File(_lastImage),
                              ),
                            )
                          : CameraPreview(_controller),
                    ),
                  ),
                ),
                Visibility(
                  visible: _lastImage == "",
                  child: Positioned(
                    left: 50,
                    bottom: 50,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () => print('Gallery Access'),
                          child: Icon(
                            Icons.photo_size_select_actual,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _lastImage == "",
                  child: Positioned(
                    right: 50,
                    bottom: 50,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: Colors.white,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: _cameraToggle,
                          child: Icon(
                            Icons.loop,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _loading == true,
                  child: Positioned(
                    bottom: 30,
                    left: 20,
                    child: Row(
                      children: [
                        SpinKitCircle(
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(
                          width: 0.5,
                        ),
                        Text(
                          'Publishing...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Text('Loading'),
          );
        }),
      ),
      floatingActionButton: _lastImage != null
          ? Container(
              margin: EdgeInsets.only(bottom: 30),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: Colors.white,
                ),
              ),
              child: FittedBox(
                child: InkWell(
                  onLongPress: () => print('Take Video'),
                  child: FloatingActionButton(
                    onPressed: _TakePicture,
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                  ),
                ),
              ),
            )
          : FloatingActionButton.extended(
              elevation: 0,
              shape: RoundedRectangleBorder(),
              backgroundColor: Colors.white.withOpacity(0.6),
              onPressed: () async {
                setState(() => _loading = !_loading);
                await Future.delayed(
                  Duration(seconds: 3),
                );
                setState(() => _lastImage = "");
                setState(() => _loading = !_loading);
              },
              label: Text(
                'Publish',
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.send_rounded,
                color: Colors.black,
              ),
            ),
      floatingActionButtonLocation: _lastImage == null
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
    ));
  }
}
