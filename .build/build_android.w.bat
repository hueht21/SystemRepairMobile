
@echo off

call fvm flutter build apk --release
call firebase appdistribution:distribute "./build/app/outputs/flutter-apk/app-release.apk" ^
    --app 1:290961475555:android:47cc6117678e8fe0ce82d6 ^
    --release-notes %date:~-4,4%-%date:~-7,2%-%date:~-10,2% --testers "" --groups "testapp"

echo -------------------
echo Build Android prod done