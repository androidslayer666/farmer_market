import 'package:farmer_market/app/bloc/app_bloc.dart';
import 'package:farmer_market/app/bloc/app_state.dart';
import 'package:farmer_market/presentation/navigation/arguments.dart';
import 'package:farmer_market/presentation/shared/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product/category.dart' as models;
import 'filter_screen_cubit.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as FilterArguments?;
    return BlocProvider(
      create: (context) => FilterScreenCubit(args?.filter),
      child: BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
        return BlocBuilder<FilterScreenCubit, FilterScreenState>(
            builder: (context, filterState) {
          return Scaffold(
              appBar: CustomAppBar(user: appState.currentUser),
              body: FilterScreenBody(state: filterState));
        });
      }),
    );
  }
}

class FilterScreenBody extends StatelessWidget {
  const FilterScreenBody({Key? key, required this.state}) : super(key: key);

  final FilterScreenState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FilterScreenCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FilterScreenCategoryGrid(
            state: state,
            cubit: cubit,
          ),
          FilterScreenPriceInputs(
            state: state,
            cubit: cubit,
          ),
          const Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (state.filter.categories?.isNotEmpty == true ||
                  state.filter.topPrice != null ||
                  state.filter.bottomPrice != null)
                ElevatedButton(
                    onPressed: () {
                      cubit.clearFilters();
                    },
                    child: const Text('Clear')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(state.filter);
                  },
                  child: const Text('confirm')),
            ],
          )
        ],
      ),
    );
  }
}

class FilterScreenPriceInputs extends StatelessWidget {
  const FilterScreenPriceInputs(
      {Key? key, required this.state, required this.cubit})
      : super(key: key);

  final FilterScreenState state;
  final FilterScreenCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Price from '),
        SizedBox(
            width: 100,
            child: TextFormField(
              initialValue: state.filter.bottomPrice != null
                  ? state.filter.bottomPrice.toString()
                  : '',
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                cubit.setBottomPrice(int.parse(value));
              },
            )),
        const Text('  to '),
        SizedBox(
            width: 100,
            child: TextFormField(
              initialValue: state.filter.topPrice != null
                  ? state.filter.topPrice.toString()
                  : '',
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                cubit.setTopPrice(int.parse(value));
              },
            )),
      ],
    );
  }
}

class FilterScreenCategoryGrid extends StatelessWidget {
  const FilterScreenCategoryGrid(
      {Key? key, required this.state, required this.cubit})
      : super(key: key);

  final FilterScreenState state;
  final FilterScreenCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: GridView.builder(
          itemCount: models.Category.values.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () =>
                    cubit.addOrRemoveCategory(models.Category.values[index]),
                child: Center(
                  child: Card(
                    color: state.filter.categories?.contains(
                        models.Category.values[index]) ==
                        true
                        ? Theme.of(context).bottomAppBarColor
                        : Theme.of(context).backgroundColor,
                    child: SizedBox(
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(
                          models.Category.values[index].name,
                          style: TextStyle(
                              color: state.filter.categories?.contains(
                                          models.Category.values[index]) ==
                                      true
                                  ? Theme.of(context).indicatorColor
                                  : Theme.of(context).focusColor),
                        ),
                      ),
                    ),
                  ),
                ));
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
        ),
      ),
    );
  }
}
