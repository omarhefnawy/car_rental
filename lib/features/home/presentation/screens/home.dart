import 'package:car_rental/features/auth/presentation/widgets/customFormField.dart';
import 'package:car_rental/features/auth/presentation/widgets/customTextButton.dart';
import 'package:flutter/material.dart';

import '../../../cars/data/models/car_model.dart';
import '../../../cars/data/models/userData.dart';
import '../../../cars/presetation/screens/car_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Cars> cars = [
    Cars(
      name: "BMW i8",
      pricePerDay: 250.0,
      speed: 250,
      transition: "Automatic",
      img: "assets/cars/bmw_i8.png",
      owner: UserData(
        name: "Omar",
        phone: "+201112223334",
        lat: 30.0444,
        lng: 31.2357,
      ),
    ),
    Cars(
      name: "Tesla Model S",
      pricePerDay: 300.0,
      speed: 260,
      transition: "Automatic",
      img: "assets/cars/tesla_model_s.png",
      owner: UserData(
        name: "Laila",
        phone: "+201122334455",
        lat: 29.9792,
        lng: 31.1342,
      ),
    ),
    Cars(
      name: "Mercedes C-Class",
      pricePerDay: 180.0,
      speed: 240,
      transition: "Manual",
      img: "assets/cars/mercedes_c_class.png",
      owner: UserData(
        name: "Ahmed",
        phone: "+201155667788",
        lat: 30.0131,
        lng: 31.2089,
      ),
    ),
    Cars(
      name: "Audi A6",
      pricePerDay: 200.0,
      speed: 245,
      transition: "Automatic",
      img: "assets/cars/audi_a6.png",
      owner: UserData(
        name: "Salma",
        phone: "+201166778899",
        lat: 30.0500,
        lng: 31.2333,
      ),
    ),
  ];

  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  text: "Add your car and earn money",
                  onPressed: () {
                    // action
                    Navigator.pushNamed(context, "addCar");
                  },
                ),
              ],
            ),


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
