async function main() {
  const GroceryStore = await ethers.getContractFactory("GroceryStore");
  const groceryStore = await GroceryStore.deploy();
  await groceryStore.deployed();
  console.log("GroceryStore deployed to:", groceryStore.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
