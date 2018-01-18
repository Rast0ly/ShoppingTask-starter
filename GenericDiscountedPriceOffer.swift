class GenericDiscountedPriceOffer : DiscountedPriceOffer{
    
    var name: String
    var applicableProductIds : Set<Int>
    var discountPercentage: Double
    
    init?(name: String, applicableProductIds: Set<Int>, discountPercentage: Double){
        
        guard discountPercentage <= 1 && discountPercentage > 0 else {
            return nil
        }
        
        self.name = name
        self.applicableProductIds = applicableProductIds;
        self.discountPercentage = discountPercentage
    }
    
    
}
