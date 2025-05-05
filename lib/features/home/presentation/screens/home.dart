import 'package:car_rental/features/auth/presentation/widgets/customFormField.dart';
import 'package:flutter/material.dart';

import '../../../cars/data/car_model.dart';
import '../../../cars/presetation/screens/car_tile.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Cars> cars = [
    Cars(name: "Range Rover", pricePerDay: 200.00, speed: 200, transition: "Automatic"),
    Cars(name: "Mercedes", pricePerDay: 180.00, speed: 220, transition: "Automatic"),
    Cars(name: "BMW", pricePerDay: 190.00, speed: 210, transition: "Manual"),
    Cars(name: "Audi", pricePerDay: 210.00, speed: 230, transition: "Automatic"),
    Cars(name: "Range Rover", pricePerDay: 200.00, speed: 200, transition: "Automatic"),
    Cars(name: "Mercedes", pricePerDay: 180.00, speed: 220, transition: "Automatic"),
    Cars(name: "BMW", pricePerDay: 190.00, speed: 210, transition: "Manual"),
    Cars(name: "Audi", pricePerDay: 210.00, speed: 230, transition: "Automatic"),
  ];
  final _searchController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            SizedBox(width: 13,),
            Text(
              "Trending Cars",
              style: TextStyle(fontSize: 20, color: Color(0xff2B4C59)),
            ),
            SizedBox(height: 10,),
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
                itemCount: cars.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2, // تقليل المسافة الأفقية
                  mainAxisSpacing: 2, // تقليل المسافة الرأسية
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return CarTile(car: cars[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
