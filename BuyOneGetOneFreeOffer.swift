///Buy one get one free on varients of Coca-Cola
class BuyOneGetOneFreeOffer : MultiBuyOffer {
    
    var name: String
    var productIds : Set<Int>
    var quantityPaid: Int
    var quantityFree: Int

    init(){
        name = "2 for 1 on Coca-Cola"
        productIds = [401,402,403];
        quantityPaid = 1
        quantityFree = 1
    }
    func applies(to purchases: [Product]) -> Bool {
        return false
    }
    
    func discount(for purchases: [Product]) -> Int {
        return 0
    }
}
