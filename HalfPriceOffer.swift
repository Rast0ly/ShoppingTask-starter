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
    
    //should return true if wine is in the purchases.
    func applies(to purchases: [Product]) -> Bool {
        
        for item in purchases{
            if productIds.contains(item.id){
                return(true)
            }
        }
        return(false)
        
    }
    
    func discount(for purchases: [Product]) -> Int {
        
        var total:Double = 0
        
        
        for item in purchases{
            let price = item.price
            total = price -= Int(discountPercentage)
            
                //redcue is suppoed to add up the total. I thinbk im going wrong by not finding the total of the right items
            
        }
        
        return Int(total)
    }
}
