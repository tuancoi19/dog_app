import 'package:dog_app/enum/load_status.dart';
import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final List<String> listBreeds;
  final List<String> breed;
  final List<String> listImages;
  final LoadStatus fetchBreedsStatus;
  final LoadStatus fetchImagesStatus;
  final List<int> selectedIndex;
  final int length;

  const AppState(
      {this.listBreeds = const [],
      this.breed = const [],
      this.listImages = const [],
      this.fetchBreedsStatus = LoadStatus.initial,
      this.fetchImagesStatus = LoadStatus.initial,
      this.selectedIndex = const [],
      this.length = 10});

  @override
  List<Object?> get props => [
        listBreeds,
        breed,
        listImages,
        fetchBreedsStatus,
        fetchImagesStatus,
        selectedIndex,
        length
      ];

  AppState copyWith(
      {List<String>? listBreeds,
      List<String>? breed,
      List<String>? listImages,
      LoadStatus? fetchBreedsStatus,
      LoadStatus? fetchImagesStatus,
      LoadStatus? extendStatus,
      List<int>? selectedIndex,
      int? length}) {
    return AppState(
        listBreeds: listBreeds ?? this.listBreeds,
        breed: breed ?? this.breed,
        listImages: listImages ?? this.listImages,
        fetchBreedsStatus: fetchBreedsStatus ?? this.fetchBreedsStatus,
        fetchImagesStatus: fetchImagesStatus ?? this.fetchImagesStatus,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        length: length ?? this.length);
  }
}
