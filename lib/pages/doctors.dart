import 'package:flutter/material.dart';
import '../widgets/doctor_card.dart';
import '../models/doctor.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //List mock de médicos
    final doctors = [
      Doctor(name: 'Dr. João Silva', specialty: 'Urologista', avgRating: 4.8, reviewsCount: 32),
      Doctor(name: 'Dr. Marcos Oliveira', specialty: 'Clínico Geral', avgRating: 4.5, reviewsCount: 18),
      Doctor(name: 'Dra. Ana Costa', specialty: 'Cardiologista', avgRating: 4.9, reviewsCount: 25),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Doutores')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: doctors.length,
        itemBuilder: (context, i) => DoctorCard(doctor: doctors[i]),
      ),
    );
  }
}
      
  
