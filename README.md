# Navigator Coordinator App

This is a project intended to demonstrate decoupling navigation from UI using three20 navigator.  Rather than completely abstract the TTNavigator in all its awesomeness, its exposed and available for abuse and corruption.  

The routing and configuration of a TTSplitViewController and associated navigators is encapsulated in the LVNavigationCoordinator and LVNavigationCoordinatorFactory.  The latter is responsible for creating and configuring the LVNavigationCoordinator.

The goal is simply to keep the routing and navigation concerns from being littered throughout the application code.  