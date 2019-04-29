# CollectionItemDeletion

![](https://github.com/amalhaririy/CollectionItemDeletion/blob/9c8002ce5c6c30e3b49a04ffc1c542b6a64f7f6d/ezgif.com-optimize.gif) 
![](https://github.com/amalhaririy/CollectionItemDeletion/blob/master/ezgif.com-video-to-gif.gif)

similar to facebook massenger chat head deletion 


Installation




CocoaPods

Tested with pod --version: 1.3.1

# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'CollectionItemDeletion'
end

then type:

$ pod install

# usage
import CollectionItemDeletion
yourCollectionView.setupCollectionItsmdeletion()
yourCollectionView.deletionDelegate = self

extension yourView:CollectionItemDeletionDelegate{
    func item(at index: Int) -> Any {
        return yourCollectionArray![index]
    }
    
    func insert(item: Any, at index: Int) {
         yourCollectionView.insert(item as! yourCollectionArrayItemType , at: index)
    }
    
    
    
    func deleteItem(at index: Int) {
         yourCollectionView.remove(at: index)
    }
    }
    
