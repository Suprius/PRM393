# Foodie App

Flutter demo app for browsing food by category, built with MVVM, Riverpod, and Riverpod Generator.

## Features

- Home screen with greeting, search, horizontally scrollable categories, and popular foods.
- Popular foods are derived from repository data with `star >= 4.5`.
- Selecting a category opens Foods and filters the list.
- “See all” opens Foods with all items.
- Foods supports live text search and a responsive grid.
- Bottom navigation manages Home, Foods, Favorites, and Profile.
- Favorites and Profile intentionally contain placeholders as required.

## Architecture

```text
lib/
├── data/repositories/          # Mock repository and category-food mapping
├── domain/models/              # Category, Food
├── domain/repositories/        # Repository contract
├── presentation/pages/         # Home, Foods, shell, placeholders
├── presentation/viewmodels/    # Riverpod generated providers/ViewModels
├── presentation/widgets/       # Reusable UI components
└── core/theme/                  # Colors and theme
```

## Run

```bash
flutter pub get
dart run build_runner build
flutter run
```

Food photos use HTTPS URLs from Unsplash. The UI shows a local icon fallback if an image cannot be loaded.
