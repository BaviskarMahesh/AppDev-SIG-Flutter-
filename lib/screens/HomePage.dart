
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../services/ApiService.dart';
import '../utils/AppImages.dart';
import 'medicine_detailPage.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService apiService = ApiService();

  var result = [];
  var filteredResults = [];

  final TextEditingController searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  bool isLoading = true;
  bool hideCarousel = false;

  @override
  void initState() {
    super.initState();
    getMedicines();


    _searchFocusNode.addListener(() {
      setState(() {
        hideCarousel = _searchFocusNode.hasFocus;
      });
    });
  }

  Future<void> getMedicines() async {
    result = await apiService.getMedicine();
    filteredResults = List.from(result);
    setState(() => isLoading = false);
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      filteredResults = List.from(result);
    } else {
      filteredResults = result.where((medicine) {
        final genericName =
            medicine["openfda"]["generic_name"]?[0] ?? "";
        return genericName
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Widget buildShimmer(double height) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (_, __) => Padding(
          padding: const EdgeInsets.all(12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: height * 0.13,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        childCount: 6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            floating: true,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              "MedInfo",
              style: TextStyle(
                fontFamily: "Font2",
                color: Colors.black,
              ),
            ),
            bottom: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.white,
              title: TextField(
                focusNode: _searchFocusNode,
                controller: searchController,
                onChanged: filterSearchResults,
                decoration: InputDecoration(
                  hintText: "Search for medicines",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),

          if (!hideCarousel)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CarouselSlider(
                  items: [
                    _carouselImage(AppImages.carouselImage1),
                    _carouselImage(AppImages.carouselImage2),
                    _carouselImage(AppImages.carouselImage3),
                    _carouselImage(AppImages.carouselImage4),
                  ],
                  options: CarouselOptions(
                    height: height * 0.25,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                ),
              ),
            ),

          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "Available Medicines",
                style: TextStyle(
                  fontFamily: "Font2",
                  fontSize: 15,
                ),
              ),
            ),
          ),

          /// Medicine List
          isLoading
              ? buildShimmer(height)
              : SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final medicine = filteredResults[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MedicineDetailPage(
                            product_data: medicine,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: height * 0.13,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: const Image(
                          fit: BoxFit.cover,
                          alignment: AlignmentGeometry.center,
                          image: NetworkImage(
                            "https://t4.ftcdn.net/jpg/05/77/84/27/240_F_577842756_DWiS65lNLDG5DPaozrJk3c9TgkGGBwCb.jpg",
                          ),
                        ),
                        title: Text(
                          medicine["openfda"]
                          ["generic_name"][0],
                          style: const TextStyle(
                            fontFamily: "Font2",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: filteredResults.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _carouselImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
