//
//  CompositionalLayoutBuilder.swift
//  CommonUI
//
//  Created by Uwais Alqadri on 30/8/23.
//

import Foundation
import UIKit

public struct CompositionalLayoutBuilder {
  private var itemLayoutSize: NSCollectionLayoutSize?
  private var itemInsets: NSDirectionalEdgeInsets = .zero
  private var itemInterSpacing: NSCollectionLayoutSpacing? = nil

  private var groupLayoutSize: NSCollectionLayoutSize?
  private var groupInsets: NSDirectionalEdgeInsets = .zero
  private var groupInterSpacing: CGFloat? = nil

  private var headerLayoutSize: NSCollectionLayoutSize? = nil
  private var headerInsets: NSDirectionalEdgeInsets = .zero
  private var headerIsPinToVisibleBounds: Bool = false

  private var footerLayoutSize: NSCollectionLayoutSize? = nil
  private var footerInsets: NSDirectionalEdgeInsets = .zero

  private var sectionInsets: NSDirectionalEdgeInsets = .zero
  private var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none

  public init() {}

  public func withItemLayoutSize(_ size: NSCollectionLayoutSize) -> Self {
    var builder = self
    builder.itemLayoutSize = size
    return builder
  }

  public func withItemInsets(_ insets: NSDirectionalEdgeInsets) -> Self {
    var builder = self
    builder.itemInsets = insets
    return builder
  }

  public func withGroupInterItemSpacing(_ spacing: NSCollectionLayoutSpacing) -> Self {
    var builder = self
    builder.itemInterSpacing = spacing
    return builder
  }

  public func withGroupLayoutSize(_ size: NSCollectionLayoutSize) -> Self {
    var builder = self
    builder.groupLayoutSize = size
    return builder
  }

  public func withGroupInsets(_ insets: NSDirectionalEdgeInsets) -> Self {
    var builder = self
    builder.groupInsets = insets
    return builder
  }

  public func withSectionInterGroupSpacing(_ spacing: CGFloat) -> Self {
    var builder = self
    builder.groupInterSpacing = spacing
    return builder
  }

  public func withHeaderLayoutSize(_ size: NSCollectionLayoutSize, isPinToVisibleBounds: Bool = false) -> Self {
    var builder = self
    builder.headerLayoutSize = size
    builder.headerIsPinToVisibleBounds = isPinToVisibleBounds
    return builder
  }

  public func withHeaderInsets(_ insets: NSDirectionalEdgeInsets) -> Self {
    var builder = self
    builder.headerInsets = insets
    return builder
  }

  public func withFooterLayoutSize(_ size: NSCollectionLayoutSize) -> Self {
    var builder = self
    builder.footerLayoutSize = size
    return builder
  }

  public func withFooterInsets(_ insets: NSDirectionalEdgeInsets) -> Self {
    var builder = self
    builder.footerInsets = insets
    return builder
  }

  public func withSectionInsets(_ insets: NSDirectionalEdgeInsets) -> Self {
    var builder = self
    builder.sectionInsets = insets
    return builder
  }

  public func withOrthogonalScrollingBehavior(_ behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior) -> Self {
    var builder = self
    builder.orthogonalScrollingBehavior = behavior
    return builder
  }

  //  @discardableResult
  //  public func addGroupItems(_ items: [NSCollectionLayoutItem]) -> Self {
  //    var builder = self
  //    builder.groupItems = items
  //    return builder
  //  }
  //
  //  @discardableResult
  //  public func addGroup(_ group: NSCollectionLayoutGroup) -> Self {
  //    var builder = self
  //    builder.sectionGroup = group
  //    return builder
  //  }

  public func build(subItems: [NSCollectionLayoutItem]) -> NSCollectionLayoutSection {
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize ?? NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000)), subitems: subItems)
    group.contentInsets = groupInsets

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = sectionInsets

    if let groupInterSpacing = groupInterSpacing {
      section.interGroupSpacing = groupInterSpacing
    }

    if let headerLayoutSize = headerLayoutSize {
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerLayoutSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
      header.pinToVisibleBounds = headerIsPinToVisibleBounds
      header.contentInsets = headerInsets
      section.boundarySupplementaryItems.append(header)
    }

    if let footerLayoutSize = footerLayoutSize {
      let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerLayoutSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
      footer.contentInsets = footerInsets
      section.boundarySupplementaryItems.append(footer)
    }

    section.orthogonalScrollingBehavior = orthogonalScrollingBehavior

    return section
  }

  public func build() -> NSCollectionLayoutSection {

    let itemSizePlaceholder = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000))
    let item = NSCollectionLayoutItem(layoutSize: itemLayoutSize ?? itemSizePlaceholder)
    item.contentInsets = itemInsets

    let groupSizePlaceholder = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1000))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize ?? groupSizePlaceholder, subitems: [item])
    group.contentInsets = groupInsets

    if let itemInterSpacing = itemInterSpacing {
      group.interItemSpacing = itemInterSpacing
    }

    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = sectionInsets

    if let groupInterSpacing = groupInterSpacing {
      section.interGroupSpacing = groupInterSpacing
    }

    if let headerLayoutSize = headerLayoutSize {
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerLayoutSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
      header.pinToVisibleBounds = headerIsPinToVisibleBounds
      header.contentInsets = headerInsets
      section.boundarySupplementaryItems.append(header)
    }

    if let footerLayoutSize = footerLayoutSize {
      let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerLayoutSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
      footer.contentInsets = footerInsets
      section.boundarySupplementaryItems.append(footer)
    }

    section.orthogonalScrollingBehavior = orthogonalScrollingBehavior

    return section
  }
}
