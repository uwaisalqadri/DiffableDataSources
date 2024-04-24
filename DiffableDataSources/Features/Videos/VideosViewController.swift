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
import SafariServices

class VideosViewController: UICollectionViewController {
  var sections = VideoSection.allCases
  private var searchController = UISearchController(searchResultsController: nil)

  private lazy var dataSource: DiffableDataSource = {
    let dataSource = DiffableDataSource<VideoSection, VideoItem>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
      switch itemIdentifier {
      case .category(let item):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newcell", for: indexPath) as? VideoCategoryCell
        cell?.category = item
        return cell
      case .video(let item):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as? VideoCollectionViewCell
        cell?.video = item
        return cell
      }
    }

    dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
      return self.supplementaryView(in: collectionView, kind: kind, at: indexPath)
    }

    return dataSource
  }()

  // MARK: - Life Cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureSearchController()
    configureLayout()
    applySnapshot(animatingDifferences: false)
  }

  private func configureLayout() {
    collectionView.register(SectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier)
    collectionView.register(UINib(nibName: "VideoCategoryCell", bundle: Bundle.main), forCellWithReuseIdentifier: "newcell")

    collectionView.collectionViewLayout = createLayout()
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: { context in
      self.collectionView.collectionViewLayout.invalidateLayout()
    }, completion: nil)
  }

  func applySnapshot(animatingDifferences: Bool = true) {
    var snapshot = DiffableSnapshot<VideoSection, VideoItem>()
    snapshot.appendSections(sections)
    snapshot.appendItems(Video.allVideos, toSection: .video)
    snapshot.appendItems(Category.allCategories, toSection: .category)

    dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
  }
}

// MARK: - UICollectionViewDelegate
extension VideosViewController {
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
    guard case let .video(data) = item, let link = data.link else {
      print("Invalid link")
      return
    }
    let safariViewController = SFSafariViewController(url: link)
    present(safariViewController, animated: true, completion: nil)
  }

  private func supplementaryView(in collectionView: UICollectionView, kind: String, at indexPath: IndexPath) -> UICollectionReusableView? {
    guard kind == UICollectionView.elementKindSectionHeader else { return nil }
    let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier, for: indexPath) as? SectionHeaderReusableView
    view?.titleLabel.text = self.dataSource.snapshot()
      .sectionIdentifiers[indexPath.section].title
    return view
  }
}

// MARK: - UISearchResultsUpdating Delegate
extension VideosViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    sections = filteredSections(for: searchController.searchBar.text)
    applySnapshot()
  }

  func filteredSections(for queryOrNil: String?) -> [VideoSection] {
    let sections = VideoSection.allCases

    guard
      let query = queryOrNil,
      !query.isEmpty
    else {
      return sections
    }

    return sections.filter { section in
      var matches = section.title.lowercased().contains(query.lowercased())

      for case let item in dataSource.snapshot().itemIdentifiers(inSection: section) {
        switch item {
        case .video(let data):
          if data.title.lowercased().contains(query.lowercased()) {
            matches = true
            break
          }
        case .category(let data):
          break
        }
      }
      return matches
    }
  }

  func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Videos"
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
}

// MARK: - SFSafariViewControllerDelegate Implementation
extension VideosViewController: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
