// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payflow_project/modules/barcode_scanner/barcode_scanner_status.dart';

class BarcodeScannerController {
  final statusNotifier =
      ValueNotifier<BarcodeScannerStatus>(BarcodeScannerStatus());
  BarcodeScannerStatus get status => statusNotifier.value;
  set status(BarcodeScannerStatus status) => statusNotifier.value = status;

  var barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  CameraController? cameraController;

  InputImage? imagePicker;

  void getAvailableCameras() async {
    try {
      final response = await availableCameras();
      final camera = response.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.back);
      cameraController =
          CameraController(
            camera, 
            ResolutionPreset.high, 
            enableAudio: false,
            imageFormatGroup: Platform.isAndroid ? ImageFormatGroup.nv21 : ImageFormatGroup.bgra8888,
            );
      await cameraController!.initialize();
      scanWithCamera();
      listenCamera();
    } catch (e) {
      status = BarcodeScannerStatus.error(e.toString());
    }
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      final barcodes = await barcodeScanner.processImage(inputImage);

      if(barcodes.isNotEmpty) {
        String? barcode;
        for (Barcode item in barcodes) {
          barcode = item.displayValue;
        }

        if (barcode != null && status.barcode.isEmpty) {
          status = BarcodeScannerStatus.barcode(barcode);
          cameraController!.dispose();
          barcodeScanner.close();
        }
      }

      return;
    } catch (e) {
      print("ERRO DA LEITURA $e");
    }
  }

  void scanWithImagePicker() async {
    final response = await ImagePicker().pickImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(response!.path);
    scannerBarCode(inputImage);
  }

  void scanWithCamera() {
    status = BarcodeScannerStatus.available();
    Future.delayed(const Duration(seconds: 20)).then((value) {
      if (status.hasBarcode == false)
        status = BarcodeScannerStatus.error("Timeout de leitura de boleto");
    });
  }

  void listenCamera() {
    if (cameraController!.value.isStreamingImages == false)
      cameraController!.startImageStream((cameraImage) async {
        if (status.stopScanner == false) {
          try {
            final WriteBuffer allBytes = WriteBuffer();
            for (Plane plane in cameraImage.planes) {
              allBytes.putUint8List(plane.bytes);
            }
            final bytes = allBytes.done().buffer.asUint8List();
            final Size imageSize = Size(
                cameraImage.width.toDouble(), cameraImage.height.toDouble());
            const InputImageRotation imageRotation =
                InputImageRotation.rotation0deg;
            final inputImageFormat =
                InputImageFormatValue.fromRawValue(cameraImage.format.raw);

             if (inputImageFormat == null ||
              (Platform.isAndroid && inputImageFormat != InputImageFormat.nv21) ||
              (Platform.isIOS && inputImageFormat != InputImageFormat.bgra8888)) return null;   
            

            final inputImageData = InputImageMetadata(
              size: imageSize,
              rotation: imageRotation, 
              format: inputImageFormat,
              bytesPerRow: cameraImage.planes.first.bytesPerRow,
            );
            
            final inputImageCamera = InputImage.fromBytes(
                bytes: bytes, metadata: inputImageData);
            scannerBarCode(inputImageCamera);
          } catch (e) {
            print(e);
          }
        }
      });
  }

  void dispose() {
    statusNotifier.dispose();
    barcodeScanner.close();
    if (status.showCamera) {
      cameraController!.dispose();
    }
  }
}