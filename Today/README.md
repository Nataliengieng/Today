# Scrumdinger App

This app is developed based on the [Apple Developer Tutorials] (https://developer.apple.com/tutorials/app-dev-training).

## TroubleShooting

### 1. Handling errors
When simulating data corruption following "Section 4: Simulate data corruption", error "xcrun: error: unable to find utility "simctl", not a developer tool or in PATH" occurs after running the command `xcrun simctl get_app_container booted com.example.apple-samplecode.Scrumdinger data`, and I were unable to accept the XCode license.

```
nat@Natalies-MacBook-Pro ~ % xcrun simctl get_app_container booted com.example.apple-samplecode.Scrumdinger data 
xcrun: error: unable to find utility "simctl", not a developer tool or in PATH

nat@Natalies-MacBook-Pro ~ % sudo xcodebuild -license
Password:
xcode-select: error: tool 'xcodebuild' requires Xcode, but active developer directory '/Library/Developer/CommandLineTools' is a command line tools instance
```

After troubleshooting, this was due to the location of the developer directory was not pointed to the correct directory. This problem was solved by switching the directory and accept the XCode license by running below commands: 
```
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license
```