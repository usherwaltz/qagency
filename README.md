
# QAgency

IMDb like app for browsing information on popular movies


## Getting Started

### Prerequisites
To run this project we assume you already have [Flutter](https://flutter.dev/) installed on your machine.
If not, please visit [Install | Flutter](https://docs.flutter.dev/get-started/install).

Minimum Flutter SDK => [3.24.2](https://docs.flutter.dev/release/archive)
Minimum Dart SDK => [3.5.2](https://dart.dev/get-dart/archive)

### Setup

1. Clone repository `git clone https://github.com/usherwaltz/qagency.git`
2. Navigate to project directory and create a `.env` file in root with the following contents:
> API_KEY=<YOUR_API_KEY>

Replace <YOUR_API_KEY> with your actual API key from [developer.themoviedb.org](https://developer.themoviedb.org/)

3. Run the following commands:
* Fetch dependencies => `flutter pub get`
* Generate [l10n](https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization) localizations => `flutter gen-l10n`
* Generate [Freezed](https://pub.dev/packages/freezed) & [Drift](https://pub.dev/packages/drift) code => `dart run build_runner build`

## Configuring targets

This project was setup to support two environments - **Production** & **Development**.

Currently the environment variables are the **same for both environments**, nonetheless, we must configure dart entry points in order to run the project from an editor.

Environment variables can be found in: **<PROJECT_ROOT>/lib/config/flavor_config.dart** in their respective factory constructors: ***FlavorConfig.development()*** & ***FlavorConfig.production()***

### Prerequisites
Depending on your preferred code editor, you'll need the flutter plugin to run this project from an editor

* [Android Studio Flutter Plugin](https://plugins.jetbrains.com/plugin/9212-flutter)

### Android Studio Target Configuration
1. From the top ribbon open the dart entry point dropdown menu and select **Edit Configurations**:
   ![Edit Configuration Option](https://drive.google.com/file/d/1hv_3Ulpa1g9ddV2ZVHMWnTuwUpEDIdfh/view?usp=drive_link)
2. In the new windows click on the **"+"** icon in the top left and select **Flutter** from the dropdown.
   ![New Configuration Menu](https://drive.google.com/file/d/1Uwn5z3At_350oBvYQvf9EZ-mcgnOFW4e/view?usp=sharing)
3. A new target will appear in your left pane. Populate the fields as follows:
   ![Target Configuration](https://drive.google.com/file/d/1woXSl11UTpLQ3LYdq-vHMwg5Q5NZTCoZ/view?usp=sharing)

Replace <PATH_TO_YOUR_PROJECT> with the actual path to the project on your machine.
Replace "production" with "development" for development environment.

### Visual Studio Code Target Configuration

1. From the top ribbon bar click on **Run -> Add Configuration...**
   ![Add Configuration](https://drive.google.com/file/d/1P2rdpk4NIn9L4XI9ZJvZrOX2T6jh2QoH/view?usp=sharing)
2. Copy and paste following json into the newly created launch.json:

```json
{  
	"version": "0.2.0",  
	"configurations": [  
		{  
			"name": "Production",  
			"request": "launch",  
			"type": "dart",  
			"program": "lib/main_production.dart",  
			"args": [  
				"--flavor",  
				"production"  
			]  
		},  
		{  
			"name": "Development",  
			"request": "launch",  
			"type": "dart",  
			"program": "lib/main_development.dart",  
			"args": [  
				"--flavor",  
				"development"  
			]  
		}  
	]  
}
```

## Project Dependencies
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) - Generating app launcher icons
- [flutter_svg](https://pub.dev/packages/flutter_svg) - Displaying `.svg` images
- [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) - Ensuring UI consistency across various screen sized and scaling.
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - State management
- [go_router](https://pub.dev/packages/go_router) - Routing and navigation
- [freezed_annotation](https://pub.dev/packages/freezed) - Generating boilerplate code for models
- [dio](https://pub.dev/packages/dio) - Executing http requests
- [logger](https://pub.dev/packages/logger) - Pretty console logs for easier debugging
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) - `.env` file support
- [gap](https://pub.dev/packages/gap) - Easy spacing in flexible widgets
- [shimmer](https://pub.dev/packages/shimmer) - Pretty placeholder loading
- [drift](https://pub.dev/packages/drift) - Data caching
- [connectivity_plus](https://pub.dev/packages/connectivity_plus) - Detecting device connection
- [shared_preferences](https://pub.dev/packages/shared_preferences) - Quick storage tool for small user preferences
- [rxdart](https://pub.dev/packages/rxdart) - Replacing `StreamController.broadcast()` with `BehaviorSubject()` 