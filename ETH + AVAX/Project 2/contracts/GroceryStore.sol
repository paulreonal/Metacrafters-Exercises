// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract GroceryStore {
    // The owner of the contract
    address public owner;

    // A structure to hold grocery item details
    struct GroceryItem {
        uint256 id;
        string name;
        uint256 price;
        address payable owner;
        bool forSale;
    }

    // Mapping from item ID to GroceryItem details
    mapping(uint256 => GroceryItem) public groceryItems;
    // Total count of grocery items
    uint256 public itemCount;

    // Event emitted when a grocery item is listed for sale
    event ItemListed(uint256 id, string name, uint256 price);
    // Event emitted when a grocery item is sold
    event ItemSold(uint256 id, address newOwner);
    // Event emitted when a grocery item is removed from sale
    event ItemRemoved(uint256 id);

    // Constructor to initialize the contract owner
    constructor() {
        owner = msg.sender;
        itemCount = 0;
    }

    // Function to list a new grocery item for sale
    function listItem(string memory _name, uint256 _price) public {
        // Increment the item count
        itemCount++;
        // Create a new grocery item and add it to the groceryItems mapping
        groceryItems[itemCount] = GroceryItem(itemCount, _name, _price, payable(msg.sender), true);
        // Emit the ItemListed event
        emit ItemListed(itemCount, _name, _price);
    }

    // Function to buy a listed grocery item
    function buyItem(uint256 _id) public payable {
        // Fetch the grocery item from the mapping
        GroceryItem memory item = groceryItems[_id];
        // Ensure the item is for sale
        require(item.forSale, "Item not for sale");
        // Ensure the buyer has sent enough funds
        require(msg.value >= item.price, "Insufficient funds");

        // Transfer the funds to the current owner
        item.owner.transfer(msg.value);
        // Update the item's owner and mark it as not for sale
        groceryItems[_id].owner = payable(msg.sender);
        groceryItems[_id].forSale = false;

        // Emit the ItemSold event
        emit ItemSold(_id, msg.sender);
    }

    // Function to remove a grocery item from sale
    function removeItem(uint256 _id) public {
        // Fetch the grocery item from the mapping
        GroceryItem storage item = groceryItems[_id];
        // Ensure the caller is the owner of the grocery item
        require(msg.sender == item.owner, "Only the owner can remove this item");
        // Mark the item as not for sale
        item.forSale = false;

        // Emit the ItemRemoved event
        emit ItemRemoved(_id);
    }

    // Function to get the details of a grocery item
    function getItemDetails(uint256 _id) public view returns (GroceryItem memory) {
        return groceryItems[_id];
    }
}
