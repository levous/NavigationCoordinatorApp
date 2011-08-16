# Navigator Coordinator App

This is a project intended to demonstrate decoupling navigation from UI using three20 navigator.  Rather than completely abstract the TTNavigator (though that was tempting) in all its awesomeness, it's exposed and available for abuse and corruption (that is the simplest possible solution)  

The routing and configuration of a TTSplitViewController and associated navigators is encapsulated in the LVNavigationCoordinator and LVNavigationCoordinatorFactory.  The latter is responsible for creating and configuring the LVNavigationCoordinator.

The goal is simply to keep the routing and navigation concerns from being littered throughout the application code.  

Three20 is integrated as project references.  The Three20 github project should be parallel to the root of this project directory