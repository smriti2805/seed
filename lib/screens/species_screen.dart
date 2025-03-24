import 'package:flutter/material.dart';


class SpeciesScreen extends StatelessWidget {
  const SpeciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpeciesList(speciesData: demoSpeciesData,),
    );
  }
}

class SpeciesList extends StatelessWidget {
  final List<Map<String, String>> speciesData;

  const SpeciesList({super.key, required this.speciesData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: speciesData.length,
      itemBuilder: (context, index) {
        final species = speciesData[index];
        return Card(
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  'assets/images/image.png',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      species['scientificName'] ?? '',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                    Text(
                      species['commonName'] ?? '',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    Text(
                      species['family'] ?? '',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                    OverflowBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('DETAILS'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('VALIDATE'),
                        ),
                      ],
                    ),
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
final List<Map<String, String>> demoSpeciesData = [
  {
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },{
    'imageUrl': 'https://images.pexels.com/photos/378442/pexels-photo-378442.jpeg?cs=srgb&dl=dawn-nature-sky-378442.jpg&fm=jpg',
    'scientificName': 'Hesperocyparis lusitanica',
    'commonName': 'Cypress',
    'family': 'Cupressaceae',
  },
];
