# FAParser


![Alt text](http://i.imgur.com/qUV86bJ.png "AZ-TableViewImage")

[![Swift version](https://img.shields.io/badge/swift-3.0-orange.svg?style=flat.svg)](https://img.shields.io/badge/swift-3.0-orange.svg?style=flat.svg)
[![Support Dependecy Manager](https://img.shields.io/badge/support-CocoaPods-red.svg?style=flat.svg)](https://img.shields.io/badge/support-CocoaPods-red.svg?style=flat.svg)
[![Version](https://img.shields.io/cocoapods/v/FAParser.svg?style=flat)](http://cocoapods.org/pods/FAParser)
[![License](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat.svg)](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat.svg)
[![Platform](https://img.shields.io/cocoapods/p/FAParser.svg?style=flat)](http://cocoapods.org/pods/FAParser)



## Features

* Automatic pagination handling 
* No more awkward empty TableView
* AZ TableView controller give you advantage to connect your (Loading, no result, error ) views via Interface builder

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```


To integrate AZTableViewController into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
pod 'AZTableView'
end
```

Then, run the following command:

```bash
$ pod install
```



## Pre-Requisite

* Key Value Coding
* To learn about key-value-coding, please visit Apple's official KVC [documentation](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/KeyValueCoding/) 

## Usage


### JSON Parsing

- Let suppose, if following is the JSON response object of your API call 

```swift

//  Let say we get a JSON object of Movie as response from API call,

{  

    "id":"m_123456789",
    "Title":"Batman",
    "Year":"1989",
    "Rated":"PG-13",
    "Released":"23 Jun 1989",
    "Runtime":"126 min",
    "Genre":"Action, Adventure",
    "Director":"Tim Burton",
    "Writer":"Bob Kane (Batman characters), Sam Hamm (story), Sam Hamm (screenplay), Warren Skaaren (screenplay)",
    "Actors":"Michael Keaton, Jack Nicholson, Kim Basinger, Robert Wuhl",
    "Language":"English, French",
    "Country":"USA, UK",
    "Awards":"Won 1 Oscar. Another 9 wins & 22 nominations.",
    "Poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMTYwNjAyODIyMF5BMl5BanBnXkFtZTYwNDMwMDk2._V1_SX300.jpg",
    
    "Ratings":[  
        {  
            "Source":"Internet Movie Database",
            "Value":"7.6/10"
        },
        {  
            "Source":"Rotten Tomatoes",
            "Value":"72%"
        },
        {  
            "Source":"Metacritic",
            "Value":"69/100"
        }
    ],

    "Author":{  
        "name" :"Fahid Attique",
        "email":"fahidattique55@gmail.com"
    },

    "Metascore":"69",
    "imdbRating":"7.6",
    "imdbVotes":"279,110",
    "imdbID":"tt0096895",
    "Type":"movie",
    "DVD":"25 Mar 1997",
    "BoxOffice":"N/A",
    "Production":"Warner Bros. Pictures",
    "Website":"N/A",
}

```

### JSON Parsing with Key Value Coding


```swift

import FAParser

let movie = Movie.objectfrom(json: responseFromAPI)

```

### Class Movie

- Make sure the name of keys of JSON response matches exactly the same with the name of properties/keys of your modal class, as Apple follows it in KVC
- For special cases like "id", you can use other names like "movie_id" or "movieID" etc 

```swift

class Movie: NSObject {


    // MARK: Properties


    //  Array of Nested JSON object
    var  Ratings:Array<Rating>? = nil

    //  Nested JSON object
    var  Author:Author? = nil

    //  JSON simple keys

    var  movie_id :String = ""      //  Special case

    var  Title :String = ""
    var  Year:String = ""
    var  Rated:String = ""
    var  Released:String = ""
    var  Runtime:String = ""
    var  Genre:String = ""
    var  Director:String = ""
    var  Writer:String = ""
    var  Actors:String = ""
    var  Language:String = ""
    var  Country:String = ""
    var  Awards:String = ""
    var  Poster:String = ""
    var  Metascore:String = ""
    var  imdbRating:String = ""
    var  imdbVotes:String = ""
    var  imdbID:String = ""
    var  Type:String = ""
    var  DVD:String = ""
    var  BoxOffice:String = ""
    var  Production:String = ""
    var  Website:String = ""




    // MARK: initialization

    override init() {
        super.init()
    }

    // MARK: KVC + JSON Parsing

    override func setValue(_ value: Any?, forKey key: String) {

        if let aVlaue = value {

            if key == "Author" {   //  As our JSON have nested JSON object with this key 

                //  Parse Nested JSON using FAParser 

                Author = Author.objectfrom(json: value) 
            }
            else if key == "Ratings" {   //  As out JSON have an array of nested JSON objects

                //  Parse Array of Nested JSON objects using FAParser 

                Ratings = Rating.objectsfrom(jsonArray: value as! Array)
            }
            else{   //  In case of simple JSON keys i.e: Not a nested JSON object or an Array of JSON objects

                if key == "id"{     //  Special cases only. Otherwise no need of adding if statement
                    movie_id = value
                }
                else{
                    //  Following code will automatically parse remaining fields of your JSON to model as their names are same as our Model properties

                    super.setValue(aVlaue, forKey: key)
                }
            }
        }
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

        //  In case there is a key in JSON that does not exist as a property in our Model Class

        print("This class is not key-value-compliant for key: \(key) & value : \(value)")
    }
}


```

### Class Author


```swift


class Author: NSObject {


    // MARK: Properties

    var name:String = ""
    var email:String = ""


    // MARK: initialization

    override init() {
        super.init()
    }

    // MARK: KVC + JSON Parsing

    override func setValue(_ value: Any?, forKey key: String) {

        //  Following code will automatically parse JSON to model as their names are same as our Model properties
        super.setValue(value, forKey: key) 
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

        //  In case there is a key in JSON that does not exist as a property in our Model Class
        print("This class is not key-value-compliant for key: \(key) & value : \(value)")
    }
}

```


### Class Rating


```swift

class Rating: NSObject {


    // MARK: Properties

    var Source:String = ""
    var Value:String = ""


    // MARK: initialization

    override init() {
        super.init()
    }

    // MARK: KVC + JSON Parsing

    override func setValue(_ value: Any?, forKey key: String) {

        //  Following code will automatically parse JSON to model as their names are same as our Model properties
        super.setValue(value, forKey: key) 
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

        //  In case there is a key in JSON that does not exist as a property in our Model Class
        print("This class is not key-value-compliant for key: \(key) & value : \(value)")
    }
}


```




### Archiving & Unarchiving

- Let say, you want to archive the Movie class object in UserDefaults. Just inherit it from Class "FAAutoCode" 


```swift

import FAParser

//  Subclass your Custom Modal Class with FAAutoCode Class 

class Movie: FAAutoCode {  

    ...     //  Additional code, if exist 
 
    // MARK: NSCoding

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

```

* All Done!!! FAAutoCode Class will automatically write the NSCoding protocols code for class Movie

```swift

//  Now you can Archive your custom object with fillowing lines of code

let data = NSKeyedArchiver.archivedData(withRootObject:<custom object>)
UserDefaults.standard.set(data, forKey: "<Any Key you want>")
UserDefaults.standard.synchronize()


//  To Unarchive your custom object from User Defaults, use the following code

if let data = UserDefaults.standard.value(forKey: "<Any Key you want>") {
    movie = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as! <Custom Class>?
}

```

### AZJSONable 


- Let say, you want to convert Movie class object in dictionary to pass it in some api request. Just confirm it to protocol "AZJSONable" 

```swift

import FAParser

//  Confirm your Modal Class with AZJSONable Protocol  

class Movie: AZJSONable {  

    var title:  String = ""
    var actor:  String = ""
}


```

- And to convert we only just need to do this

```swift

    let movie: Movie = Movie()

    movie.title     = "La La Land"
    movie.actor    = "Emma Stone"

    let dictFormat :[String: Any] = (movie.toDictionary()) // will convert full object to dictionary


    // To convert it in JSON String 

    dictFormat.jsonString() // or use 

    dictFormat.jsonString(prettify: true)


```

## License

FAParser is available under the MIT license. See the LICENSE file for more info.


## Author

**Fahid Attique** - (https://github.com/fahidattique55)

