class GenericSelectionOffer : SelectionOffer {
   
    var productIdGroups: Set<Set<Int>>
    var maxPrice: Int
    var name: String
    
    init?(name: String, productIdGroups: Set<Set<Int>>, maxPrice: Int){
        guard maxPrice > 0 else {
            return nil
        }
        self.name = name
        self.maxPrice = maxPrice
        self.productIdGroups = productIdGroups
    }
    
}
