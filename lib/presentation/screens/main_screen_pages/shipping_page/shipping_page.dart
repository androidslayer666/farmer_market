import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../app/bloc/app_bloc.dart';
import '../../../../app/bloc/app_event.dart';
import '../../../../app/bloc/app_state.dart';
import '../../../../data/models/order/order.dart';
import '../../../../data/models/user/user.dart';
import 'bloc/shipping_bloc.dart';
import 'bloc/shipping_state.dart';

class ShippingPage extends StatelessWidget {
  const ShippingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
      return BlocBuilder<ShippingBloc, ShippingState>(
        builder: (context, shippingState) {
          return ShippingPageBody(
              listOrders: shippingState.listOrders, user: appState.currentUser);
        },
      );
    });
  }
}

class ShippingPageBody extends StatelessWidget {
  const ShippingPageBody(
      {Key? key, required this.listOrders, required this.user})
      : super(key: key);

  final List<Order> listOrders;
  final User? user;

  @override
  Widget build(BuildContext context) {
    print('ShippingPageBody rebuild');
    return ListView.builder(
        itemCount: listOrders.length,
        itemBuilder: (context, index) =>
            ListOrdersItemWidget(order: listOrders[index], user: user));
  }
}

class ListOrdersItemWidget extends StatelessWidget {
  const ListOrdersItemWidget(
      {Key? key, required this.order, required this.user})
      : super(key: key);

  final Order order;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(order.id?.substring(0, order.id?.indexOf('-') ?? 0) ?? ''),
          SizedBox(
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: order.cartItems.length,
                itemBuilder: (context, index) =>
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      SizedBox(
                          width: 300,
                          child: Card(
                            child: Row(
                              children: [
                                order.cartItems[index].product?.pictureUrl !=
                                    null
                                    ? CachedNetworkImage(
                                  imageUrl: order.cartItems[index]
                                      .product!.pictureUrl!,
                                  height: 100,
                                )
                                    : Image.asset(
                                    'assets/images/placeholder-image.png'),
                                Text((order.cartItems[index].product?.name ??
                                    '') +
                                    ' x ' +
                                    order.cartItems[index].qty.toString())
                              ],
                            ),
                          )),
                    ])),
          ),
          order.confirmedShippingDate != null
              ? Text(
              'Shipping date confirmed on ${DateFormat('dd.MM.yyyy').format(
                  order.confirmedShippingDate!)}')
              : user?.isSeller == true
              ? Text('Please confirm a shipping date for this order')
              : Container(),
          if (user?.isSeller == true)
            ElevatedButton(
                onPressed: () {
                  _selectDate(context, DateTime.now(), order);
                },
                child: const Text('Confirm shipping date'))
        ],
      ),
    );
  }

  void _selectDate(BuildContext context, DateTime date, Order order) async {
    ShippingBloc appBloc = context.read<ShippingBloc>();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != date) {
      appBloc.add(ShippingEventConfirmDateShipping(order, picked));
    }
  }
}
