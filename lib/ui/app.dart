import 'package:dog_app/enum/load_status.dart';
import 'package:dog_app/ui/app_cubit.dart';
import 'package:dog_app/ui/app_state.dart';
import 'package:dog_app/ui/widget/Item_image.dart';
import 'package:dog_app/ui/widget/item_breed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AppCubit cubit;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of(context);
    cubit.fetchListBreeds();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        showDialog(context: context, builder: (context) => loadMoreDialog());
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.blue))),
                  child: state.fetchBreedsStatus == LoadStatus.success
                      ? ListView.builder(
                          itemBuilder: (context, index) => ItemBreed(
                              onPressed: () {
                                cubit.changeSelectedIndex(selectedIndex: index);
                                cubit.changeBreed(
                                    breed: state.listBreeds[index]);
                                cubit.fetchListImage();
                                cubit.changeLoadMore(loadMore: false);
                              },
                              isSelected: state.selectedIndex == index,
                              name: state.listBreeds[index]),
                          itemCount: state.listBreeds.length,
                          scrollDirection: Axis.horizontal,
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
              Expanded(
                flex: 9,
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: state.fetchImagesStatus == LoadStatus.success
                        ? ListView.builder(
                            controller: scrollController,
                            itemBuilder: (context, index) =>
                                ItemImage(url: state.listImages[index]),
                            itemCount: state.loadMore == false
                                ? 10
                                : state.listImages.length,
                          )
                        : const Center(child: CircularProgressIndicator())),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await cubit.fetchListImage();
            cubit.changeLoadMore(loadMore: false);
          },
          tooltip: 'Refresh',
          child: const Icon(Icons.refresh),
        ),
      );
    });
  }

  Widget loadMoreDialog() {
    return AlertDialog(
      title: const Text('Load more'),
      content: const Text('Do you want to load more images?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.changeLoadMore(loadMore: true);
            },
            child: const Text('Yes')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'))
      ],
    );
  }
}
