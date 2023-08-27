# Crypto App

## Requirements

- Minimum iOS version: 16.2
- Xcode 14.X

## Setting up the project

- Wait for the packages to be loaded.
- Build and run.

## Architecture

MVVM architecture is used in the project along with SwiftUI and Combine. For shared/reusable business logic use cases were used.

## Used libraries

- [Resolver](https://github.com/hmlongco/Resolver)
(Probably I lose a bonus point for using this library. But the usage may be reasonable as no need to pass dependencies in the initializers. It's also helpful in testing when mocking the API.)
