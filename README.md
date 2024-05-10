# Movies App

This is a project being developed to practice UIKit and the VIP (Clean Swift) architecture.

🚧 This project is still in development, so only a few features of it are currently implemented. The README will also be updated as new technologies and features that are being introduced into this project. 🚧

## Table of Content:

- [About The App](#about-the-app)
- [Screenshots](#screenshots)
- [Demo](#demo)
- [Technologies](#technologies)
- [Folder Structure](#folder-structure)
- [Getting Started](#getting-started)

## About The App

Movies App is an app that shows current movies and their details *(more features soon)*

## Screenshots

<div style="flex-direction: row;">
  <img src="https://i.imgur.com/4imRsDg.png" alt="Home screen containing the movies list" height="450" />
  <img src="https://i.imgur.com/kc9SXu8.png" alt="Scrolled home screen containing the movies list" height="450" />
  <br/>
  <img src="https://i.imgur.com/Q2VQiGS.png" alt="Details screen for the movie 'The Garfield Movie'" height="450" />
  <img src="https://i.imgur.com/qBiu2zG.png" alt="Details screen for the movie 'Oppenheimer'" height="450" />
</div>

## Demo

https://github.com/willperes/MoviesApp/assets/64440935/b6ad14bc-1096-4b8e-876e-108e51e654c2

## Technologies

This project was developed using UIKit using the VIP (Clean Swift) architecture, applying Clean Code and SOLID concepts.

## Folder Structure

```
├── Domain                # Domain layer containing folders for models (entities) and scenes
│   └── (DomainName)        
│       ├── Models        # Entities specific to that domain
│       └── Scenes        # Scenes for that domain containing View Controler, Interactor, Presenter, Worker and Router
│           ├── (DomainName)ViewController
│           ├── (DomainName)Interactor
│           ├── (DomainName)Presenter
│           ├── (DomainName)Worker
│           ├── (DomainName)Router
│           └── (DomainName)Models
├── Extensions            # Extensions made to Swift/UIKit elements
├── Utils                 # Utility classes and functions to be used throughout the app
└── Views                 # Views that can be reused throughout the app
```

## Getting Started

To run this app on your local machine, follow these steps:

1. Clone this repository to your local machine using Git:

```bash
git clone https://github.com/willperes/MoviesApp.git
```

2. Open the project in Xcode.
3. Build and run the app on the simulator or a physical device.

If everything is set up _correctly_, you should see the app running in your _iOS Simulator_.
