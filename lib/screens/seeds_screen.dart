import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed/providers/seed_data_provider.dart';
import 'package:seed/services/storage_service.dart';

class SeedScreen extends StatefulWidget {
  const SeedScreen({super.key});

  @override
  State<SeedScreen> createState() => _SeedScreenState();
}

class _SeedScreenState extends State<SeedScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCachedSeedData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return Center(child: Text('No data found'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Center(child: SeedList(seedData: snapshot.data ?? demoSeedData) // Use demo data if snapshot is null;
              );
        } else {
          return Center(child: Text('No data found'));
        }
      },
    );
  }
}

class SeedList extends StatelessWidget {
  final List<Map<String, dynamic>> seedData;

  const SeedList({super.key, required this.seedData});

  @override
  Widget build(BuildContext context) {
  final isLoading = Provider.of<SeedDataProvider>(context).isLoading;
    return isLoading
      ? Center(child: CircularProgressIndicator())
      :  ListView.builder(
      itemCount: seedData.length,
      itemBuilder: (context, index) {
        final seed = seedData[index];
        String imgUrl = seed['imageUrl'] ?? '';
        return Card(
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: File(imgUrl).existsSync()
                      ? Image.file(
                          File(imgUrl),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.error,
                          size: 200,
                        )
                  // Image.file(File(imgUrl),
                  //   height: 200,
                  //   width: double.infinity,
                  //   fit: BoxFit.cover,
                  // ),
                  ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      seed['scientificName'] ?? '',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                    // Text(
                    //   seed['commonName'] ?? '',
                    //   style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    // ),
                    // Text(
                    //   seed['family'] ?? '',
                    //   style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    // ),
                    // OverflowBar(
                    //   alignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     TextButton(
                    //       onPressed: () {},
                    //       child: Text('DETAILS'),
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () {},
                    //       child: Text('VALIDATE'),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Demo data to simulate a database
final List<Map<String, String>> demoSeedData = [
  {
    'imageUrl': 'https://media.istockphoto.com/id/1153088551/photo/almond-backgrounds-nut-food-textured-harvesting.jpg?s=612x612&w=0&k=20&c=VAU9zHx15bpgLzLt-uaeAfsySP1lnFeb7LGybYESaXA=',
    'scientificName': 'Prunus dulcis',
    'commonName': 'Amond',
    'family': 'Rosaceae or Rose',
  },
];
