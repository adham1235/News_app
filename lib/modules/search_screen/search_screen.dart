import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoscreen/shared/components/components.dart';
import 'package:todoscreen/shared/cubit/cubit.dart';
import 'package:todoscreen/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return'search must not be empty';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 2.0,
                          )),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade500,
                      ),
                      contentPadding: EdgeInsets.only(left: 10),
                      hintText: 'Search ',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14))
                  ),
                ),
              ),
              Expanded(child: buildArticleItem(list, context)),
            ],
          ),
        );
      },
    );
  }
}
