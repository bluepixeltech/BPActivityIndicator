# BPActivityIndicator

[![CI Status](https://img.shields.io/travis/bluepixeltech/BPActivityIndicator.svg?style=flat)](https://travis-ci.org/bluepixeltech/BPActivityIndicator)
[![Version](https://img.shields.io/cocoapods/v/BPActivityIndicator.svg?style=flat)](https://cocoapods.org/pods/BPActivityIndicator)
[![License](https://img.shields.io/cocoapods/l/BPActivityIndicator.svg?style=flat)](https://cocoapods.org/pods/BPActivityIndicator)
[![Platform](https://img.shields.io/cocoapods/p/BPActivityIndicator.svg?style=flat)](https://cocoapods.org/pods/BPActivityIndicator)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

### - Via Cocoapods
BPActivityIndicator is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BPActivityIndicator'
```

### - Via source file
Simply drag & drop BPActivityIndicator.swift into your project.

## Usage

### - Interface Builder


### - Programmatically

```swift
let ai = BPActivityIndicator(frame: CGRect(x: 50.0, y: 50.0, width: 170.0, height: 200.0))
ai.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(ai)
ai.activityIndicatorStyle = .tripleDotDance
ai.backgroundMode = .none
ai.backgroundColorStyle = .dark
ai.titleColor = .lightGray
ai.titleFont = UIFont.systemFont(ofSize: 18.0, weight: .light)
ai.title = "Please wait..."
ai.color = .lightGray
ai.lineWidth = 3.0
ai.startAnimating()
```

## Author

Pouya Khansaryan, bluepixel.technologies@gmail.com

## License

BPActivityIndicator is available under the MIT license. See the LICENSE file for more info.
