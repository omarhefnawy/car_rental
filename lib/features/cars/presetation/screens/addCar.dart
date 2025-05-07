import 'dart:io';

import 'package:car_rental/features/auth/presentation/widgets/customFormField.dart';
import 'package:car_rental/features/auth/presentation/widgets/customTextButton.dart';
import 'package:car_rental/features/cars/data/models/car_model.dart';
import 'package:car_rental/features/cars/data/models/userData.dart';
import 'package:car_rental/features/cars/presetation/carBloc/carBloc.dart';
import 'package:car_rental/features/cars/presetation/carBloc/carStates.dart';
import 'package:car_rental/features/cars/presetation/screens/car_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final _key = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _userPhone = TextEditingController();
  LatLng? _userLatLng;
  String locationInfo = "";
  final _carName = TextEditingController();
  final _carDayPrice = TextEditingController();
  final _carSpeed = TextEditingController();
  final _carTransition = TextEditingController();
  File? imageFile;

  @override
  void dispose() {
    _userName.dispose();
    _userPhone.dispose();
    _carName.dispose();
    _carDayPrice.dispose();
    _carSpeed.dispose();
    _carTransition.dispose();
    super.dispose();
  }

  Future<void> _pickImagefromGallery() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = File(pickedImage.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error picking image: $e"),
        ),
      );
    }
  }

  Future<void> saveCar() async {
    if (!_key.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please fill all fields correctly"),
        ),
      );
      return;
    }
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please select a car image"),
        ),
      );
      return;
    }
    if (_userLatLng == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please select a car location"),
        ),
      );
      return;
    }

    final dayPrice = double.tryParse(_carDayPrice.text.trim());
    final carSpeed = int.tryParse(_carSpeed.text.trim());

    if (dayPrice == null || carSpeed == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please enter valid numbers for price and speed"),
        ),
      );
      return;
    }

    // رفع الصورة أولاً
    final imageUrl = await context.read<CarCubit>().uploadImageAndReturnUrl(imageFile!, _carName.text.trim());
    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Failed to upload image"),
        ),
      );
      return;
    }

    final car = Cars(
      name: _carName.text.trim(),
      pricePerDay: dayPrice,
      speed: carSpeed,
      transition: _carTransition.text.trim(),
      img: imageUrl,
      owner: UserData(
        name: _userName.text.trim(),
        phone: _userPhone.text.trim(),
        lat: _userLatLng!.latitude,
        lng: _userLatLng!.longitude,
      ),
    );

    context.read<CarCubit>().addCar(car);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarCubit, CarStates>(
      listener: (context, state) {
        if (state is AddingCarSuccess) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Success"),
              content: Text("Car added successfully! Add another car?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // إغلاق الـ dialog
                    Navigator.pop(context,true); // إغلاق الشاشة
                  },
                  child: Text("No"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // إغلاق الـ dialog
                    setState(() {
                      _userName.clear();
                      _userPhone.clear();
                      _carName.clear();
                      _carDayPrice.clear();
                      _carSpeed.clear();
                      _carTransition.clear();
                      _userLatLng = null;
                      imageFile = null;
                      locationInfo = "";
                    });
                  },
                  child: Text("Yes"),
                ),
              ],
            ),
          );
        } else if (state is AddingCarFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('Error adding car: ${state.e}'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AddingCarLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AddingCarFail) {
          return Center(
            child: Text(
              "Error adding the car: ${state.e}",
              style: TextStyle(fontSize: 25, color: Colors.red),
            ),
          );
        } else if (state is AddingCarSuccess) {
          return Center(
            child: Text(
              "Car added successfully!",
              style: TextStyle(fontSize: 25, color: Colors.green),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              "Add Your Ride",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 2,
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _key,
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (context, index) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.camera_alt, color: Colors.blue),
                          title: Text(
                            imageFile != null ? "Change Car Image" : "Add Car Image",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          trailing: imageFile != null
                              ? IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                imageFile = null;
                              });
                            },
                          )
                              : null,
                          onTap: _pickImagefromGallery,
                        ),
                      );
                    case 1:
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: imageFile != null
                              ? Image.file(
                            imageFile!,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                              : Container(
                            height: 200,
                            color: Colors.grey[200],
                            child: Center(
                              child: Text(
                                'No image selected',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ),
                        ),
                      );
                    case 2:
                      return CustomTextField(
                        controller: _userName,
                        hint: "Your Name",
                      );
                    case 3:
                      return CustomTextField(
                        controller: _userPhone,
                        hint: "Your Phone",

                      );
                    case 4:
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.location_on, color: Colors.blue),
                          title: Text(
                            "Add Car Location",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          onTap: () async {
                            LatLng? carLocation = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CarLocation()),
                            );
                            if (carLocation != null) {
                              _userLatLng = carLocation;
                              List<Placemark> placemarks = await placemarkFromCoordinates(
                                carLocation.latitude,
                                carLocation.longitude,
                              );
                              locationInfo = "${placemarks[0].country}, ${placemarks[0].street}";
                              setState(() {});
                            }
                          },
                        ),
                      );
                    case 5:
                      return Text(
                        locationInfo.isEmpty ? "No location selected" : locationInfo,
                        style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                      );
                    case 6:
                      return CustomTextField(
                        controller: _carName,
                        hint: "Car Name",
                      );
                    case 7:
                      return CustomTextField(
                        controller: _carSpeed,
                        hint: "Car Speed",

                      );
                    case 8:
                      return CustomTextField(
                        controller: _carTransition,
                        hint: "Car Transition",
                      );
                    case 9:
                      return CustomTextField(
                        controller: _carDayPrice,
                        hint: "Car Price per Day",
                      );
                    default:
                      return SizedBox();
                  }
                },
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Confirm"),
                  content: Text("Are you sure you want to save this car?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        saveCar();
                      },
                      child: Text("Save"),
                    ),
                  ],
                ),
              );
            },
            label: Text("Save Car"),
            icon: Icon(Icons.save),
            backgroundColor: Colors.blue,
          ),
        );
      },
    );
  }
}