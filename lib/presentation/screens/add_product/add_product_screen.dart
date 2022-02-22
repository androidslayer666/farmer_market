import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/getit_setup.dart';
import '../../../repository/auth_repository/auth_repository.dart';
import '../../../repository/models/product.dart';
import '../../../repository/products/product_repository.dart';
import '../../shared/text_input_custom.dart';
import 'bloc/add_product_bloc.dart';
import 'bloc/add_product_event.dart';
import 'bloc/add_product_state.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) {
        return AddProductBloc(
          authRepository: locator<AuthRepository>(),
            productRepository: locator<ProductRepository>())
          ..add(const AddProductInit());
      },
      child: const AddProductScreenBody(),
    ));
  }
}

class AddProductScreenBody extends StatefulWidget {
  const AddProductScreenBody({Key? key}) : super(key: key);

  @override
  State<AddProductScreenBody> createState() => _AddProductScreenBodyState();
}

class _AddProductScreenBodyState extends State<AddProductScreenBody> {

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController unitController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    unitController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    unitController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final signInBloc = context.read<AddProductBloc>();
    return BlocConsumer<AddProductBloc, AddProductState>(
      listener: (context, state) {
        print(state);
        state.existedName != null ? nameController.text = state.existedName! : {};
        state.existedDescription != null ? descriptionController.text = state.existedDescription! : {};
        state.existedPrice != null ? priceController.text = state.existedPrice! : {};
        state.existedUnit != null ? unitController.text = state.existedUnit.toString() : {};
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: const Text('Add product'),
        ),
        body: SingleChildScrollView(
            reverse: true,
            child: Column(children: [
              TextInputCustom(
                icon: const Icon(Icons.person),
                controller: nameController,
                hint: 'Product',
                onChanged: (value) {
                  signInBloc.add(AddProductNameChanged(value));
                },
              ),
              TextInputCustom(
                icon: const Icon(Icons.text_snippet),
                controller: descriptionController,
                hint: 'Description',
                onChanged: (value) {
                  signInBloc.add(AddProductDescriptionChanged(value));
                },
              ),
              TextInputCustom(
                icon: const Icon(Icons.text_snippet),
                controller: priceController,
                textInputType: TextInputType.number,
                hint: 'Price',
                onChanged: (value) {
                  signInBloc.add(AddProductPriceChanged(value));
                },
              ),
              DropdownButton<Unit>(
                value: state.unit,
                items: <Unit>[Unit.litres, Unit.kilos].map((Unit value) {
                  return DropdownMenuItem<Unit>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
                onChanged: (value) {
                  signInBloc.add(AddProductUnitChanged(value!));
                },
              ),
              const Divider(height: 30),
              if (state.isImageLoading == true)
                ConstrainedBox(
                    constraints:
                        const BoxConstraints(minHeight: 50, minWidth: 50),
                    child: const CircularProgressIndicator())
              else if (state.productImage == null)
                IconButton(
                  onPressed: () {
                    signInBloc.add(const AddProductImageAddClicked());
                  },
                  icon: Image.asset('assets/images/avatar_blank.png'),
                  iconSize: 50,
                )
              else
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 50, minWidth: 50),
                  child: CircleAvatar(
                    backgroundImage: MemoryImage(state.productImage!),
                    radius: 50,
                  ),
                ),
              const Divider(height: 30),
              Stack(
                alignment: Alignment.center,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    if (state.isLoading == true)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () {
                          signInBloc.add(const AddProductSubmitted());
                        },
                        child: const Text('Save'),
                      ),
                  ]),
                ],
              ),
            ])),
      ),
    );
  }
}
