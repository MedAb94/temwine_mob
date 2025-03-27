import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temwin_front_app/Application/BusinessLogic/Cubit/cubit/update_invoice_state.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';

class UpdateInvoiceCubit extends Cubit<UpdateInvoiceState> {
  UpdateInvoiceCubit() : super(UpdateInvoiceState(data: {}));

  void incrementQuantity({required ProductsEntity p}) {
    // Map<ProductsEntity, int>? map = state;
    // if (map!.containsKey(p)) {
    //   map[p] = map[p]! + 1; // Update value
    // }
    // emit(map);

    // Create a copy of the current map
    final updatedProducts = Map<ProductsEntity, num>.from(state.data);

    // Update or insert the product
    updatedProducts.update(p, (value) => value + (p.smallestUnit ?? 0),
        ifAbsent: () => p.smallestUnit ?? 0);

    debugPrint('incrementQuantity cubit : $updatedProducts');

    // Emit the new state with the updated map
    emit(state.copyWith(data: updatedProducts));
  }

  void decrementQuantity({required ProductsEntity p}) {
    // Create a copy of the current map
    final updatedProducts = Map<ProductsEntity, num>.from(state.data);

    // Update or insert the product
    updatedProducts.update(p, (value) => value - (p.smallestUnit ?? 0),
        ifAbsent: () => (p.smallestUnit ?? 0));

    debugPrint('decrementQuantity cubit : $updatedProducts');

    // Emit the new state with the updated map
    emit(state.copyWith(data: updatedProducts));
  }

  addNewRow({required ProductsEntity p}) {
    // Map<ProductsEntity, int>? map = state;

    // debugPrint('addNewRow before map : $map');

    // map ??= <ProductsEntity, int>{};

    // map.putIfAbsent(p, () => 1);

    // debugPrint('addNewRow after map : $map');

    // emit(map);

    // Create a copy of the current map
    final data = Map<ProductsEntity, num>.from(state.data);

    // Insert or update the map with the key 'p'
    data.putIfAbsent(p, () => (p.smallestUnit ?? 0));

    // Emit the new state with the updated map
    emit(state.copyWith(data: data));
  }

  removeRow({required ProductsEntity p}) {
    // Create a copy of the current map
    final data = Map<ProductsEntity, num>.from(state.data);

    data.remove(p);

    // Emit the new state with the updated map
    emit(state.copyWith(data: data));
  }
}
