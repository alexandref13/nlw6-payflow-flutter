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

  Future<void> getAvailableCameras() async {
    try {
      final camera = await availableCameras();

      final cameraController = CameraController(
        camera[0],
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420,
        enableAudio: false,
      );
      await cameraController.initialize();
      status.value = BarcodeScannerStatus.availableCamera(cameraController);
      scanWithCamera();
    } catch (err) {
      status.value = BarcodeScannerStatus.error(err.toString());
    }
  }

  void scanWithImagePicker() async {
    await status.value.cameraController!.stopImageStream();
    final response = await ImagePicker().pickImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);
    scannerBarCode(inputImage);
  }

  void scanWithCamera() {
    Future.delayed(Duration(seconds: 10)).then((value) {
      if (status.value.cameraController != null) {
        if (status.value.cameraController!.value.isStreamingImages)
          status.value.cameraController!.stopImageStream();
      }
      status.value = BarcodeScannerStatus.error("Timeout de leitura de boleto");
    });
    listenCamera();
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      if (status.value.cameraController != null) {
        if (status.value.cameraController!.value.isStreamingImages)
          status.value.cameraController!.stopImageStream();
      }
      final barcodes = await barcodeScanner.value.processImage(inputImage);
      var barcode;
      for (Barcode item in barcodes) {
        barcode = item.value.displayValue;
      }

      if (barcode != null && status.value.barcode.isEmpty) {
        status.value = BarcodeScannerStatus.barcode(barcode);
        if (status.value.cameraController != null)
          status.value.cameraController!.dispose();
      } else {
        getAvailableCameras();
      }
      return;
    } catch (err) {
      print("ERRO DA LEITURA $err");
    }
  }

  void listenCamera() {
    if (status.value.cameraController != null) if (status
            .value.cameraController!.value.isStreamingImages ==
        false)
      status.value.cameraController!.startImageStream((cameraImage) async {
        try {
          final WriteBuffer allBytes = WriteBuffer();
          for (Plane plane in cameraImage.planes) {
            allBytes.putUint8List(plane.bytes);
          }
          final bytes = allBytes.done().buffer.asUint8List();
          final Size imageSize =
              Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());
          final InputImageRotation imageRotation =
              InputImageRotation.Rotation_0deg;
          final InputImageFormat inputImageFormat =
              InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
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
      });
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
      status.value.cameraController!.dispose();
    }
    super.dispose();
  }
}
