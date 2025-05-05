import 'dart:io';

import '../../data/models/car_model.dart';

abstract class CarRepo {
  Future<List<Cars>> getCars();
  Future<String> uploadCarImage(File image, String carName);
  Future<void> addCar(Cars car);
}


