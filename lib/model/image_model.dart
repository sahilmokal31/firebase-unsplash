class ImageModel {
  final String id;
  final String imageUrl;

  ImageModel({required this.id, required this.imageUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      imageUrl: json['urls']['regular'],
    );
  }
}