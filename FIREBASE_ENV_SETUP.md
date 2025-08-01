# Firebase Environment Variables Setup

This project uses environment variables to securely store Firebase configuration keys and sensitive information.

## Setup Instructions

1. **Copy the example file:**

   ```bash
   cp .env.example .env
   ```

2. **Update the `.env` file** with your actual Firebase project values from your Firebase Console.

3. **The `.env` file is already added to `.gitignore`** to prevent accidentally committing sensitive information.

## Environment Variables

### Required Variables:

- `FIREBASE_WEB_API_KEY` - Firebase Web API Key
- `FIREBASE_WEB_APP_ID` - Firebase Web App ID
- `FIREBASE_MESSAGING_SENDER_ID` - Firebase Messaging Sender ID (same for all platforms)
- `FIREBASE_PROJECT_ID` - Firebase Project ID (same for all platforms)
- `FIREBASE_AUTH_DOMAIN` - Firebase Auth Domain
- `FIREBASE_STORAGE_BUCKET` - Firebase Storage Bucket (same for all platforms)
- `FIREBASE_WEB_MEASUREMENT_ID` - Firebase Web Measurement ID

- `FIREBASE_ANDROID_API_KEY` - Firebase Android API Key
- `FIREBASE_ANDROID_APP_ID` - Firebase Android App ID

- `FIREBASE_IOS_API_KEY` - Firebase iOS API Key
- `FIREBASE_IOS_APP_ID` - Firebase iOS App ID
- `FIREBASE_IOS_BUNDLE_ID` - iOS Bundle ID

- `FIREBASE_WINDOWS_API_KEY` - Firebase Windows API Key
- `FIREBASE_WINDOWS_APP_ID` - Firebase Windows App ID
- `FIREBASE_WINDOWS_MEASUREMENT_ID` - Firebase Windows Measurement ID

## How it Works

The app uses `String.fromEnvironment()` to read these values at compile time. When you run the app, Flutter will read these environment variables and use them to configure Firebase.

## Running the App

To run the app with environment variables:

```bash
# For development
flutter run --dart-define-from-file=.env

# For release build
flutter build apk --dart-define-from-file=.env
```

## Security Notes

- Never commit the `.env` file to version control
- Use different environment files for different environments (dev, staging, prod)
- The `.env.example` file shows the structure without actual values
