[![CI](https://github.com/MarioSQuilantan/number_trivia_app/actions/workflows/main.yml/badge.svg)](https://github.com/MarioSQuilantan/number_trivia_app/actions/workflows/main.yml)
# Number Trivia App

A Number Trivia project created in flutter using BLoC. Number Trivia supports Android and iOS devices:

* For Android: [playStore](https://play.google.com/store/)
* For iOS: [AppStore](https://apps.apple.com/mx/app/apple-store/)


## Getting Started

The number Trivia contains the implementation of BLoC V8 as a state management, and implemented the Clean Code Architecture and Test Driven Development.

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/MarioSQuilantan/number_trivia_app.git 
```

**Step 2:**

This project works with flutter version `3.7.5` so make sure to have at least this version to avoid conflicts.

**Step 3:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 4:**

Run the project in an Android or iOS device.

## Number Trivia Features:

* work in progress

### Up-Coming Features:

* fetch a random number trivia
* fetch a number trivia by number
* store a number trivia data in local storage

### Libraries & Tools Used

* [Dio](https://pub.dev/packages/dio) (A HTTP client for Dart/Flutter)
* [Flutter BLoC](https://pub.dev/packages/flutter_bloc) (Widgets that make it easy to integrate blocs and cubits into Flutter)
* [BLoC](https://pub.dev/packages/bloc) (A dart package that helps implement the BLoC pattern)
* [Dartz](https://pub.dev/packages/dartz) (Functional programming in Dart)
* [Equatable](https://pub.dev/packages/equatable) (Being able to compare objects in Dart often involves having to override the == operator as well as hashCode)
* [Get it](https://pub.dev/packages/get_it) (A Service Locator for Dart and Flutter)
* [BLoC test](https://pub.dev/packages/bloc_test) (A package that makes testing blocs and cubits easy)
* [Mocktail](https://pub.dev/packages/mocktail) (Mock package for Dart)
* [Go router](https://pub.dev/packages/go_router) (A declarative routing package for Flutter)
* [Hive](https://pub.dev/packages/mocktail) (A key-value local database)

### Folder Structure

Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- core/
|- features/
|- ui/
|- main.dart
|- routes.dart
|- injector.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- core - This directory responsible for containing everything related to utilities/common functions of the application.

2- features - Contains the implementation business logic. will be divided into 3 layers - presentation, domain and data.

3- ui — Contains all the ui of the project, contains sub directory for each screen and the common widgets for the applications. For example, Button, TextField etc

7- routes — This folder contains all the routes for the application.

8- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

### Core

This directory contains all the application level utilities/common functions of the application. A separate folder is created for each type as shown in example below:

```
core/
  |- layout/
    |- screen.layout.dart
  |- error/
    |- failure.dart
    |- exception.dart
  |- utils/
    |- mask/
      |- mask.dart
  |- extensions/
    |- strings.extension.dart
  |- languages/
    |- en-EU.dart
    |- es-ES.dart
  |- values/
    |- constants.dart
    |- strings.dart
    |- enums.dart
    |- keys.dart
  |- theme/
    |- text.theme.dart
    |- colors.theme.dart
```

### Features

Contains the implementation business logic. will be divided into 3 layers - presentation, domain and data. The folder structure is as follows: 

```
features/
|- user
   |- data
   |- domain
   |- presentation
```

### Presentation

This folder contains the State Manager in this case BLoC.

```
|- bloc/
  |- user_bloc.dart
  |- user_event.dart
  |- user_state.dart
```

### Domain

This folder is the inner layer which shouldn't be susceptible to the whims of changing data sources. It will contain only the core business logic (use cases) and business objects (entities).

```
|- use_cases
  |- get_user_by_id.use_case.dart
|- entities
  |- user.entity.dart
|- repositories
  |- user.repository.dart
```

### Data

The data layer consists of a Repository implementation (the contract comes from the domain layer) and data sources.

```
|- data_sources/
  |- api.data_source.dart
|- models/
  |- user.model.dart
|- repositories/
  |- user.repository_imp.dart
```
### UI

This directory contains all the ui of your application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. All the screen specific widgets will be placed in `widgets` directory as shown in the example below:

```
ui/
|- login/
  |- layouts/
    |- desktop/
      |- desktop.layout.dart
    |- phone/
      |- phone.layout.dart
    |- tablet/
      |- tablet.layout.dart
  |- login.page.dart
  |- widgets
```
### Widgets

Contains the common widgets that are shared across multiple screens. For example, Button, TextField etc.

```
widgets/
|- app_icon_widget.widget.dart
|- empty_app_bar.widget.dart
|- progress_indicator.widget.dart
```

### Routes

This file contains all the routes and navigation methods for the application.

```dart
class Routes {
  Routes._();
  static GoRouter get call => GoRouter(
        routes: [
          GoRoute(
            path: "/",
            builder: (context, state) => const HomePage(),
          ),
        ],
      );

  static void navigateTo(BuildContext context, String route) => context.go(route);
}
```
### Injector

This file contains the dependency injection cases.

```dart
final locator = GetIt.instance;

void init() {
  // blocs
  locator.registerFactory(() => <T>Bloc(getType: locator<Get<T>sUseCase>()));

  //use cases
  locator.registerLazySingleton(() => Get<T>sUseCase(locator<<T>Repository>()));

  // repositories
  locator.registerLazySingleton<<T>Repository>(() => <T>RepositoryImpl(locator<<T>RemoteDataSource>()));

  // data sources
  locator.registerLazySingleton<<T>RemoteDataSource>(() => <T>RemoteDataSourceImp(locator<DioClient>()));

  // external
  locator.registerLazySingleton(() => Dio());
  locator.registerLazySingleton(() => DioClient(locator<Dio>()));
}
```

### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<<T>Bloc>(create: (_) => di.locator<<T>Bloc>()),
      ],
      child: MaterialApp.router(
          title: 'MyApp',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerConfig: Routes.call,
      ),
    );
  }
}
```

## Wiki

Checkout [wiki](https://github.com/MarioSQuilantan/number_trivia_app/wiki) for more info
