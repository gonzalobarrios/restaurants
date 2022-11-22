# Restaurants App

This app displays a simple list of restaurants.
XCode version: 14.0.1
Swift version: 5

I built it following the MVVM Architecture in order to separate the UI Logic from the Business Logic. The buisiness logic lives in the ViewModel and the ViewController is only in charge of updating and creating the UI Components.
For the Networking I created an APIManager class and I used the Combine Framwork to do the request and also in then ViewModel for managing of the responses of the requests with the Data.

Also I created an Image loader and Cache in order to improve the performace when we use then, especially when scrolling and the cells with images load.

The User Interface is simple but the important thing here is that it is builtd wihout using Storyoards or Xibs that was one of the requirements, so it is purly programmatic UI which is important becuase it easier to solve issues or simply detect them.

To run the project you simply have to download it from here and open it with Xcode. There is no need to install any extra framework becuase I made it with the native frameworks that Swift provides.


<img width="431" alt="image" src="https://user-images.githubusercontent.com/8472089/202293603-1c13a795-9c61-4441-9fa7-a0c7495c0e4a.png">
