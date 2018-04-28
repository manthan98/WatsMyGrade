# WatsMyGrade

A complete course, grade, and tasks management application.

## Structure ##
This version makes heavy use of Core Data for all CRUD operations avoiding any network-related crashes found in the old version.
In the future, the network component will be re-introduced to interface with the API, but it will be limited to access upon entry and
exit of application. I'm still trying to figure out a good way to manage network and Core Data in an efficient manner (this is done on
networking branch).

## Run ##
1. Download XCode and clone the repo.
2. Open terminal, navigate to repo, and run pod install.
3. Open .xcworkspace and press play!

## Screenshots ##
![simulator screen shot - iphone x - 2018-03-10 at 19 55 05](https://user-images.githubusercontent.com/19896167/37248323-43c2b02a-249d-11e8-8d52-9f349f2f30fd.png) | ![simulator screen shot - iphone x - 2018-03-10 at 19 55 09](https://user-images.githubusercontent.com/19896167/37248324-44e4d334-249d-11e8-825a-7a2379b30c12.png)
:-------------------------:|:-------------------------:
![simulator screen shot - iphone x - 2018-03-10 at 19 55 17](https://user-images.githubusercontent.com/19896167/37248325-46f23130-249d-11e8-91b5-048e4f22ee75.png) | ![watsmygrade](https://user-images.githubusercontent.com/19896167/37248454-b93794f8-24a0-11e8-8586-d79c8c1e2da5.gif)
