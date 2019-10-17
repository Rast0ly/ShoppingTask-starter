///Free softener with every detergent bought
class FreeSoftenerWithDetergentOffer : TriggerOffer {
   
    var triggerProductIds : Set<Int>
    var discountableProductIds : Set<Int>
    var name: String
    
    init(){
        name = "Free Softener with Detergent"
        triggerProductIds = [617,618] //detergent
        discountableProductIds = [619,620,621] //softeners
    }
    
    func applies(to purchases: [Product]) -> Bool {
        return false
    }
    
    func discount(for purchases: [Product]) -> Int {
        return 0
    }
}
