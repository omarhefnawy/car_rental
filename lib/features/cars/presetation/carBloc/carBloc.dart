import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:car_rental/features/cars/domain/carRepo/carRepo.dart';
import 'package:car_rental/features/cars/presetation/carBloc/carStates.dart';

import '../../data/models/car_model.dart';

class CarCubit extends Cubit<CarStates>{
  final  CarRepo repo;
  CarCubit(this.repo):super(CarInitial());
  //add car
  Future<void> addCar(Cars car)async{
    emit(AddingCarLoading());
    try
        {
          await repo.addCar(car);
          emit(AddingCarSuccess());
        }
        catch(e)
    {
     emit(AddingCarFail(e: e.toString())) ;
    }
  }
  //add to firebase

  //add car image to storage
  // تعديل دالة رفع الصورة لكي ترجع الرابط
  Future<String> uploadImageAndReturnUrl(File image, String carName) async {
    emit(UploadingImageLoading());
    try {
      String imageUrl = await repo.uploadCarImage(image, carName);
      emit(UploadingImageSuccess(imageUrl: imageUrl));
      return imageUrl; // نرجع الرابط هنا
    } catch (e) {
      emit(UploadingImageFail(e: e.toString()));
      rethrow;
    }
    }

  // get cars
  Future<void> getCars()async{
    emit(GetCarLoading());
    try
    {
     final cars=  await repo.getCars();
      emit(GetCarSuccess(cars: cars));
    }
    catch(e)
    {
      emit(GetCarFail(e: e.toString())) ;
    }
  }
}