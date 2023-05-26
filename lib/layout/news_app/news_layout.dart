import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoscreen/modules/search_screen/search_screen.dart';
import 'package:todoscreen/shared/cubit/cubit.dart';
import 'package:todoscreen/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state)
        {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions:
              [
               IconButton(onPressed: ()
               {
                 Navigator.push(context, MaterialPageRoute(builder:(context)=>SearchScreen()));
               },
                   icon: Icon(Icons.search),
               ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
                onTap: (index)
                {
                  cubit.changeBottomNavBar(index);
                },
                items: cubit.bottomItem
            ),
          );
        },
      ),
    );
  }
}
