# GeoLocator - iOS App

GeoLocator is a small iOS app written in Swift that makes use of the CoreLocation framework to provide geolocation features. With GeoLocator, you can seamlessly ask for GPS permission, get your current location, obtain directions to a specific destination, and save locations persistently in a CoreData database. It's a handy tool for all your location-based needs.



## Features
• **GPS Permission**: GeoLocator requests permission to access your device's GPS sensor, ensuring you have control over your location data.

• **Geolocation**: The app precisely determines your current position based on the GPS sensor, allowing you to explore and interact with your surroundings.

• **Directions**: Easily find directions from your current location to a specific destination, making navigation a breeze.

• **Location Storage**: GeoLocator lets you save a pin (location) to a CoreData database, so you can revisit your favorite places or keep a log of important locations. <br>

<img align="left" width="200" height="400" src="images/Screenshot2.png">
<img align="center" width="200" height="400" src="images/Screenshot3.png">


## Installation

1. Clone the repository to your local machine.

2. Clone the repository code
```
git clone https://github.com/your-username/geolocator-app.git
```
3. Open the project in Xcode.

4. Build and run the app on your iOS device or simulator.

## Usage

**GPS Permission**: When you first launch GeoLocator, the app will request permission to access your device's GPS sensor. Be sure to grant it access.

**Getting Your Location**: Press the "Get My Location" button to retrieve your current location.

**Finding Directions**: Enter a destination address or coordinates and tap "Get Directions" to find the route from your current location.

**Saving Locations**: To save a location, click the "Save Location" button, and the location will be stored in the CoreData database for future reference.

## Technologies Used

`Swift`
`CoreLocation Framework`
`CoreData`
