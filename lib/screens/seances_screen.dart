import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/seance.dart';
import 'qr_code_screen.dart';

class SeancesScreen extends StatefulWidget {
  final int userId;

  const SeancesScreen({super.key, required this.userId});

  @override
  State<SeancesScreen> createState() => _SeancesScreenState();
}

class _SeancesScreenState extends State<SeancesScreen> {
  List<Seance> _seances = [];
  bool _isLoading = true;

  // Base URL de l'API
  static const String baseUrl = 'http://10.0.2.2/Cinephoria/Api'; // Pour l'émulateur Android
  // Si vous testez sur un appareil physique, utilisez l'IP de votre machine
  // static const String baseUrl = 'http://192.168.1.X/Cinephoria/Api'; // Remplacez X par votre IP

  @override
  void initState() {
    super.initState();
    _fetchSeances();
  }

  Future<void> _fetchSeances() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/get_reservation.php?user_id=${widget.userId}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['reservations'] != null) {
          setState(() {
            _seances = (data['reservations'] as List)
                .map((json) => Seance.fromJson(json))
                .toList();
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors du chargement des séances')),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Réservations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _seances.isEmpty
              ? const Center(child: Text('Aucune réservation trouvée'))
              : RefreshIndicator(
                  onRefresh: _fetchSeances,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _seances.length,
                    itemBuilder: (context, index) {
                      final seance = _seances[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QRCodeScreen(
                                  filmTitle: seance.film,
                                  reservationId: seance.reservationId,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    seance.affiche,
                                    width: 100,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 150,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.movie, size: 50),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        seance.film,
                                        style: Theme.of(context).textTheme.titleLarge,
                                      ),
                                      const SizedBox(height: 8),
                                      Text('Date: ${seance.jourProjection}'),
                                      Text('Heure début: ${seance.heureDebut}'),
                                      Text('Heure fin: ${seance.heureFin}'),
                                      Text('Salle: ${seance.numeroSalle}'),
                                      Text('Places réservées: ${seance.places}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
} 