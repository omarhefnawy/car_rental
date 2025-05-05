import 'package:car_rental/features/cars/data/models/car_model.dart';

abstract class CarStates{}

class CarInitial implements CarStates{}
class AddingCarLoading implements CarStates{}
class AddingCarSuccess implements CarStates{}
class AddingCarFail implements CarStates{
 final  String e;
 AddingCarFail({required this.e});
}
class GetCarLoading implements CarStates{}
class GetCarSuccess implements CarStates{
final  List<Cars> cars;
GetCarSuccess({required this.cars});
}
class GetCarFail implements CarStates{
  final  String e;
  GetCarFail({required this.e});
}
// States for uploading image to Firebase Storage
class UploadingImageLoading implements CarStates {}  // When image is uploading
class UploadingImageSuccess implements CarStates {
  final String imageUrl;  // URL of the uploaded image
  UploadingImageSuccess({required this.imageUrl});
}
class UploadingImageFail implements CarStates {
  final String e;  // Error message if upload fails
  UploadingImageFail({required this.e});
}