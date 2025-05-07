import 'package:car_rental/features/auth/presentation/widgets/customFormField.dart';
import 'package:car_rental/features/auth/presentation/widgets/customTextButton.dart';
import 'package:car_rental/features/cars/presetation/carBloc/carBloc.dart';
import 'package:car_rental/features/cars/presetation/carBloc/carStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cars/data/models/car_model.dart';
import '../../../cars/data/models/userData.dart';
import '../../../cars/presetation/screens/car_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<CarCubit>().getCars();
    super.initState();
  }
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarCubit,CarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is GetCarLoading)
          {
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.green,));
          }
        else if (state is GetCarFail)
          {
            return Center(child: Text("Error Getting the cars"),);
          }
        else if (state is GetCarSuccess)
          {
            return Scaffold(
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  final result = await Navigator.pushNamed(context, "addCar");
                  if (result == true) {
                    context.read<CarCubit>().getCars();
                  }
                },
                backgroundColor: Colors.green,
                icon: Icon(Icons.add),
                label: Text("Add Car"),
              ),

              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    SizedBox(width: 13),
                    Text(
                      "Trending Cars",
                      style: TextStyle(fontSize: 20, color: Color(0xff2B4C59)),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.search, color: Colors.grey),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
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
                        itemCount: state.cars.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2, // تقليل المسافة الأفقية
                          mainAxisSpacing: 2, // تقليل المسافة الرأسية
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          return CarTile(car: state.cars[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        else
          {
            return Center(child: Text("un handled error While getting the App"));
          }
      }
    );
  }
}
