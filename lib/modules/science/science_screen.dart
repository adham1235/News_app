import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoscreen/shared/components/components.dart';
import 'package:todoscreen/shared/cubit/cubit.dart';
import 'package:todoscreen/shared/cubit/states.dart';

class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:  (context,state)
      {
        var list = NewsCubit.get(context).science;
        return ConditionalBuilder(
          condition: list.length > 0,
          builder : (context) =>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context,index)=>Padding(
              padding: const EdgeInsets.all(10.0),
              child: Divider(
                indent: 1,
                endIndent: 1,
                color: Colors.white,
              ),
            ),
            separatorBuilder: (context,index)=>buildArticleItem(list[index],context),
            itemCount: list.length,
          ),
          fallback : (context) =>Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
