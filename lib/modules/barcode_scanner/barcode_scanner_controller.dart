import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';

class BarcodeScannerController extends GetxController {
  var status = BarcodeScannerStatus().obs;

  var barcodeScanner = GoogleMlKit.vision.barcodeScanner().obs;

  CameraController? cameraController;

  Future<void> getAvailableCameras() async {
    try {
      final response = await availableCameras();

      final camera = response.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back,
      );
      cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.yuv420,
        enableAudio: false,
      );
      await cameraController!.initialize();
      scanWithCamera();
      listenCamera();
    } catch (err) {
      status.value = BarcodeScannerStatus.error(err.toString());
    }
  }

  void scanWithImagePicker() async {
    final response = await ImagePicker().pickImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);
    scannerBarCode(inputImage);
  }

  void scanWithCamera() {
    status.value = BarcodeScannerStatus.availableCamera();
    Future.delayed(Duration(seconds: 20)).then((value) {
      if (status.value.hasBarcode == false)
        status.value =
            BarcodeScannerStatus.error("Timeout de leitura de boleto");
    });
    // listenCamera();
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      final barcodes = await barcodeScanner.value.processImage(inputImage);
      var barcode;
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }

      if (barcode != null && status.value.barcode.isEmpty) {
        status.value = BarcodeScannerStatus.barcode(barcode);
        cameraController!.dispose();
        await barcodeScanner.value.close();
      }
      return;
    } catch (err) {
      print("ERRO DA LEITURA $err");
    }
  }

  void listenCamera() {
    if (cameraController!.value.isStreamingImages == false)
      cameraController!.startImageStream(
        (cameraImage) async {
          if (status.value.stopScanner == false) {
            try {
              final WriteBuffer allBytes = WriteBuffer();
              for (Plane plane in cameraImage.planes) {
                allBytes.putUint8List(plane.bytes);
              }
              final bytes = allBytes.done().buffer.asUint8List();
              final Size imageSize = Size(
                  cameraImage.width.toDouble(), cameraImage.height.toDouble());
              final InputImageRotation imageRotation =
                  InputImageRotation.Rotation_0deg;
              final InputImageFormat inputImageFormat =
                  InputImageFormatMethods.fromRawValue(
                          cameraImage.format.raw) ??
                      InputImageFormat.NV21;
              final planeData = cameraImage.planes.map(
                (Plane plane) {
                  return InputImagePlaneMetadata(
                    bytesPerRow: plane.bytesPerRow,
                    height: plane.height,
                    width: plane.width,
                  );
                },
              ).toList();

              final inputImageData = InputImageData(
                size: imageSize,
                imageRotation: imageRotation,
                inputImageFormat: inputImageFormat,
                planeData: planeData,
              );
              final inputImageCamera = InputImage.fromBytes(
                  bytes: bytes, inputImageData: inputImageData);
              scannerBarCode(inputImageCamera);
            } catch (e) {
              print(e);
            }
          }
        },
      );
  }

  @override
  void onInit() {
    getAvailableCameras();
    status.addListener(
      GetStream(
        onListen: () {
          if (status.value.hasBarcode) {
            Get.offNamed('/insertBoleto');
          }
        },
      ),
    );
    super.onInit();
  }

  @override
  void dispose() {
    barcodeScanner.value.close();
    if (status.value.showCamera) {
      cameraController!.dispose();
    }
    super.dispose();
  }
}
