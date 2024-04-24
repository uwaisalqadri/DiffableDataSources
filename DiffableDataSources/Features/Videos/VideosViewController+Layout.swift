/// Copyright (c) 2024 Razeware LLC
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

import Foundation
import UIKit

typealias DiffableDataSource<SectionIdentifierType: Hashable, ItemIdentifierType: Hashable> = UICollectionViewDiffableDataSource<SectionIdentifierType, ItemIdentifierType>

typealias DiffableSnapshot<SectionIdentifierType: Hashable, ItemIdentifierType: Hashable> = NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>

extension VideosViewController {
  func createLayout() -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
      let size = NSCollectionLayoutSize(
        widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
        heightDimension: NSCollectionLayoutDimension.absolute(280)
      )

      switch self.sections[sectionIndex] {
      case .video:
        return CompositionalLayoutBuilder()
          .withItemLayoutSize(size)
          .withGroupLayoutSize(size)
          .withSectionInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
          .withSectionInterGroupSpacing(10)
          .withHeaderLayoutSize(.init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20)))
          .build()
      case .category:
        return CompositionalLayoutBuilder()
          .withItemLayoutSize(.init(widthDimension: .absolute(100), heightDimension: .absolute(100)))
          .withGroupLayoutSize(.init(widthDimension: .absolute(100), heightDimension: .absolute(100)))
          .withSectionInsets(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
          .withSectionInterGroupSpacing(10)
          .withHeaderLayoutSize(.init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(20)))
          .withOrthogonalScrollingBehavior(.groupPaging)
          .build()
      }
    }
  }
}
