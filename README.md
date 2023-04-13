# myapp

A new Flutter project.

# Getting Started

## Below is the command to create a new Flutter project with the name myapp and the language as Dart (default), using the flutter create command, as shown below:

# Open the terminal and type the following command

```bash
flutter create myapp
```

## To run the app, use the flutter run command, as shown below:

```bash
flutter run
```

* To add a dependency to pubspec.yaml, we can use the following command


```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.3.8
```

* [get: ^4.3.8] GetX is a powerful library that allows you to create reactive applications. It is a wrapper around the Observer pattern, which allows you to listen to changes in the data and update the UI accordingly. It is a great way to speed up your development process.

* [get_cli] I will Use get_cli is a command line tool that helps you create GetX projects, generate pages, controllers, bindings, and more. It is a great way to speed up your development process.

* To Activate the get_cli, use the following command

```bash
flutter pub global activate get_cli
```

* To Export the path, use the following command

```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

* To initialize the get_cli, use the following command

```bash
get init
```

* GetX folder structure

```bash
lib
├── app
│   ├── data
│   │
│   ├── modules
│   │   ├── home
│   │   │   ├── bindings
│   │   │   │   └── home_binding.dart
│   │   │   ├── controllers
│   │   │   │   └── home_controller.dart
│   │   │   ├── views
│   │   │   │   └── home_view.dart
│   │   │   └── home_module.dart
│   │   │
│   ├── routes
│   │   └── app_pages.dart
│   │   └── app_routes.dart
│   │
...
```
