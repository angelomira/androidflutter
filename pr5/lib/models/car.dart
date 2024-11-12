class Car {
  final String carName;
  final String carEntry;
  final String price;
  final String linkImage;
  final String linkRefer;
  final String carDescription;
  bool isFavorite = false;

  Car({required this.carName, required this.carEntry, required this.price, required this.linkImage, required this.linkRefer, required this.carDescription});

  updateFavourite(bool? status) {
    if(status == null) {
      isFavorite = !isFavorite;
    } else {
      isFavorite = status;
    }
  }
}