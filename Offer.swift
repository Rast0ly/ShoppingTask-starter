/**
 Represents any type of offer when purchasing a product
 */
protocol Offer {
    
    /**
     Determines whether an offer could apply to a given list of products. It should execute faster than the discoutFrom method
     
     - Parameter purchases: An array of ShoppingItem objects
     - Returns:
     true or false: depending on whether the offer applies to item(s) in the list
     */
    func applies(to purchases: [Product]) -> Bool
    
    /**
     Determines the discount applying the offer will have, given a list of products*
     
     - Parameter purchases: An array of ShoppingItem objects
     - Returns: the value of the discount
     */
    func discount(for purchases: [Product]) ->Int
    
    /**
     The name of the offer, for example, "Dine if for 2 for £10"
     */
    var name : String {get set}
}

/**
 Represents an offer where the customer can have money off their purchases, irrespective of which products are purchased
 */
protocol MoneyOffOffer : Offer {
    var discount : Int {get set}
}

/**
 Represents an offer where the customer can have money off purchases of specific products
 */
protocol MoneyOffProductsOffer : MoneyOffOffer, SimpleOffer {
    
}

/**
 Represents a type of offer where all products in the offer are eligible for discounting
 */
protocol SimpleOffer : Offer {
    /**
     Product Id values for all products in the offer
     */
    var productIds : Set<Int> {get set}
}

/**
 Represents a type of offer where the product is reduced in price by a certain percentage, for example 25% off
 */
protocol DiscountedPriceOffer : SimpleOffer {
    
    /**
    *Represents the percentage discount applied, e.g. 0.5 is 50%*
     - important: The value must be between 0 and 1
     */
    var discountPercentage : Double {get set}
    
}

/**
 Represents a type of offer where a certain number of items in the offer must be bought, and this will permit a certain number of items, also in the offer to be discounted (for example, Buy 2 get 1 free, or buy 5 get 2 free).
 Ordered by price, the cheapest items in each group should be discounted. Example: For a buy 2 get 1 free: the discount would be the value of every third item bought when the list is sorted in price order. E.g. with the following items: A: 500p, B: 200p, C: 189p, D: 50p, E: 20p, F: 700p and G: 350p items G and D would be free.
 */
protocol MultiBuyOffer : SimpleOffer {
    
    /** The number of products that must be paid for*/
    var quantityPaid : Int {get set}
    /** The number that are free (per quantity paid for) */
    var quantityFree : Int {get set}
}

/**
 Represents a type of offer where when you buy a certain number of products, the price is capped at a certain value, for example, A 'Buy 3 meats for £10' offer
 Discount should be calculated by placing the items in price order (highest first), and capping the value of each group of products by returning a corresponding discount where applicable. (i.e. the offer is to the benefit of the customer)
 */
protocol CappedOffer : SimpleOffer {
    /**The maximum price that should be paid for a group of n products*/
    var maxPrice : Int {get set}
    
    /**How many pruducts need to be purchased for the offer to apply */
    var productQuantity : Int {get set}
}

/**
 Represents a type of offer where if you buy a product in one category, you're eligible for a free product in another category, for example, buy a newspaper and get a free bottle of water
 The most expensive items from the discountable products should be included for the deal(s) (i.e. the offer is to the benefit of the customer)
 */
protocol TriggerOffer : Offer {
    /** The ids of the products that must be purchased in order to qualify for the offer*/
    var triggerProductIds : Set<Int> {get set}
    
    /** The ids of the products that can be discounted if a qualifying product is bought */
    var discountableProductIds : Set<Int> {get set}
}

/**
 Represents a type of offer where one item from a number of categories can be purchased, for a set price, for example the M&S 'Dine in for 2 for £10' deal where customers can choose a drink, side, main and dessert, each from a range of products and pay no more than £10
 The most expensive items from each category should be selected for the deal(s) (i.e. the offer is to the benefit of the customer)
 
The 'applies' method may assume that inclusion of one item from each group in the purchases is enough for the offer to apply (regardless of the price of those items). The 'discount' method should check the items cost enough to qualify for a discount however.
 */
protocol SelectionOffer : Offer {
    var productIdGroups : Set<Set<Int>> {get set}
    var maxPrice : Int {get set}
}

/**
 Represents a type of offer, where, given a series of product categories, customers can purchase one or more items from each category, where the number they must purchase from each category is specified, for example 'Purchase 2 pizzas, a garlic bread, two addiitonal sides, and a drink for £20)
 The most expensive items from each category should be selected for the deal(s) (i.e. the offer is to the benefit of the customer)
The 'applies' method may assume that inclusion of the requisite number of items from each group in the purchases is enough for the offer to apply (regardless of the price of those items). The 'discount' method should check the items cost enough to qualify for a discount however.
 */
protocol ComplexSelectionOffer : Offer {
    var productIdGroupsAndQuantities : Array<(items: Set<Int>, quantity: Int)> {get set}
    var maxPrice : Int {get set}
}



/**
 Represents a type of offer, where a certain number of items must be bought from one set of products, and a certain number of items from a different set of products will be free
 E.g. Buy any 5 packs of meat and recieve any two free bottles of table sauce, such as ketchup or mayo
 Most expensive items free
 */
protocol TriggerMultiBuy : TriggerOffer, MultiBuyOffer {
    
}



//todo: Offer for specific quantities of trigger products and get specific quantities of free products, e.g. buy any television, any blu-ray player and 2 HDMI cables, recieve a free soundbar and 5 blue-ray discs of your choice



