import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/search/cubit.dart';

import '../../shared/cubit/search/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var formKey = GlobalKey<FormState>();
            var cubit = SearchCubit.get(context);
            var searchController = TextEditingController();
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultTextField(
                          controller: searchController,
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Enter Search Text';
                            }
                            return null;
                          },
                          onFieldSubmitted: (String text) {
                            cubit.search(text);
                          },
                          label: 'Search',
                          prefixIcon: Icons.search),
                      const SizedBox(
                        height: 15,
                      ),
                      if (state is SearchLoadingState)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 15,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => buildListProduct(
                                  cubit.model!.data!.data![index], context,oldPrice: true),
                              separatorBuilder: (context, index) => divider(),
                              itemCount: cubit.model!.data!.data!.length),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
