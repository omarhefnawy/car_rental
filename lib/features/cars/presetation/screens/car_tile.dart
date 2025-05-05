import 'package:car_rental/core/constants/Colors.dart';
import 'package:car_rental/features/cars/presetation/screens/CarInfo.dart';
import 'package:flutter/material.dart';
import 'package:car_rental/features/cars/data/models/car_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CarTile extends StatelessWidget { // بقى Stateless عشان البساطة
  final Cars car;
  const CarTile({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color:  ColorsConst.Kcbg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/cars.png",
              height: 170,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              car.name,
              style: const TextStyle(
                fontSize: 25,
                color: Color(0xff181c1e),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "\$${car.pricePerDay} /day",
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xff384147),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.heart,
                    color: Color(0xff2B4C59),
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CarInfo(car: car),) );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.arrowRight,
                    color: Color(0xff2B4C59),
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}