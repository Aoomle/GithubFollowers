//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Abdulmalik Muhammad on 13/10/2020.
//

import UIKit

func threePhotoGrid(in view: UIView,  collectionViewLayout: UICollectionViewFlowLayout) -> Int {
  let flowLayout = collectionViewLayout

  let numberofItem: CGFloat = 3

  let collectionViewWidth = view.bounds.width

  let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing

  let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left

  let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
  
  return width
}
