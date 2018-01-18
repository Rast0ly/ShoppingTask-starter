
/**Example class to enable testing of discount method
 */
class TenPenceOffOffer : Offer {
    
    var name: String
    
    init(){
        name = "10p off your shopping"
    }
    
    
    func appliesTo(_ list: [Product]) -> Bool {
        return list.count > 0 //must actually buy something to get discount
    }
    
    func discountFrom(_ list: [Product]) -> Int {
        return 10
    }
    
    
    
    
}
