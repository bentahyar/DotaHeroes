# Build Status

### Master

[![bitrise](https://app.bitrise.io/app/b535c584609c83d4/status.svg?token=eJfd-xoD-20fxCuIkRlQyQ&branch=master)](https://codecov.io/gh/bentahyar/DotaHeroes) [![codecov](https://codecov.io/gh/bentahyar/DotaHeroes/branch/master/graph/badge.svg)](https://codecov.io/gh/bentahyar/DotaHeroes)

# Introduction

Welcome to Dota Heroes, a mini assignment for Tiket.com.

# Folder Structure

The structure of each folder is explained below:

- `MockData/` – contains mock data of heroes to be used in test. 
- `Adapter/` – contains adapter of collectionview.
- `Manager/` – contains managers that help create database, service, and constant.
- `Service/` – contains services call for API request.
- `Utils/` – contains extension of existing iOS Framework (UIImage). 
- `View/` – contains main UI (UIViewController, XIB) and related protocols for the related view.
- `Interactor/` – contains all business logic, API and local data managements.
- `Presenter/` – contains presenter of each related view that manages events that translates into routing, inputs or outputs.
- `Entity/` – contains entities that exist in the app.
- `Router/` – contains all router that manage navigations and VIPER creation.

# Environment

This code is built on `Xcode 11.3` with minimum iOS Requirement is `10.0`, and written in `Swift 5`

# Dependencies

This project is using `Cocoapods` version `1.8.4` for dependency management. It's dependencies are:

- `Alamofire` for networking.
- `SwiftLint` for linting

To install these dependencies, go to the project root folder and run `pod install` and open `DotaHeroes.xcworkspace` if you want to open the project.

# CI

This project also using Bitrise.io to build, test, check and linting. You can see the build status above.

Code coverage is also shown above.

# Features

This project includes some features such as:

- [x] Use swift 5
- [x] Use clean architecture (VIPER, Protocol Oriented Programming)
- [x] Use codable for model and JSON Parsing
- [x] Use autolayout for view (XIB)
- [x] Use local cache (Core Data)
- [x] Unit test

# Author

Created by [Benedict Lukas](https://www.linkedin.com/in/benedict-lukas-84238172/). Contact me at bentahyar@gmail.com
