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
        
        var discountApplyed = 0
        
        for items in purchases{
            if productIds.contains(items.id) {
                discountApplyed += Int(Double(items.price) * discountPercentage)
                
                 
            }
            
        }
        

        return discountApplyed
        
    }
    
    
    
}
