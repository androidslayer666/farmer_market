import 'package:farmer_market/app/bloc/app_bloc.dart';
import 'package:farmer_market/app/bloc/app_state.dart';
import 'package:farmer_market/presentation/navigation/arguments.dart';
import 'package:farmer_market/presentation/shared/app_bar.dart';
import 'package:farmer_market/presentation/shared/text_input_custom.dart';
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

class FilterScreenBody extends StatefulWidget {
  const FilterScreenBody({Key? key, required this.state}) : super(key: key);

  final FilterScreenState state;

  @override
  State<FilterScreenBody> createState() => _FilterScreenBodyState();
}

class _FilterScreenBodyState extends State<FilterScreenBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FilterScreenCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FilterScreenCategoryGrid(
            state: widget.state,
            cubit: cubit,
          ),
          FilterScreenPriceInputs(
            state: widget.state,
            cubit: cubit,
          ),
          const Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AnimatedOpacity(
                opacity: widget.state.filter.isEmpty() ? 0 : 1,
                duration: const Duration(milliseconds: 200),
                child: ElevatedButton(
                    onPressed: () {
                      cubit.clearFilters();
                    },
                    child: const Text('Clear')),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(widget.state.filter);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Theme.of(context).bottomAppBarColor)),
                child: const Icon(Icons.done),
              ),
            ],
          )
        ],
      ),
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
                    color: state.filter.categories
                                ?.contains(models.Category.values[index]) ==
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

class FilterScreenPriceInputs extends StatefulWidget {
  const FilterScreenPriceInputs(
      {Key? key, required this.state, required this.cubit})
      : super(key: key);

  final FilterScreenState state;
  final FilterScreenCubit cubit;

  @override
  State<FilterScreenPriceInputs> createState() =>
      _FilterScreenPriceInputsState();
}

class _FilterScreenPriceInputsState extends State<FilterScreenPriceInputs> {
  late final TextEditingController bottomPriceController;
  late final TextEditingController topPriceController;

  @override
  void initState() {
    super.initState();
    final bottomPrice = widget.state.filter.bottomPrice != null
        ? widget.state.filter.bottomPrice.toString()
        : '';
    final topPrice = widget.state.filter.topPrice != null
        ? widget.state.filter.topPrice.toString()
        : '';

    bottomPriceController = TextEditingController()..text = bottomPrice;
    topPriceController = TextEditingController()..text = topPrice;

    bottomPriceController.addListener(() {
      widget.cubit.setBottomPrice(bottomPriceController.text);
    });

    topPriceController.addListener(() {
      widget.cubit.setTopPrice(topPriceController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.state.filter.isEmpty()){
      bottomPriceController.clear();
      topPriceController.clear();
    }
    return Row(
      children: [
        const Text('Price from '),
        SizedBox(
            width: 100,
            child: TextInputCustom(
              controller: bottomPriceController,
              textInputType: TextInputType.number,
              textInputFormatter: FilteringTextInputFormatter.digitsOnly,
            )),
        const Text('  to '),
        SizedBox(
            width: 100,
            child: TextInputCustom(
              controller: topPriceController,
              textInputType: TextInputType.number,
              textInputFormatter: FilteringTextInputFormatter.digitsOnly,
            )),
      ],
    );
  }

  @override
  void dispose() {
    bottomPriceController.dispose();
    topPriceController.dispose();
    super.dispose();
  }
}
