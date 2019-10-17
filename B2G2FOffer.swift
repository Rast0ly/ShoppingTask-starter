class B2G2F : MultiBuyOffer {
    var quantityPaid = 2
    var quantityFree = 2
    var productIds = Set(arrayLiteral: 65,66)
    var name: String = "Buy 2 Get 2 free"
    
    func applies(to purchases: [Product]) -> Bool {
        return false
    }
    
    func discount(for purchases: [Product]) -> Int {
        return 0
    }
    
}
