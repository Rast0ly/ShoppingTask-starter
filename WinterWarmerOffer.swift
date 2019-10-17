///Buy a certain number if items from of each group and pay £20.99 (e.g. 2 pizzas, 2 sides, 1 garlic bread and 1 dessert)
class WinterWarmerOffer : ComplexSelectionOffer {
    var productIdGroupsAndQuantities: Array<(items: Set<Int>, quantity: Int)>
    var maxPrice: Int
    var name: String
    
    init(){
        let pizzas = [2002, 2004, 2001]
        let sides = [2006, 2003]
        let garlicBreads = [2005, 1011]
        let desserts = [2007]
        
        let pizzaRule = (items: Set(pizzas), quantity: 2)
        let sidesRule = (items: Set(sides), quantity: 2)
        let garlicBreadRule = (items: Set(garlicBreads), quantity: 1)
        let dessertRule = (items: Set(desserts), quantity: 1)
        
        name = "Winter Warmer"
        productIdGroupsAndQuantities = [pizzaRule, sidesRule, garlicBreadRule, dessertRule]
        maxPrice = 2099
    }
    func applies(to purchases: [Product]) -> Bool {
        return false
    }
    
    func discount(for purchases: [Product]) -> Int {
        return 0
    }


}
