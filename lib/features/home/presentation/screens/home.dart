import 'dart:async'; // لإستخدام Timer
import 'package:car_rental/features/auth/presentation/widgets/customFormField.dart';
import 'package:car_rental/features/auth/presentation/widgets/customTextButton.dart';
import 'package:car_rental/features/cars/presetation/carBloc/carBloc.dart';
import 'package:car_rental/features/cars/presetation/carBloc/carStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cars/data/models/car_model.dart';
import '../../../cars/presetation/screens/car_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  List<Cars> filteredCars = [];

  @override
  void initState() {
    super.initState();
    context.read<CarCubit>().getCars();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      final lowerQuery = query.toLowerCase();
      final cubit = context.read<CarCubit>();

      if (cubit.state is GetCarSuccess) {
        final cars = (cubit.state as GetCarSuccess).cars;
        setState(() {
          filteredCars = cars
              .where((car) => car.name.toLowerCase().contains(lowerQuery))
              .toList();
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarCubit, CarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetCarLoading) {
          return const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.green),
          );
        } else if (state is GetCarFail) {
          return const Center(child: Text("Error Getting the cars"));
        } else if (state is GetCarSuccess) {
          // عند أول تحميل ننسخ القائمة كاملة
          if (filteredCars.isEmpty) {
            filteredCars = state.cars;
          }

          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                final result = await Navigator.pushNamed(context, "addCar");
                if (result == true) {
                  context.read<CarCubit>().getCars();
                  _searchController.clear();
                  filteredCars = []; // إعادة التصفية عند الرجوع
                }
              },
              backgroundColor: Colors.green,
              icon: const Icon(Icons.add),
              label: const Text("Add Car"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "Trending Cars",
                    style: TextStyle(fontSize: 20, color: Color(0xff2B4C59)),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: _onSearchChanged,
                            decoration: const InputDecoration(
                              hintText: "Search",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      itemCount: filteredCars.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return CarTile(car: filteredCars[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
              child: Text("UnHandled Error While getting the App"));
        }
      },
    );
  }
}
