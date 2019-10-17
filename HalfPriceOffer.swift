///Half price on Wine 🍷
class HalfPriceOffer : DiscountedPriceOffer {
    
    var name: String
    var productIds : Set<Int>
    var discountPercentage: Double 
    
    init(){
        name = "Half Price on Wine"
        productIds = [901,902];
        discountPercentage = 0.5
    }
    func applies(to purchases: [Product]) -> Bool {
        return false
    }
    
    func discount(for purchases: [Product]) -> Int {
        return 0
    }
}
