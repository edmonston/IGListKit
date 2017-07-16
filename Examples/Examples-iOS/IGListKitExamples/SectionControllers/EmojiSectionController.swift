/**
 Copyright (c) 2016-present, Facebook, Inc. All rights reserved.

 The examples provided by Facebook are for non-commercial testing and evaluation
 purposes only. Facebook reserves all rights not expressly granted.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 FACEBOOK BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit
import IGListKit

final class EmojiSectionController: ListSectionController, ListAdapterDataSource {

    private var emojis: [String]?

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(),
                                    viewController: self.viewController)
        adapter.dataSource = self
        return adapter
    }()

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 150)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: EmbeddedFlowCollectionViewCell.self,
                                                          for: self,
                                                          at: index) as? EmbeddedFlowCollectionViewCell else {
                                                            fatalError()
        }
        adapter.collectionView = cell.collectionView
        return cell
    }

    override func didUpdate(to object: Any) {
        emojis = (object as? EmojiGroup)?.emoji
    }

    // MARK: ListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return emojis?.map { $0 as ListDiffable } ?? []
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return EmbeddedFlowSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

}
