<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package. 
-->

Core layer usable in every Flutter project.

## Features

- Results: It usable for return operation result, message and/or data.
- DisplayMessages: Use them for display mesage with SnackBar or AlertDialog.

## Getting started

For import that library, open pubspec.yaml document on your project root and add theese commands below to the `dependencies`

```dart
guki_core:
    git:
        url: https://github.com/E-MRE/guki_core
        ref: #choose a tag you want to use
```

## Usage

Include short and useful examples for package users. Add longer examples
to `/example` folder. 

v0.0.2:

```dart
DisplaySnackBar(context).errorMessage('Error message here');
 DisplayAlertDialog(context).successAlert('Message is success');
```

v0.0.1:

```dart
DataResult<int> addOneIfNotNull(int? value) {
    return value != null
        ? SuccessDataResult(data: value + 1)
        : ErrorDataResult(message: 'value is null');
  }
```
