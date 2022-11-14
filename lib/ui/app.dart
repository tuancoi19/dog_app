import 'package:dog_app/enum/load_status.dart';
import 'package:dog_app/ui/app_cubit.dart';
import 'package:dog_app/ui/app_state.dart';
import 'package:dog_app/ui/widget/Item_image.dart';
import 'package:dog_app/ui/widget/item_breed.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AppCubit cubit;
  ScrollController scrollController = ScrollController();
  late final int length;

  @override
  void initState() {
    super.initState();
    length = 10;
    cubit = BlocProvider.of(context);
    cubit.fetchListBreeds();
    scrollController.addListener(() async {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        Future.delayed(const Duration(milliseconds: 500),
            () => cubit.changeLength(length: cubit.state.length + length));
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
                                List<int> selected =
                                    state.selectedIndex.toList();
                                selected.contains(index)
                                    ? selected.remove(index)
                                    : selected.add(index);
                                cubit.changeSelectedIndex(
                                    selectedIndex: selected);
                                cubit.changeLength(length: 10);
                              },
                              isSelected: state.selectedIndex.contains(index),
                              name: state.listBreeds[index]),
                          itemCount: state.listBreeds.length,
                          scrollDirection: Axis.horizontal,
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
              Expanded(
                  flex: 9,
                  child: state.fetchImagesStatus == LoadStatus.success
                      ? RefreshIndicator(
                          onRefresh: () async {
                            cubit.changeLength(length: 10);
                            await cubit.fetchListImage();
                          },
                          child: ListView.builder(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                return index < state.length
                                    ? ItemImage(url: state.listImages[index])
                                    : index < state.listImages.length
                                        ? const SizedBox(
                                            width: double.infinity,
                                            height: 50,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          )
                                        : const SizedBox();
                              },
                              itemCount: state.length + 1),
                        )
                      : state.fetchImagesStatus == LoadStatus.initial
                          ? const SizedBox()
                          : const Center(child: CircularProgressIndicator())),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => selectedListDialog(),
            );
          },
          tooltip: 'Selected List',
          child: const Icon(Icons.list),
        ),
      );
    });
  }

  Widget selectedListDialog() {
    List<int> data = cubit.state.selectedIndex.toList();
    List<bool> isChecked = List<bool>.filled(cubit.state.breed.length, true);
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: const Text('Selected Breeds'),
        content: SizedBox(
          width: 300,
          height: 500,
          child: ListView.builder(
            itemCount: cubit.state.selectedIndex.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(cubit.state.breed[index]),
                value: isChecked[index],
                onChanged: (value) {
                  setState(
                    () {
                      isChecked[index] = value!;
                    },
                  );
                  value == false
                      ? data.remove(cubit.state.selectedIndex[index])
                      : data.contains(cubit.state.selectedIndex[index])
                          ? null
                          : data.add(cubit.state.selectedIndex[index]);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                cubit.changeSelectedIndex(selectedIndex: data);
                cubit.changeLength(length: 10);
              },
              child: const Text('OK')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'))
        ],
      );
    });
  }
}
