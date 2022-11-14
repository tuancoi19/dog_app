import 'package:dog_app/enum/load_status.dart';
import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final List<String> listBreeds;
  final String breed;
  final List<String> listImages;
  final LoadStatus fetchBreedsStatus;
  final LoadStatus fetchImagesStatus;
  final int selectedIndex;
  final bool loadMore;

  const AppState(
      {this.listBreeds = const [],
      this.breed = '',
      this.listImages = const [],
      this.fetchBreedsStatus = LoadStatus.initial,
      this.fetchImagesStatus = LoadStatus.initial,
      this.selectedIndex = 0,
      this.loadMore = false});

  @override
  List<Object?> get props => [
        listBreeds,
        breed,
        listImages,
        fetchBreedsStatus,
        fetchImagesStatus,
        selectedIndex,
        loadMore
      ];

  AppState copyWith(
      {List<String>? listBreeds,
      String? breed,
      List<String>? listImages,
      LoadStatus? fetchBreedsStatus,
      LoadStatus? fetchImagesStatus,
      int? selectedIndex,
      bool? loadMore}) {
    return AppState(
        listBreeds: listBreeds ?? this.listBreeds,
        breed: breed ?? this.breed,
        listImages: listImages ?? this.listImages,
        fetchBreedsStatus: fetchBreedsStatus ?? this.fetchBreedsStatus,
        fetchImagesStatus: fetchImagesStatus ?? this.fetchImagesStatus,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        loadMore: loadMore ?? this.loadMore);
  }
}
