extension SimpleOffer {
    /**
     Returns an array containing only the Products to which the offer could be applied
     
     - parameter list: The array of Products objects to be checked
     - returns: An array of Products objects to which the offer is applicable
     */
    func qualifyingProducts(list:[Product]) -> [Product]{
        var productsInOffer = [Product]()
        
        for itemInShoppingList in list {
            if productIds.contains(itemInShoppingList.id) {
                productsInOffer.append(itemInShoppingList)
            }
        }
        return productsInOffer
    }
}
