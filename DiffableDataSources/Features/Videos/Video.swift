/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class Video: Hashable {
  var id = UUID()
  var title: String
  var thumbnail: UIImage?
  var lessonCount: Int
  var link: URL?
  
  init(title: String, thumbnail: UIImage? = nil, lessonCount: Int, link: URL?) {
    self.title = title
    self.thumbnail = thumbnail
    self.lessonCount = lessonCount
    self.link = link
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  static func == (lhs: Video, rhs: Video) -> Bool {
    lhs.id == rhs.id
  }
}

class Category: Hashable {
  var id = UUID()
  var thumbnail: UIImage?

  init(thumbnail: UIImage? = nil) {
    self.thumbnail = thumbnail
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }

  static func == (lhs: Category, rhs: Category) -> Bool {
    lhs.id == rhs.id
  }
}

// MARK: - Video Sample Data
extension Video {
  static let allVideos: [VideoItem] = [
    Video(
      title: "SwiftUI",
      thumbnail: UIImage(named: "swiftui"),
      lessonCount: 37,
      link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
    ),
    Video(
      title: "Data Structures & Algorithms in Swift",
      thumbnail: UIImage(named: "datastructures"),
      lessonCount: 29,
      link: URL(string: "https://www.raywenderlich.com/977854-data-structures-algorithms-in-swift")
    ),
    Video(
      title: "Beginning ARKit",
      thumbnail: UIImage(named: "arkit"),
      lessonCount: 46,
      link: URL(string: "https://www.raywenderlich.com/737368-beginning-arkit")
    ),
    Video(
      title: "Fastlane for iOS",
      thumbnail: UIImage(named: "fastlane"),
      lessonCount: 44,
      link: URL(string: "https://www.raywenderlich.com/1259223-fastlane-for-ios")
    ),
    Video(
      title: "Machine Learning in iOS",
      thumbnail: UIImage(named: "machinelearning"),
      lessonCount: 15,
      link: URL(string: "https://www.raywenderlich.com/1320561-machine-learning-in-ios")
    ),
    Video(
      title: "Beginning RxSwift",
      thumbnail: UIImage(named: "rxswift"),
      lessonCount: 39,
      link: URL(string: "https://www.raywenderlich.com/4743-beginning-rxswift")
    ),
    Video(
      title: "Demystifying Views in iOS",
      thumbnail: UIImage(named: "views"),
      lessonCount: 26,
      link: URL(string: "https://www.raywenderlich.com/4518-demystifying-views-in-ios")
    ),
    Video(
      title: "Push Notifications",
      thumbnail: UIImage(named: "notifications"),
      lessonCount: 33,
      link: URL(string: "https://www.raywenderlich.com/1258151-push-notifications")
    ),
    Video(
      title: "Reproducing Popular iOS Controls",
      thumbnail: UIImage(named: "controls"),
      lessonCount: 31,
      link: URL(string: "https://www.raywenderlich.com/5298-reproducing-popular-ios-controls")
    )
  ].map { VideoItem.video($0) }
}

extension Category {
  static let allCategories = [
    Category(
      thumbnail: UIImage(named: "swiftui")
    ),
    Category(
      thumbnail: UIImage(named: "arkit")
    ),
    Category(
      thumbnail: UIImage(named: "fastlane")
    ),
    Category(
      thumbnail: UIImage(named: "machinelearning")
    ),
    Category(
      thumbnail: UIImage(named: "rxswift")
    ),
    Category(
      thumbnail: UIImage(named: "swiftui")
    ),
    Category(
      thumbnail: UIImage(named: "views")
    ),
    Category(
      thumbnail: UIImage(named: "controls")
    ),
  ].map { VideoItem.category($0) }
}
