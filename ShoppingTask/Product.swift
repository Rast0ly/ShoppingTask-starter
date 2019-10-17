class Product : Equatable, Hashable, Comparable {
    
    static func <(lhs: Product, rhs: Product) -> Bool {
        return lhs.id < rhs.id
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    var name :String
    
    /** Price, in pence*/
    var price :Int
    var id :Int
    
    init(_ name:String, price:Int, id:Int){
        self.name = name
        self.price = price
        self.id = id
    }
}

