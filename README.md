

# QAgency

IMDb like app for browsing information on popular movies


## Getting Started

### Prerequisites
To run this project we assume you already have [Flutter](https://flutter.dev/) installed on your machine.  
If not, please visit [Install | Flutter](https://docs.flutter.dev/get-started/install).

Minimum Flutter SDK version => [3.24.2](https://docs.flutter.dev/release/archive)  
Minimum Dart SDK version => [3.5.2](https://dart.dev/get-dart/archive)

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
   ![Edit Configuration Option](https://lh3.googleusercontent.com/pw/AP1GczPIXvOAEFDAp74XU77tD9NseJH1kTcRtYVVjuHhLCa8jbiAul25qaHdryHx5Dyp5ELejWdhx28wmC6BwxfWRZAdwAsH5Z65T1PQ99CRrLjdxbxPVEA61iatQLd5lYNpLx7s5qkQAp6Sf-pSLOVYzXthJA=w185-h112-s-no-gm?authuser=0)
2. In the new window click on the **"+"** icon in the top left and select **Flutter** from the dropdown.  
   ![New Configuration Menu](https://lh3.googleusercontent.com/pw/AP1GczNJvDtkQo-iIjYk5d4Zi3wI0aIh_RpXlAGrnCSvZyoZEQIpU42dVjHAnfSf-1QC_9LWN7vMpIwJSnNdXYY8QWbEzkBqCfQEn59oHcnkFGzsPmyujd-n53ln8V3JDio6ap8K7b43knyYiHl0eyjQa1azmw=w265-h332-s-no-gm?authuser=0)

3. A new target will appear in your left pane. Populate the fields as follows:  
   ![Target Configuration](https://lh3.googleusercontent.com/pw/AP1GczPcfINB_FV0EvqCtiYm03OHhDlZdzK44O7bjQtvPeoG9IB49RZ9UVETvspvd62hLwhE0Oy6gY-ZMDTx55S8vav-crkrC4k6iJg_UaApkLgzqQXBHIwFm4EJjg4G4R1cdUl-J7ATE-Q336rsu_yO5pPJ0A=w683-h410-s-no-gm?authuser=0)

Replace <PATH_TO_YOUR_PROJECT> with the actual path to the project on your machine.  
Replace "production" with "development" for development environment.

### Visual Studio Code Target Configuration

1. From the top ribbon bar click on **Run -> Add Configuration...**  
   ![Add Configuration](https://lh3.googleusercontent.com/pw/AP1GczP5zrmX0nRjAxMT6P1M6Dw-dqg0Tqb0rTanSeeK1sVCH_Vh6nqgDgrGUGwSlszAR6AaGK30224pNbsVS9O-ibHraMyvkYwEGTsi2BZzdeDRE7d-epJ9Qi4Ij7ghS3tPNfOT5_eRCnd0WSOJrWaUmVkf4w=w368-h506-s-no-gm?authuser=0)

2. Copy and paste **the** following JSON into the newly created launch.json:
3.
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