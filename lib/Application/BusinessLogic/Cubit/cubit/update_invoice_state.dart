import 'package:temwin_front_app/Domain/entities/product_entity.dart';

class UpdateInvoiceState {
  final Map<ProductsEntity, num> data;

  UpdateInvoiceState({required this.data});

  // CopyWith method to create a new instance with updated values
  UpdateInvoiceState copyWith({Map<ProductsEntity, num>? data}) {
    return UpdateInvoiceState(
      data: data ?? this.data,
    );
  }
}
