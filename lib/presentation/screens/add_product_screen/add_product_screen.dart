import 'dart:typed_data';

import 'package:farmer_market/presentation/navigation/arguments.dart';
import 'package:farmer_market/presentation/navigation/navigation_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/di/getit_setup.dart';
import '../../../data/models/product/category.dart';
import '../../../data/models/product/product.dart';
import '../../../data/repository/product_repository/product_repository.dart';
import '../../../generated/l10n.dart';
import '../../../data/repository/auth_repository/auth_repository.dart';
import '../../shared/show_confirmation_dialogue.dart';
import '../../shared/text_input_custom.dart';
import 'bloc/add_product_bloc.dart';
import 'bloc/add_product_event.dart';
import 'bloc/add_product_state.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as AddProductArguments?;

    return Scaffold(
        body: BlocProvider(
      create: (context) {
        return AddProductBloc(
            authRepository: locator<AuthRepository>(),
            productRepository: locator<ProductRepository>())
          ..add(AddProductInit(args));
      },
      child: AddProductScreenBody(args: args),
    ));
  }
}

class AddProductScreenBody extends StatefulWidget {
  const AddProductScreenBody({Key? key, this.args}) : super(key: key);

  final AddProductArguments? args;

  @override
  State<AddProductScreenBody> createState() => _AddProductScreenBodyState();
}

class _AddProductScreenBodyState extends State<AddProductScreenBody> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController unitController;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final Product? product = widget.args?.product;
    nameController = TextEditingController(text: product?.name ?? '');
    descriptionController =
        TextEditingController(text: product?.description ?? '');
    priceController =
        TextEditingController(text: product?.price.toString() ?? '');
    unitController =
        TextEditingController(text: product?.unit.toString() ?? '');
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
    final _addProductBloc = context.read<AddProductBloc>();
    return BlocConsumer<AddProductBloc, AddProductState>(
      listener: (context, state) {
        if (state.deletingIsSuccessful == true) {
          navigateToMainScreen(context);
        }
        if (state.addingIsSuccessful == true) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Product added successfully"),
            duration: Duration(seconds: 1),
          ));
          navigateToMainScreen(context);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(S.of(context).addProductScreen_addProduct),
        ),
        body: SingleChildScrollView(
            reverse: true,
            child: Column(children: [
              _textInputs(_addProductBloc),
              _unitDropdown(state.unit, _addProductBloc),
              _categoryDropDown(Category.milk, _addProductBloc),
              const Divider(height: 30),
              _addProductImageWidget(
                  state.isImageLoading, state.productImage, _addProductBloc),
              const Divider(height: 30),
              _bottomButtonRow(state.isLoading, _addProductBloc)
            ])),
      ),
    );
  }

  Widget _bottomButtonRow(bool? isLoading, AddProductBloc addProductBloc) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (isLoading == true)
            const CircularProgressIndicator()
          else
            ElevatedButton(
              onPressed: () {
                addProductBloc.add(const AddProductSubmitted());
              },
              child: Text(S.of(context).addProductScreen_save),
            ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
            onPressed: () {
              _confirmDeleting(context, addProductBloc);
            },
            icon: const Icon(Icons.delete),
            iconSize: 50,
          )
        ])
      ],
    );
  }

  Widget _unitDropdown(Unit? unit, AddProductBloc addProductBloc){
    return DropdownButton<Unit>(
      value: unit,
      items: <Unit>[Unit.litres, Unit.kilos].map((Unit value) {
        return DropdownMenuItem<Unit>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
      onChanged: (value) {
        addProductBloc.add(AddProductUnitChanged(value!));
      },
    );
  }

  Widget _categoryDropDown(Category? category, AddProductBloc addProductBloc){
    return DropdownButton<Category>(
      value: category,
      items: <Category>[Category.cheese, Category.meat, Category.milk].map((Category value) {
        return DropdownMenuItem<Category>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
      onChanged: (value) {
        addProductBloc.add(AddProductCategoryChanged(value!));
      },
    );
  }


  Widget _textInputs(AddProductBloc addProductBloc) {
    return Column(children: [
      TextInputCustom(
        icon: const Icon(Icons.person),
        controller: nameController,
        hint: S.of(context).addProductScreen_product,
        onChanged: (value) {
          addProductBloc.add(AddProductNameChanged(value));
        },
      ),
      TextInputCustom(
        icon: const Icon(Icons.text_snippet),
        controller: descriptionController,
        hint: S.of(context).addProductScreen_description,
        onChanged: (value) {
          addProductBloc.add(AddProductDescriptionChanged(value));
        },
      ),
      TextInputCustom(
        icon: const Icon(Icons.monetization_on),
        controller: priceController,
        textInputType: TextInputType.number,
        hint: S.of(context).addProductScreen_price,
        onChanged: (value) {
          addProductBloc.add(AddProductPriceChanged(value));
        },
      )
    ]);
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _addProductImageWidget(bool? isImageLoading, Uint8List? productImage,
      AddProductBloc addProductBloc) {
    if (isImageLoading == true) {
      return ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 50, minWidth: 50),
          child: const CircularProgressIndicator());
    } else {
      if (productImage == null) {
        return IconButton(
          onPressed: () {
            addProductBloc.add(const AddProductImageAddClicked());
          },
          icon: Image.asset('assets/images/avatar_blank.png'),
          iconSize: 50,
        );
      } else {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 50, minWidth: 50),
          child: CircleAvatar(
            backgroundImage: MemoryImage(productImage),
            radius: 50,
          ),
        );
      }
    }
  }

  // dialog to confirm deleting
  void _confirmDeleting(BuildContext context, Bloc bloc) {
    showConfirmationDialog(
        text: 'Are you sure you want to delete the product?',
        onConfirm: () {
          bloc.add(AddProductDeleteSubmitted(widget.args?.product?.id ?? ''));
        },
        context: context);
  }
}

