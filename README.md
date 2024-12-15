# Nearby Swift

**Nearby** is a simple iOS application built to study Swift and iOS development. 
The app uses a local API to fetch places near the user where they can redeem coupons, such as restaurants, cinemas, and more. 
It's designed to provide a seamless experience for users looking to discover nearby deals and offers.

## Features

- Fetches nearby places with active coupons.
- Displays detailed information about each place (e.g., name, type, distance).
- Supports categories like restaurants, cinemas, and other venues.
- User-friendly interface with map-based or list-based views of nearby places.
- Real-time updates of locations based on user position.

## Technologies Used

- **Swift**: Primary language used for iOS app development.
- **UIKit**: To build the user interface and handle user interactions.
- **Core Location**: To track and update the user's current location.
- **Networking**: For API integration to fetch nearby places.
  
## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/Welinton-Hoff/nearby-swift.git
    ```
2. Navigate to the project directory:
    ```bash
    cd nearby-swift
    ```
3. Open the project in Xcode:
    ```bash
    open NearbySwift.xcodeproj
    ```
4. Build and run the project on your preferred simulator or physical device.

## How It Works

- The app fetches the user's current location using the Core Location framework.
- It sends the user's coordinates to the local API to retrieve nearby places.
- Places are displayed on the user interface, with details about the available coupon and distance from the user.

