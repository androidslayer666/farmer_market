
import '../../../data/models/product/category.dart' as models;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/filter/filter.dart';
import 'bloc/main_bloc.dart';
import 'bloc/main_event.dart';

class MainScreenFilters extends StatelessWidget {
  const MainScreenFilters({Key? key, required this.filter}) : super(key: key);

  final Filter filter;

  @override
  Widget build(BuildContext context) {

    final mainBloc = context.read<MainBloc>();
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Theme.of(context).backgroundColor,
            ),

            height: MediaQuery.of(context).size.height-200,
            width: MediaQuery.of(context).size.width-100,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context, builder: (context) => AlertDialog(
                        title: Text('Choose category'),
                        content: FilterChooseCategoryDialog(
                          filter: filter,
                          mainBloc: mainBloc,
                        )
                    ));
                  },
                  child: const Text('choose category'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FilterChooseCategoryDialog extends StatelessWidget {
  const FilterChooseCategoryDialog({Key? key, required this.mainBloc, required this.filter}) : super(key: key);

  final MainBloc mainBloc;
  final Filter filter;

  @override
  Widget build(BuildContext context) {
    return Column(children: [...models.Category.values.map((e) => GestureDetector(
        onTap: (){
          // mainBloc.add(MainScreenFilterChanged(filter.categories?.contains(e) == true?
          // filter.copyWith(categories: [...?filter.categories]..remove(e))
          //     : filter.copyWith(categories: [...?filter.categories,e])));
        },
        child: Text(e.name,
        //   style: TextStyle(color: filter.categories?.contains(e) == true?
        // Theme.of(context).primaryColor : Theme.of(context).backgroundColor)

          ))),
    ]);
  }
}
