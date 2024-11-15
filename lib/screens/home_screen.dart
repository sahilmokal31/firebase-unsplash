import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flow_app/controller/image_controller.dart';
import 'package:flutter_flow_app/controller/search_history_controller.dart';
import 'package:flutter_flow_app/service/unsplash_api.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final ImageController imageController =
      Get.put(ImageController(UnsplashApiService()));
  final SearchHistoryController searchHistoryController =
      Get.put(SearchHistoryController(FirebaseFirestore.instance));

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onSubmitted: (query) {
            if (query.trim().isNotEmpty) {
              imageController.resetAndSearch(query);
              searchHistoryController.saveSearchQuery(query);
            }
          },
          decoration: InputDecoration(
            hintText: 'Search Unsplash...',
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            filled: true,

            fillColor: Colors.white24,
            prefixIcon: const Icon(Icons.search, color: Colors.white70),
            contentPadding: const EdgeInsets.symmetric(vertical: 18.0),
          ),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        if (imageController.isLoading.value && imageController.images.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!imageController.isLoading.value &&
            imageController.images.isEmpty) {
          return const Center(
            child: Text(
              "No images found. Try another search.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.7,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              onPageChanged: (index, reason) {
                if (index == imageController.images.length - 1 &&
                    imageController.hasMoreImages.value) {
                  imageController.loadNextBatch();
                }
              },
            ),
            itemCount: imageController.images.length,
            itemBuilder: (context, index, realIndex) {
              final image = imageController.images[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Image.network(
                    image.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image, size: 60),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
