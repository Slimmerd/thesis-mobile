# thesis_mobile

Flutter project E-grocery delivery project.

## Testing machine information
This project successfully worked with such configuration:
- Flutter 3.3.10
- Android SDK 32.0.0
- Xcode 14.3
- Android Studio 2022.2.1

## Getting Started
To run the application it requires Flutter framework, Android SDK to be installed. 
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Install dependencies
You have to run command ```flutter pub get```

## Run application
To run application on Android or IOS simulator you have to:
- Open simulator
- Run command ```flutter run```

## Builds
### IOS
To build IOS ipa file you need Xcode to be installed.

Build command:
```flutter build ipa --release```


You can find build in folder:
```build/ios/ipa/*.ipa```

### Android
To build Android apk file you need Android SDK to be installed.

Build command:
```flutter build apk --release  ```

You can find build in folder:
```build/app/outputs/apk/release```


## Troubleshooting
In some rare occasions in IOS you might have issues related to POD package manager. If you have it installed, then you can try command in ```pod install``` in folder IOS   