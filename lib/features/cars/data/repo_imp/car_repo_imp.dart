import 'dart:io';

import 'package:car_rental/features/cars/domain/carRepo/carRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import '../models/car_model.dart';

class CarRepoImpl implements CarRepo{
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  CarRepoImpl({required this.firebaseStorage,required this.firebaseFirestore});
  @override
  Future<void> addCar(Cars car) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final docId = "${car.name.trim().replaceAll(' ', '_').toLowerCase()}_$timestamp";
    await firebaseFirestore.collection("cars").doc(docId).set(car.toJson());
  }

  @override
  Future<List<Cars>> getCars()async {
    final docs= await firebaseFirestore.collection("cars").get();
    List<Cars> cars=[];
    for(final doc in docs.docs) {
      cars.add(Cars.fromJson(doc.data()));
    }
    return cars;
  }
  @override
  Future<String> uploadCarImage(File image, String carName) async {
    // تقليص حجم الصورة وتقليل جودتها
    img.Image? imageFile = img.decodeImage(image.readAsBytesSync());
    if (imageFile != null) {
      // تقليص الحجم
      img.Image resizedImage = img.copyResize(imageFile, width: 800); // تغيير الحجم كما تحتاج
      // تقليل الجودة
      List<int> resizedImageBytes = img.encodeJpg(resizedImage, quality: 70); // تقليل الجودة

      // كتابة الصورة المصغرة إلى ملف
      File compressedImageFile = File(image.path)..writeAsBytesSync(resizedImageBytes);

      final id = carName.trim().replaceAll(' ', '_').toLowerCase();

      final storageRef = firebaseStorage.ref();
      final imageRef = storageRef.child("cars/$id.jpg");

      await imageRef.putFile(compressedImageFile);
      return await imageRef.getDownloadURL();
    } else {
      throw Exception("Failed to decode image");
    }
  }
}