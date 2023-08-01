# Shop App with Flutter

## Description

This repository contains a Shop App built using Flutter, which serves as a sample e-commerce platform for online shopping. The app demonstrates the implementation of various concepts learned during a course, and it will be further developed to include additional features like "Add to Cart," "Profile," and more. Currently, the app includes eight screens: Onboarding, Login, Register, Home, Category, Favorites, and Settings, along with a basic search functionality. It also integrates an API using the Dio package for fetching data and utilizes shared preferences for storing user preferences.

## Features

- **Home Screen**: Displays featured products, popular items, or promotions to attract customers.

- **Category Screen**: Shows different product categories for users to explore specific items.

- **Favorites Screen**: Allows users to view their favorite products for quick access.

- **Settings Screen**: Enables users to customize the app's behavior, such as change name, phone number and email address .

- **Search Functionality**: Users can search for products by name or keywords.

- **API Integration**: Utilizes the Dio package to fetch data from a backend API.

- **Shared Preferences**: Stores user preferences, such as the selected theme, using shared preferences.

- **State Management with BLoC**: Uses the bloc and flutter_bloc packages for efficient state management.

- **Conditional Rendering**: Implements conditional rendering with conditional_builder_null_safety to handle null safety in the UI.

## Dependencies

The app utilizes the following key packages:

- [dio](https://pub.dev/packages/dio) - For making HTTP requests to the backend API.
- [shared_preferences](https://pub.dev/packages/shared_preferences) - For storing user preferences.
- conditional_builder_null_safety - For conditional rendering with null safety support.
- bloc - For implementing the BLoC pattern.
- flutter_bloc - For integrating BLoC with Flutter.

_Add other dependencies as needed._

## Installation

To run the app locally on your development machine, follow these steps:

1. Ensure you have Flutter installed on your system.
2. Clone this repository to your local machine using `git clone`.
3. Open the project in your preferred code editor.
4. Run `flutter pub get` to fetch the dependencies.
5. Connect a physical device or use an emulator.
6. Run `flutter run` to start the app.

## Contributing

Feel free to contribute to the app by adding new features, fixing bugs, or enhancing the existing code. Any help is appreciated!

## Contact

If you have any questions or need further assistance, you can contact the project maintainer:

- HeshamQutb - (https://www.linkedin.com/in/hesham-qutb-bba58a241/)

Please note that this app is currently a work in progress, and more features will be added in the future. Happy coding!
