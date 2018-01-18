class GenericCappedOffer : CappedOffer{
    
    var maxPrice: Int
    var productQuantity: Int
    var applicableProductIds: Set<Int>
    var name: String
    
    init(name: String, applicableProductIds: Set<Int>, quantity: Int, maxPrice: Int){
        self.name = name
        self.applicableProductIds = applicableProductIds
        self.productQuantity = quantity
        self.maxPrice = maxPrice
    }
    
}
