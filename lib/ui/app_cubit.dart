import 'package:dog_app/enum/load_status.dart';
import 'package:dog_app/network/api.dart';
import 'package:dog_app/ui/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void changeListBreeds({required List<String> listBreeds}) {
    emit(state.copyWith(listBreeds: listBreeds));
  }

  void changeBreed({required List<String> breed}) {
    emit(state.copyWith(breed: breed));
  }

  void changeListImages({required List<String> listImages}) {
    emit(state.copyWith(listImages: listImages));
  }

  void changeSelectedIndex({required List<int> selectedIndex}) {
    emit(state.copyWith(selectedIndex: selectedIndex));
    List<String> breeds = [];
    for (int i in state.selectedIndex) {
      breeds.add(state.listBreeds[i]);
    }
    changeBreed(breed: breeds);
    fetchListImage();
  }

  void changeLength({required int length}) {
    emit(state.copyWith(length: length));
  }

  Future<void> fetchListBreeds() async {
    emit(state.copyWith(fetchBreedsStatus: LoadStatus.loading));
    try {
      List<String> data = await Api().fetchListBreeds();
      changeListBreeds(listBreeds: data);
      emit(state.copyWith(fetchBreedsStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(fetchBreedsStatus: LoadStatus.fail));
    }
  }

  Future<void> fetchListImage() async {
    if (state.selectedIndex.isNotEmpty) {
      emit(state.copyWith(fetchImagesStatus: LoadStatus.loading));
      try {
        List<String> data = [];
        for (String i in state.breed) {
          data.addAll(await Api().fetchListImages(i));
        }
        data.shuffle();
        changeListImages(listImages: data);
        emit(state.copyWith(fetchImagesStatus: LoadStatus.success));
      } catch (e) {
        emit(state.copyWith(fetchImagesStatus: LoadStatus.fail));
      }
    } else {
      emit(state.copyWith(fetchImagesStatus: LoadStatus.initial));
    }
  }
}
