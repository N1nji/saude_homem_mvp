import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/doctor.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(child: Text(doctor.initials)),
        title: Text(doctor.name),
        subtitle: Text(doctor.specialty),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RatingBarIndicator(
              rating: doctor.avgRating,
              itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
              itemSize: 18,
            ),
            Text('${doctor.reviewsCount} avaliações', style: const TextStyle(fontSize: 12)),
          ],
        ),
        onTap: () {
          //abrir perfil do médico
        },
      ),
    );
  }
}