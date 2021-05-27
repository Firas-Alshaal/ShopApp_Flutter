import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app/shared/Components/component.dart';

class Search extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) return 'enter text to search';
                          },
                          onSubmit: (String text) {
                            SearchCubit.get(context).search(text);
                          },
                          label: 'Search',
                          prefix: Icons.search,
                          theme: Theme.of(context).textTheme.bodyText1,
                          colorIcon: Theme.of(context).iconTheme.color),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildListProduct(
                                  SearchCubit.get(context)
                                      .searchModel
                                      .data
                                      .data[index],
                                  context,
                                  oldPrice: false),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount: SearchCubit.get(context)
                                  .searchModel
                                  .data
                                  .data
                                  .length),
                        )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}