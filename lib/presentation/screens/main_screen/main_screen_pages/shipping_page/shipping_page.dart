import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../app/bloc/app_bloc.dart';
import '../../../../../app/bloc/app_state.dart';
import '../../../../../data/models/order/order.dart';
import '../../../../../data/models/user/user.dart';
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
              listFinishedOrders: shippingState.listFinishedOrders, listCurrentOrders: shippingState.listCurrentOrders, user: appState.currentUser);
        },
      );
    });
  }
}

class ShippingPageBody extends StatefulWidget {
  const ShippingPageBody(
      {Key? key, required this.listCurrentOrders, required this.listFinishedOrders, required this.user})
      : super(key: key);

  final List<Order> listCurrentOrders;
  final List<Order> listFinishedOrders;
  final User? user;

  @override
  State<ShippingPageBody> createState() => _ShippingPageBodyState();
}

class _ShippingPageBodyState extends State<ShippingPageBody> {
  int currentTab = 0;


  @override
  Widget build(BuildContext context) {
    if (widget.listCurrentOrders.isEmpty == true) {
      return SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text('There are no orders yet',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade500)),
        ),
      ));
    }

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentTab = 0;
                      });
                    },
                    child: const Text('Current orders')),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                      });
                    },
                    child: const Text('Finished orders'))
              ],
            ),
          ),
          currentTab == 0 ?
          Expanded(
            child: ListView.builder(
                itemCount: widget.listCurrentOrders.length,
                itemBuilder: (context, index) => ListOrdersItemWidget(
                    order: widget.listCurrentOrders[index], user: widget.user)),
          )
              :
          Expanded(
            child: ListView.builder(
                itemCount: widget.listFinishedOrders.length,
                itemBuilder: (context, index) => ListOrdersItemWidget(
                    order: widget.listFinishedOrders[index], user: widget.user)),
          )
        ],
      ),
    );
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Order # '),
                  Text(
                    order.id?.substring(0, order.id?.indexOf('-') ?? 0) ?? '',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...order.cartItems.map((e) => Text(
                          (e.product?.name ?? '') +
                              '.....' +
                              e.qty.toString() +
                              ' pcs.'))
                    ]),
              ),
              const SizedBox(
                height: 20,
              ),
              if (order.confirmedShippingDate != null)
                Row(
                  children: [
                    const Text('Shipping date confirmed on '),
                    Text(
                      DateFormat('dd.MM.yyyy')
                          .format(order.confirmedShippingDate!),
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          _selectDate(context, DateTime.now(), order);
                        },
                        child: const Icon(Icons.edit))
                  ],
                ),
              if (user?.isSeller == true && order.confirmedShippingDate == null)
                GestureDetector(
                    onTap: () {
                      _selectDate(context, DateTime.now(), order);
                    },
                    child: SizedBox(
                        width: double.infinity,
                        child: Container(
                          child: const Center(
                              child: Text('Confirm shipping date')),
                          color: Colors.grey.shade400,
                        )))
            ],
          ),
        ),
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
