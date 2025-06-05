This is a simple Flutter app I built for the Evergreen Technologies pre-interview task. It’s a note-taking app where users can create, read, update, and delete notes. The app uses Firebase for backend services and is built with clean architecture and BLoC for state management.

Features
Anonymous sign-in when the user opens the app

Add new notes

Edit or delete your own notes

Realtime updates: when one user makes a change, others see it immediately

Users can’t edit or delete notes created by others – if they try, a warning is shown

Swipe left to delete a note

Tracks how many users are currently active (bonus feature)

How to Run
Prerequisites
Flutter SDK 3.6.1
(You can install it manually or use FVM)

Steps
Clone the repo:

bash
Copy
Edit
git clone https://github.com/yourusername/flutter-firebase-crud.git
cd flutter-firebase-crud
If using FVM:

bash
Copy
Edit
fvm install 3.6.1
fvm use 3.6.1
Check your Flutter setup:

bash
Copy
Edit
fvm flutter doctor
Get the packages:

bash
Copy
Edit
fvm flutter pub get
Run the app:

bash
Copy
Edit
fvm flutter run
Or just download and test the APK
I uploaded the APK to Firebase App Distribution and added Evergreen’s email as a tester. You should have received an email invite with the download link. No build is needed.

Project Structure
The app uses clean architecture and is split into:

data – Firebase logic

domain – entities and business rules

presentation – UI and BLoC

Bonus: Realtime Active Users
I added a bonus feature that tracks how many users are currently using the app. This is done with Firebase Realtime Database. When a user opens the app, a session is created and removed automatically when they leave. A stream listens to all active sessions and updates the count in real time.

Assumptions
Users don’t sign in manually – they are signed in anonymously on app start

Every note includes the user ID so we can check who created it

Only note creators can edit or delete their notes

