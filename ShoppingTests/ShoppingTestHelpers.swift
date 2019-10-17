import XCTest

class Helper{
    
    private var products = Set<Product>()
    
    static let shared = Helper()
    
    private init(){
        let bundle = Bundle(for: A_ShoppingTests.self)
        let fileLocation = bundle.path(forResource: "Products", ofType: "plist")
        
        let productArray = NSArray(contentsOfFile: fileLocation!)
        
        let dictArray = productArray as! Array<Dictionary<String,AnyObject>>
        
        for dict in dictArray{
            let name = dict["Name"] as! String
            let price = dict["Price"] as! Int
            let prodId = dict["ProdId"] as! Int
            
            let item = Product(name, price: price, id: prodId)
            products.insert(item)
        }
    }
    
    func productById(_ id: Int) -> Product? {
        return products.first(where: {$0.id == id})
    }
    
    // MARK: Timing helpers
    
    func offer(_ offer: Offer, hasFasterAppliesMethodWith products: [Product]) -> Bool {
        return closure({
            _ = offer.applies(to: products)
        }, isFasterThan: {
            _ = offer.discount(for:products)
        })
    }
    
    private func closure(_ firstClosure: () -> Void, isFasterThan secondClosure: () -> Void) -> Bool {
        return timeExecution(firstClosure) < timeExecution(secondClosure)
    }
    
    private func timeExecution(_ closure: () -> Void) -> TimeInterval {
        let startTime = Date()
        for _ in 1...10000 {
            closure()
        }
        return Date().timeIntervalSince(startTime)
    }
    
}

class P {
    //drinks
   // static let coke = Helper.shared.productById(401)!
    //static let dietcoke = Helper.shared.productById(402)!
    //static let cokezero = Helper.shared.productById(403)!
    //static let 🍾 = Helper.shared.productById(901)!
//    static let 🍷 = Helper.shared.productById(902)!
    //    static let 💧 = Helper.shared.productById(410)!
    
    static let coke = Product("1.75l Coca-Cola",price: 200,id: 401)
    static let dietcoke = Product("2l Diet Coke",price: 200,id: 402)
    static let cokezero = Product("500ml Coke Zero", price: 120, id: 403)
    static let 🍾 = Product("Sauvignon Blanc 75cl", price: 499, id: 901)
    static let 🍷 = Product("Cabernet Sauvinon 75cl", price: 299, id: 902)
    static let 💧 = Product("Evian Mineral Water 500ml",price: 129,id: 410)
    
    static let milk = Helper.shared.productById(137)!
    
    //meats
    static let chicken = Helper.shared.productById(303)!
    static let 🍗 = Helper.shared.productById(306)!
    static let mince = Helper.shared.productById(304)!
    static let smokedBacon = Helper.shared.productById(301)!
    static let unsmokedBacon = Helper.shared.productById(302)!
    static let porkChops = Helper.shared.productById(305)!
    
    //puddings
    static let chocPudding = Helper.shared.productById(1001)!
    static let tiramisu = Helper.shared.productById(1002)!
    static let profiteroles = Helper.shared.productById(1003)!
    
    //deodorants
    static let lynx = Helper.shared.productById(65)!
    static let dove = Helper.shared.productById(66)!
    
    //laundry
    static let persil = Helper.shared.productById(617)!
    static let ariel = Helper.shared.productById(618)!
    static let comfortSoftener = Helper.shared.productById(619)!
    static let genericSoftener = Helper.shared.productById(620)!
    static let premiumSoftener = Helper.shared.productById(621)!
    
    //misc
    static let 📰 = Helper.shared.productById(565)!
    static let 🍞 = Helper.shared.productById(134)!
    static let garlicBread = Helper.shared.productById(1011)!
    static let mushrooms = Helper.shared.productById(1012)!
    
    //pizza store
    static let pepperoniPizza = Helper.shared.productById(2001)!
    static let meatPizza = Helper.shared.productById(2002)!
    static let veggiePizza = Helper.shared.productById(2004)!
    
    static let flatGarlicBread = Helper.shared.productById(2005)!
    static let potatoWedges = Helper.shared.productById(2003)!
    static let doughBalls = Helper.shared.productById(2006)!
    static let cookies = Helper.shared.productById(2007)!
}

