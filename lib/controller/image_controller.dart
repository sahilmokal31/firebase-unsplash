import 'package:flutter_flow_app/service/unsplash_api.dart';
import 'package:get/get.dart';
import '../model/image_model.dart';

class ImageController extends GetxController {
  final UnsplashApiService apiService;
  final images = <ImageModel>[].obs;
  final isLoading = false.obs;
  final currentPage = 1.obs;
  final searchQuery = ''.obs;
  final hasMoreImages = true.obs; // Track if more images are available

  ImageController(this.apiService);

  @override
  void onInit() {
    super.onInit();
    fetchImages();
  }

  Future<void> fetchImages({bool isSearch = false}) async {
    if (!hasMoreImages.value || isLoading.value) return; // Prevent redundant calls

    isLoading(true);
    try {
      List<ImageModel> newImages;
      if (isSearch && searchQuery.value.isNotEmpty) {
        newImages = await apiService.searchImages(searchQuery.value, page: currentPage.value);
      } else {
        newImages = await apiService.fetchImages(page: currentPage.value);
      }
      
      // Update the list and check if more images are available
      if (newImages.isEmpty) {
        hasMoreImages(false);
      } else {
        images.addAll(newImages);
        currentPage.value++;
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void resetAndSearch(String query) {
    searchQuery.value = query;
    currentPage.value = 1;
    images.clear();
    hasMoreImages(true); // Reset to allow new pagination
    fetchImages(isSearch: true);
  }

  void loadNextBatch() {
    fetchImages(isSearch: searchQuery.value.isNotEmpty);
  }
}
