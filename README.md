📸 Flickr Browser

Flickr Browser is an iOS application designed to showcase images from the Flickr public feed in an interactive and visually engaging way. It includes a dynamic image carousel, a details screen, and a custom audio player with smooth animations.

🌟 Project Overview

This application was built using SwiftUI and follows the MVVM architecture. To enhance separation of concerns and maintainability, a Dependency Container and CoreInteractor layer were introduced between ViewModels and Managers. The app fetches data from Flickr's Public Feed API and presents images in a swipeable gallery format.

🎨 Features

✅ Image Feed: Browse images fetched dynamically from Flickr, categorized into different topics.
✅ Interactive Swipeable Galleries: Scroll through multiple swimlanes of images with smooth animations.
✅ Detail View: View high-resolution images along with metadata, with a dimming effect on scroll.
✅ Audio Player: A mock music player with interactive animations and draggable UI elements.
✅ Snapshot Testing: Uses PointFree’s SnapshotTesting library to validate UI consistency.
✅ Unit Tests: Basic unit tests included to ensure code reliability.

🛠️ Architecture

The project follows a structured MVVM pattern with an additional CoreInteractor layer for business logic.

View (SwiftUI Views): Handles UI presentation.
ViewModel: Manages state and interacts with the CoreInteractor.
CoreInteractor: Acts as a bridge between ViewModels and Managers, processing logic.
Managers (FlickrManager, PlayerManager): Handle API requests and audio functionalities.
📦 Dependencies

Swift Snapshot Testing (v1.12.0) → For UI consistency validation
SwiftLint (v0.57.0) → Enforces coding standards
📚 Learning Inspiration

This project was built as part of a coding challenge to demonstrate clean architecture, SwiftUI best practices, and smooth animations.

📸 Screenshots

🏠 Main View → A feed with multiple categories of images.
🖼️ Detail View → Image with title, metadata, and a dimming scroll effect.
🎵 Audio Player → A mini-player that expands into a full-screen view.

🚀 Getting Started

Clone the repository.
Open the project in Xcode 16.0 or later.
Run the app on an iOS Simulator or device.
