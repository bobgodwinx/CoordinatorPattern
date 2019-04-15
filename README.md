# Coordinator Pattern
The Coordinator pattern helps us remove the job of app navigation from our `UIViewControllers`, making it manageable and  reusable, it also helps us to adjust our application flow as it best suites to our needs. <br>
If you've been in a situation, where your view controllers became tightly coupled and dependent to each other, your navigation logic is scattered all over the app or you might have heard of the famous `Massive-view-controller` issue, then you are at the right place.

## Scope
The scope of the is repository is put foward a pitch that may later be standardized as a good practice by the community as a way of handling these situations. This is absolutly a learning ground and everyone is welcome to contribute. 

## Architecture
At the beginning og the project I choose `MVVM` for a start, but this doesn't mean that other architectures aren't viable. Infact in the future this project is going to have all other type of architectures like `MVC`, `VIPER`  e.t.c

## Storyboards and Xibs
The essence of coordinator pattern is to actually liberate you from the deep coupling from the `Storyboard` it's self and as such they are forbidden in this repository. <br> I do understand that the coordinator pattern is also possible with  storyboards, there are many ways of doing this pattern, but we're only going to be focusing on creating everything programmatically without the help of  storyboards and xibs files.

## Contribution guide
Anyone interested is welcome to contribute to the project. I believe this will create a great opportunity to both experienced `Swift` engineer and also to people with little or no knowledge of about iOS, Swift or architectures in general. <br>
Please kindly read the CONTRIBUTING.md file within the repository. The entire source code is available under the MIT license.

## Credits 
The coordinator pattern makes use of third party libraries [RxSwift](https://github.com/ReactiveX/RxSwift), [Kingfisher](https://github.com/onevcat/Kingfisher), [Quick](https://github.com/Quick/Quick), [Nimble](https://github.com/Quick/Nimble), [Raywenderlich style guide](https://github.com/raywenderlich/swift-style-guide) Their licenses are stored within their respective repositories. <br>
Swift, Swift logo, Xcode, iPhone are trademarks of Apple Inc., registered in the U.S. and other countries
