import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoscreen/modules/business/business_screen.dart';
import 'package:todoscreen/modules/science/science_screen.dart';
import 'package:todoscreen/modules/sports/sports_screen.dart';
import 'package:todoscreen/shared/cubit/states.dart';
import 'package:todoscreen/shared/network/local/cach_helper.dart';
import 'package:todoscreen/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context)=> BlocProvider.of(context);

  int currentIndex =0;
  List<BottomNavigationBarItem>bottomItem =
  [
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
      label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
      label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined),
      label: 'Science'
    ),
  //  BottomNavigationBarItem(
      //  icon: Icon(Icons.settings),
      //label: 'Settings'
    //),
  ];
  List<Widget>screens =
      [
        BusinessScreen(),
        SportsScreen(),
        ScienceScreen(),
        //SettingsScreen(),
      ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index ;
    if(index==1)
      getSports();
    if(index==2)
      getScience();
    emit(NewsBottomNavState());
  }
  List<dynamic> business = [];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
        {
          'country' : 'us',
          'category' : 'business',
          'apikey' : '46e47fc8f18b44b092a2f51ae259fbe3',
        },
    ).then((value)
    {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }
  List<dynamic> sports = [];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length==0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country' : 'us',
            'category' : 'sports',
            'apikey' : '46e47fc8f18b44b092a2f51ae259fbe3',
          },
        ).then((value)
        {
          sports = value.data['articles'];
          print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      }else{
      emit(NewsGetSportsSuccessState());
    }
  }
  List<dynamic> science = [];
  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length==0)
      {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country' : 'us',
            'category' : 'science',
            'apikey' : '46e47fc8f18b44b092a2f51ae259fbe3',
          },
        ).then((value)
        {
          science = value.data['articles'];
          print(science[0]['title']);
          emit(NewsGetScienceSuccessState());
        }).catchError((error)
        {
          print(error.toString());
          emit(NewsGetScienceErrorState(error.toString()));
        });
      }else{
      emit(NewsGetScienceSuccessState());
    }

  }
  List<dynamic> search = [];
  void getSearch( String value)
  {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q' :'$value',
        'apikey' : '46e47fc8f18b44b092a2f51ae259fbe3',
      },
    ).then((value)
    {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
  bool isDark = false;
  void changeNewsMode()
  {
    isDark = !isDark;
    CasheHelper.putData(key: 'isDark', value: isDark).then((value)
    {
      emit(NewsChangeModeState());
    });

  }

}
class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}