
import 'package:flutter/material.dart';


class MedicineDetailPage extends StatelessWidget {
  final Map<String, dynamic> product_data;
  const MedicineDetailPage({super.key, required this.product_data});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Header Image
              Stack(
                children: [
                  Container(
                    height: height * 0.32,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://t4.ftcdn.net/jpg/05/77/84/27/240_F_577842756_DWiS65lNLDG5DPaozrJk3c9TgkGGBwCb.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.green),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.02),

              /// Content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    if (product_data["openfda"]?["generic_name"] != null)
                      Text(
                        product_data["openfda"]["generic_name"].join(", "),
                        style: TextStyle(
                          fontFamily: "Font2",
                          fontSize: height * 0.032,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    SizedBox(height: height * 0.02),

                    _infoCard(
                      title: "Purpose",
                      icon: Icons.info_outline,
                      content: product_data["purpose"]?[0],
                    ),

                    _warningCard(
                      title: "Warnings",
                      icon: Icons.warning_amber_rounded,
                      content: product_data["warnings"]?[0],
                    ),

                    _infoCard(
                      title: "Storage & Handling",
                      icon: Icons.inventory_2_outlined,
                      content:
                      product_data["storage_and_handling"]?[0],
                    ),

                    _infoCard(
                      title: "Manufacturer",
                      icon: Icons.factory_outlined,
                      content: product_data["openfda"]
                      ?["manufacturer_name"]?[0],
                    ),

                    /// Active Ingredients
                    if (product_data["active_ingredient"] != null)
                      _ingredientsSection(
                        product_data["active_ingredient"],
                      ),
                    const SizedBox(height: 20),

                    // constonst ReminderButton(),



                    SizedBox(height: height * 0.04),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Info Card
  Widget _infoCard({
    required String title,
    required IconData icon,
    String? content,
  }) {
    if (content == null) return const SizedBox();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Font2",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontFamily: "font2",
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Warning Card
  Widget _warningCard({
    required String title,
    required IconData icon,
    String? content,
  }) {
    if (content == null) return const SizedBox();

    return Card(
      color: const Color(0xFFFFEBEE),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "Font2",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontFamily: "font2",
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Ingredients Chips
  Widget _ingredientsSection(List ingredients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Active Ingredients",
          style: TextStyle(
            fontFamily: "Font2",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ingredients
              .map<Widget>(
                (e) => Chip(
              label: Text(
                e.toString(),
                style: const TextStyle(fontFamily: "font2"),
              ),
              backgroundColor:
              const Color(0xFFE8F5E9),
            ),
          )
              .toList(),
        ),
      ],
    );
  }
}
