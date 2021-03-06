

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/filter/filter.dart';
import '../models/product/product.dart';
import '../repository/constants.dart';

Query<Map<String, dynamic>> firestoreQueryFilteringBuilder (FirebaseFirestore firestore, Filter? filter, String region) {

  Query<Map<String, dynamic>> _query = firestore.collection(fireStoreNameProductTable).where('region', isEqualTo: region);
  if(filter?.categories?.isNotEmpty == true){
    _query = _query.where('category', whereIn: filter?.categories!.map((e) => e.name).toList());
  }
  if(filter?.bottomPrice != null) {
    _query = _query.where('price', isGreaterThanOrEqualTo: filter?.bottomPrice);
  }
  if(filter?.topPrice != null) {
    _query = _query.where('price', isLessThanOrEqualTo: filter?.topPrice);
  }
  if(filter?.bottomPrice != null || filter?.topPrice != null){
    _query = _query.orderBy('price');
  } else {
    _query = _query.orderBy('id');
  }

  return _query;
}