# TVExamples
Some examples from my talk on CocoaHeadsSP september 2015

## CollectionViewExample
This project demonstrate how you can implement focus on any view.
You can play with some settings inside `ImageCollectionViewCell` to see how your focus is displayed on screen.
Also, you can comment/uncomment the method `override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator)` in the `ViewController` class and see what happens

## ButtonTest
This project demonstrate how to create a custom component (in this case a stepper control) using gestures recognizers.

You can select the stepper element and swipe left and right to change it's value.
**I plan to improve and make this component better over time. It will change its repo soon**

##SearchExample
This project shows how to implement a search controller with a custom result page

##LuckMachine
This is a really simple app, that we used to raffle some goodies in the end of the meeting

##UIKitCatalogtvOSCreatingandCustomizingUIKitControls
This is apple example project, ready to run on Xcode 7.1 beta 2.
You can play with TVServices (TV extension to run on TolShelf) in the class `ServiceProvider`
