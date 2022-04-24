import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _setupCamera() async {
    try {
      _cameras = await availableCameras();
      _controller = CameraController(
        _cameras[0],
        ResolutionPreset.medium,
      );
      await _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          _isReady = true;
        });
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: getFloatinActionButtons(),
      body: getBody(context),
    );
  }

  cameraview() {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: CameraPreview(_controller),
    );
  }

  getBody(context) {
    var size = MediaQuery.of(context).size;
    if (_isReady==false || _controller == null || !_controller.value.isInitialized) {
      return Container(
      color: Colors.black,
      width: size.width,
      height: size.height,
      child: const Center(
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
      ),
    );
    }
    return SizedBox(
      height: size.height,
      width: size.width,
      child: cameraview(),
    );
  }

  getFloatinActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(.2)),
                    child: const Icon(FeatherIcons.user,
                        color: Colors.amber, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(.2)),
                    child: const Icon(
                      FeatherIcons.search,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(.2)),
                    child: const Icon(FeatherIcons.userPlus,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black.withOpacity(.2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          Icon(
                            FeatherIcons.refreshCcw,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(height: 18),
                          Icon(
                            FeatherIcons.framer,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(height: 18),
                          Icon(
                            FeatherIcons.film,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(height: 18),
                          Icon(
                            FeatherIcons.music,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(height: 18),
                          Icon(
                            FeatherIcons.chevronDown,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const IconButton(
                onPressed: null,
                icon: Icon(
                  CommunityMaterialIcons.cards_playing_outline,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 15),
              GestureDetector(
                onTap: (){
                  log('take photo');
                  _controller.takePicture();
                },
                child: Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5)),
                ),
              ),
              const SizedBox(width: 15),
              const IconButton(
                onPressed: null,
                icon: Icon(
                  FeatherIcons.frown,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
