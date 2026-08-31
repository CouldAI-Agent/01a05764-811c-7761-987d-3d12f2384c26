import 'package:flutter/material.dart';

void main() {
  runApp(const DataApp());
}

class DataApp extends StatelessWidget {
  const DataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tableau de bord',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const TableScreen(),
      },
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String role;
  final String status;

  UserData(this.id, this.name, this.email, this.role, this.status);
}

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  final List<UserData> _users = [
    UserData(1, 'Alice Dupont', 'alice@example.com', 'Admin', 'Actif'),
    UserData(2, 'Bob Martin', 'bob@example.com', 'Utilisateur', 'Inactif'),
    UserData(3, 'Charlie Durand', 'charlie@example.com', 'Éditeur', 'Actif'),
    UserData(4, 'Diane Leroy', 'diane@example.com', 'Utilisateur', 'En attente'),
    UserData(5, 'Émile Petit', 'emile@example.com', 'Utilisateur', 'Actif'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Données Utilisateurs'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Mobile view: list of cards
            if (constraints.maxWidth < 600) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          _buildInfoRow(Icons.email, user.email),
                          const SizedBox(height: 4),
                          _buildInfoRow(Icons.badge, user.role),
                          const SizedBox(height: 4),
                          _buildInfoRow(Icons.info, user.status),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            // Desktop/Tablet view: DataTable
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Nom')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Rôle')),
                        DataColumn(label: Text('Statut')),
                      ],
                      rows: _users.map((user) {
                        return DataRow(
                          cells: [
                            DataCell(Text(user.id.toString())),
                            DataCell(Text(user.name)),
                            DataCell(Text(user.email)),
                            DataCell(Text(user.role)),
                            DataCell(Text(user.status)),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
