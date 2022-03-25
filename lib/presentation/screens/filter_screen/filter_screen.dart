import 'package:farmer_market/app/bloc/app_bloc.dart';
import 'package:farmer_market/app/bloc/app_state.dart';
import 'package:farmer_market/presentation/shared/app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/filter/filter.dart';
import '../../../data/models/product/category.dart' as models;
import 'package:flutter/material.dart';

import '../../../data/models/user/user.dart';
import 'filter_screen_cubit.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterScreenCubit(),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) {
          return BlocBuilder<FilterScreenCubit, FilterScreenState>(
              builder: (context, filterState) {
            return Scaffold(
                appBar: CustomAppBar(user: appState.currentUser), body: const FilterScreenBody());
          });
        }
      ),
    );
  }
}

class FilterScreenBody extends StatefulWidget {
  const FilterScreenBody({Key? key}) : super(key: key);

  @override
  State<FilterScreenBody> createState() => _FilterScreenBodyState();
}

class _FilterScreenBodyState extends State<FilterScreenBody> {

  late TextEditingController priceFromConnector;
  late TextEditingController priceToConnector;

  @override
  void initState() {
    priceFromConnector = TextEditingController();
    priceToConnector = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    priceFromConnector.dispose();
    priceToConnector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterScreenCubit, FilterScreenState>(
        builder: (context, state) {
      print(state);
      final cubit = context.read<FilterScreenCubit>();
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: GridView.builder(
                      itemCount: models.Category.values.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () => cubit
                                .addOrRemoveCategory(models.Category.values[index]),
                            child: Center(
                              child: Card(
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
                                              ? Theme.of(context).backgroundColor
                                              : Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ));
                      }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),),
                ),
              ),
            ),
            Row(
              children: [
                const Text('Price from '),
                SizedBox(width: 100,child: TextField(
                  controller: priceFromConnector,
                  keyboardType: TextInputType.number,
                )),
                const Text('  to '),
                SizedBox(width: 100,child: TextField(
                  controller: priceToConnector,
                  keyboardType: TextInputType.number,
                )),
              ],
            ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop(state.filter);
            }, child: const Text('confirm'))
          ],
        ),
      );
    });
  }
}

