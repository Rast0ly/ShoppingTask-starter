import Foundation

print("Don't run the programme - instead run the unit tests")
print("Click Product -> Test on the menu bar")
print("Alternatvely use the keyboard shortcut ⌘+U to run them")

print("Example output can be seen below")


var products = [Product]()
let bundle = Bundle.main
let fileLocation = bundle.path(forResource: "Products", ofType: "plist")

let productArray = NSArray(contentsOfFile: fileLocation!)

let dictArray = productArray as! Array<Dictionary<String,AnyObject>>

for dict in dictArray{
    let name = dict["Name"] as! String
    let price = dict["Price"] as! Int
    let prodId = dict["ProdId"] as! Int
    
    let item = Product(name: name , price: price, productId: prodId)
    products.append(item)
}

var receipt = Receipt();
receipt.items = products;
print(receipt.print())
