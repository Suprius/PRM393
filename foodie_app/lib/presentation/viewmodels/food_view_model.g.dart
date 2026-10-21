// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(foodRepository)
final foodRepositoryProvider = FoodRepositoryProvider._();

final class FoodRepositoryProvider
    extends $FunctionalProvider<FoodRepository, FoodRepository, FoodRepository>
    with $Provider<FoodRepository> {
  FoodRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodRepositoryHash();

  @$internal
  @override
  $ProviderElement<FoodRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FoodRepository create(Ref ref) {
    return foodRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FoodRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FoodRepository>(value),
    );
  }
}

String _$foodRepositoryHash() => r'4d034dde197be7b6c7855c971ef67efcdcbd9005';

@ProviderFor(categories)
final categoriesProvider = CategoriesProvider._();

final class CategoriesProvider
    extends $FunctionalProvider<List<Category>, List<Category>, List<Category>>
    with $Provider<List<Category>> {
  CategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  $ProviderElement<List<Category>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Category> create(Ref ref) {
    return categories(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Category> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Category>>(value),
    );
  }
}

String _$categoriesHash() => r'971aa0faa19cb795e23dd62f4655455b6a898bc2';

@ProviderFor(popularFoods)
final popularFoodsProvider = PopularFoodsProvider._();

final class PopularFoodsProvider
    extends $FunctionalProvider<List<Food>, List<Food>, List<Food>>
    with $Provider<List<Food>> {
  PopularFoodsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'popularFoodsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popularFoodsHash();

  @$internal
  @override
  $ProviderElement<List<Food>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Food> create(Ref ref) {
    return popularFoods(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Food> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Food>>(value),
    );
  }
}

String _$popularFoodsHash() => r'11f90a844ae4e22440b3a512439f53ceeb69be00';

@ProviderFor(FoodFilter)
final foodFilterProvider = FoodFilterProvider._();

final class FoodFilterProvider
    extends $NotifierProvider<FoodFilter, FoodFilterState> {
  FoodFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodFilterHash();

  @$internal
  @override
  FoodFilter create() => FoodFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FoodFilterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FoodFilterState>(value),
    );
  }
}

String _$foodFilterHash() => r'5c35b07bd9c730b5134e2ecf92f57027ad00200a';

abstract class _$FoodFilter extends $Notifier<FoodFilterState> {
  FoodFilterState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<FoodFilterState, FoodFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FoodFilterState, FoodFilterState>,
              FoodFilterState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(visibleFoods)
final visibleFoodsProvider = VisibleFoodsProvider._();

final class VisibleFoodsProvider
    extends $FunctionalProvider<List<Food>, List<Food>, List<Food>>
    with $Provider<List<Food>> {
  VisibleFoodsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visibleFoodsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visibleFoodsHash();

  @$internal
  @override
  $ProviderElement<List<Food>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Food> create(Ref ref) {
    return visibleFoods(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Food> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Food>>(value),
    );
  }
}

String _$visibleFoodsHash() => r'bad2949f45f42b78d4ad81aead8c036fb8cb28b5';

@ProviderFor(foodsPageTitle)
final foodsPageTitleProvider = FoodsPageTitleProvider._();

final class FoodsPageTitleProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  FoodsPageTitleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodsPageTitleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodsPageTitleHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return foodsPageTitle(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$foodsPageTitleHash() => r'c564a6d203d094f138ac55d71787b5630c16db1b';
