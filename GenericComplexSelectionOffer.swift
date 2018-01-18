class GenericComplexSelectionOffer : ComplexSelectionOffer {
    var productIdGroupsAndQuantities: Array<(items: Set<Int>, quantity: Int)>
    
    var maxPrice: Int
    
    var name: String
    
    init?(name: String, productIdGroupsAndQuantities: Array<(items: Set<Int>, quantity: Int)>, maxPrice: Int){
        guard productIdGroupsAndQuantities.count > 0 && maxPrice > 0 else {
            return nil
        }
        self.name = name;
        self.productIdGroupsAndQuantities = productIdGroupsAndQuantities
        self.maxPrice = maxPrice
    }
}

extension ComplexSelectionOffer {
    
    func appliesTo(_ list: [Product]) -> Bool {
        for group in productIdGroupsAndQuantities {
            
            if countOfProducts(list, matchingIds: group.items) < group.quantity {
                return false
            }
        }
        return true
    }
    
    private func countOfProducts(_ list: [Product], matchingIds:Set<Int>) -> Int{
        var count = 0
        for item in list {
            if matchingIds.contains(item.id) {
                count += 1
            }
        }
        return count
    }
    
    func discountFrom(_ list: [Product]) -> Int {
        var discountTotal = 0
        var priceOrderedProducts = list.sorted(by: { $0.priceInPence > $1.priceInPence})
        while appliesTo(priceOrderedProducts) {
            var productsInOffer = [Product]()
            var indexesToRemove = [Int]()
            for group in productIdGroupsAndQuantities {
                var countInGroup = group.quantity
                while countInGroup > 0 {
                    for (index, item) in priceOrderedProducts.enumerated() {
                        if group.items.contains(item.id){
                            productsInOffer.append(item)
                            indexesToRemove.append(index)
                            countInGroup -= 1
                            if countInGroup == 0 {
                                break
                            }
                        }
                    }
                }
            }
            let preDiscountPrice = productsInOffer.reduce(0, {$0 + $1.priceInPence})
            if  preDiscountPrice > maxPrice {
                discountTotal += preDiscountPrice - maxPrice
            }
            let reversedIndexes = indexesToRemove.reversed()
            for index in reversedIndexes {
                priceOrderedProducts.remove(at: index)
            }
        }
        return discountTotal
    }
    
}
