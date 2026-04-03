import 'package:flutter/material.dart';
import 'package:post_data_to_api_sample/view/filter_screen/filter_screen.dart';
import 'package:post_data_to_api_sample/view/profile_screen/profile_screen.dart';
import 'package:post_data_to_api_sample/view/sale_list_screen/sale_list_screen.dart';

// Dashboard screen displaying main navigation options
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // Background color for the screen
        backgroundColor: Colors.grey.shade100,
      
        appBar: AppBar(
          title: const Text("Dashboard"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.deepPurple,
        ),
      
        body: Padding(
          padding: const EdgeInsets.all(16.0),
      
          // Grid layout to display dashboard cards
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              // Sales navigation card
              buildCard(
                context,
                title: "Sales",
                icon: Icons.shopping_cart,
                color: Colors.blue,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SaleListScreen(),
                    ),
                  );
                },
              ),
      
              // Profile navigation card
              buildCard(
                context,
                title: "Profile",
                icon: Icons.person,
                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
      
              // Filter navigation card
              buildCard(
                context,
                title: "Filter",
                icon: Icons.filter_alt,
                color: Colors.orange,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FilterScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable widget for dashboard cards
  Widget buildCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),

      child: Container(
        decoration: BoxDecoration(
          // Gradient background for card UI
          gradient: LinearGradient(colors: [color.withOpacity(0.8), color]),
          borderRadius: BorderRadius.circular(20),

          // Shadow effect for elevation
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),

            const SizedBox(height: 10),

            // Card title text
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
