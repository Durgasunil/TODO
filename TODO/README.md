# TODO
 
This app implements a TODO App to organize the tasks as per the specifications provided. 

## Functional
1. The First screen is a list which hosts all the Tasks with inprogress in Black and completed tasks in Red.
2. The screen also has a Add Button(+) icon to add a new task
3. Tapping on any task will take the user to the edit screen when user can update the description or Complete the task.
4. User can also delete the task with swipe action right ther in the list.
5. The app also supports Light/Dark Mode

## General Architecture 
1. App is written in Swift, with UI handcoded rather than leveraging storyboards.
2. Realm is the persistent store where tasks are persisted between app launches.
3. MVVM architecture is leveraged. There are some container views without viewModel but they can easily extended to include a ViewModel if needed.
   The viewModel hosts all the business logic + any interactions with the data layer. The Viewmodel can be tested independently. 
   ViewModels also takes any object which implements RealmProvider interface as a dependency. This makes the class more testable where we can inject a testProvider with test data if needed.
   
4. App also depends on a package TODOKit (https://github.com/Durgasunil/TODOKit) which seperates the data layer and hosts (Data Models + utility classes to access/save data in realm.
5. List for Tasks is implemented as an UICollectionView of type list which leverages Compositional Layouts , Diffable Datasource and snapshots.

## Tests 
1. Tests are not exhaustive but provdes a general approach towards testing


## Notes 
1. All the Viewcontrollers inherit from BaseViewController which provides a basic template for programmable UI, code organization and any common functionality which is shared across ViewControllers.
2. Errors are defined as an example and are not exhaustive.
3. String resource files are used where there is user facing text or error messages.
   

