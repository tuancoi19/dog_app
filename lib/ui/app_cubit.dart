import 'package:dog_app/enum/load_status.dart';
import 'package:dog_app/network/api.dart';
import 'package:dog_app/ui/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void changeListBreeds({required List<String> listBreeds}) {
    emit(state.copyWith(listBreeds: listBreeds));
  }

  void changeBreed({required String breed}) {
    emit(state.copyWith(breed: breed));
  }

  void changeListImages({required List<String> listImages}) {
    emit(state.copyWith(listImages: listImages));
  }

  void changeSelectedIndex({required int selectedIndex}) {
    emit(state.copyWith(selectedIndex: selectedIndex));
  }

  void changeLoadMore({required bool loadMore}) {
    emit(state.copyWith(loadMore: loadMore));
  }

  Future<void> fetchListBreeds() async {
    emit(state.copyWith(fetchBreedsStatus: LoadStatus.loading));
    try {
      List<String> data = await Api().fetchListBreeds();
      changeListBreeds(listBreeds: data);
      changeBreed(breed: data[0]);
      fetchListImage();
      emit(state.copyWith(fetchBreedsStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(fetchBreedsStatus: LoadStatus.fail));
    }
  }

  Future<void> fetchListImage() async {
    emit(state.copyWith(fetchImagesStatus: LoadStatus.loading));
    try {
      List<String> data = await Api().fetchListImages(state.breed);
      changeListImages(listImages: data);
      emit(state.copyWith(fetchImagesStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(fetchImagesStatus: LoadStatus.fail));
    }
  }
}
