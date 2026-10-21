// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CartController)
final cartControllerProvider = CartControllerProvider._();

final class CartControllerProvider
    extends $NotifierProvider<CartController, Cart> {
  CartControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartControllerHash();

  @$internal
  @override
  CartController create() => CartController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Cart value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Cart>(value),
    );
  }
}

String _$cartControllerHash() => r'40462f588b20b46f703123c7542ba0a238a081b3';

abstract class _$CartController extends $Notifier<Cart> {
  Cart build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Cart, Cart>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Cart, Cart>,
              Cart,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
