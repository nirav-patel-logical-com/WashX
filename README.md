# Wash
Welcome to Wash! This app is basically 'Uber for laundry'. The premise of the service is that
customers can create a 'wardrobe' with their items of clothing in it, and schedule someone to pick
up their laundry, wash it, and return it. Full services include:
- Laundry
- Dry cleaning
- Car wash
- Couch wash

This repository represents the code for the client application - the one used by customers.

## Getting started
1. Set up a directory on your local machine called "WashX".
2. Forks are disabled, as this repository is private. As such, you will need to clone the repo to
your local machinedirectly.
2. In your "WashX" directory, open a git terminal and type `git clone git@github.com:WashX/Wash.git`.
This will clone Wash to your local machine under the directory "Wash". Your file structure should
now be "WashX/Wash".
3. Open your IDE of choice (Android Studio, VSCode, IntelliJ) and open the application.
4. Run the app. If you run into the error `Could not find an option named "track-widget-creation".`,
do a `flutter clean`. If that still doesn't work, run the app in the terminal using the command
`flutter run --no-track-widget-creation`. If the app hangs on the `installing apk` step of the
build process, find the app in your launcher and tap on it.
5. Walk through the app and familiarize yourself with it.

## Development Guidelines
We deal with development in a very specific way, as we want to keep the merging process clean and
organized. Some things to note:
- Every piece of development you do must be done in its own branch. This is done for a few reasons:
    - so that we can track development across individual developers
    - so that we can view code differences in pull requests

## Development Steps
1. Pull from branch `master`
2. Merge `master` into a new branch. The naming should correspond to the component you are
working on.
3. Make your changes, test, etc.
4. Commit your changes.
5. Push your changes by doing `git push origin your_branch_name`.
6. Open a new pull request by clicking the 'New pull request' button at the top of the repository.
7. Select your new branch in the 'compare' dropdown.
8. Write a detailed changelog of your changes by writing "Changelog" and using bullet points to list
your changes. To use a bullet point, simply type `-` at the beginning of a new line.
9. Merge your pull request
10. Pull from branch `master` again
11. If you need to continue working in an existing branch, checkout that branch and merge master.
