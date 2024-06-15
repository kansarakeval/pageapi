import 'package:flutter/material.dart';
import 'package:pageapi/screen/page/model/page_model.dart';
import 'package:pageapi/screen/page/provider/page_provider.dart';
import 'package:provider/provider.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({super.key});

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  PageProvider? providerw;
  PageProvider? providerr;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PageProvider>().getPage();
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          context.read<PageProvider>().getPage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    providerw = context.watch<PageProvider>();
    providerr = context.read<PageProvider>();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Images"),
            centerTitle: true,
          ),
          body: FutureBuilder(
            future: providerw!.pageModel,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                PageModel? pageModel = snapshot.data;
                providerr!.hitsList.addAll(pageModel!.hitsList!);
                return GridView.builder(
                  controller: scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, mainAxisExtent: 150),
                  itemCount: providerw!.hitsList.length + 1,
                  itemBuilder: (context, index) {
                    return index > providerr!.hitsList.length - 1
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Image.network(
                            "${providerr!.hitsList[index].previewURL}",
                            fit: BoxFit.cover,
                          );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
