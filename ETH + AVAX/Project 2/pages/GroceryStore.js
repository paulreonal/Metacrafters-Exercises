import { useState, useEffect } from "react";
import { ethers } from "ethers";
import groceryStore_abi from "../artifacts/contracts/GroceryStore.sol/GroceryStore.json";

export default function GroceryApp() {
  const [ethWallet, setEthWallet] = useState(undefined);
  const [account, setAccount] = useState(undefined);
  const [balance, setBalance] = useState("0");
  const [groceryStore, setGroceryStore] = useState(undefined);
  const [items, setItems] = useState([]);
  const [newItem, setNewItem] = useState({ name: "", price: 0 });

  const contractAddress = "0x1281dDCA636A939743E659B8f030cCd6A18c9919"; // Replace with your new contract address
  const groceryStoreABI = groceryStore_abi.abi;

  const getWallet = async () => {
    if (window.ethereum) {
      setEthWallet(window.ethereum);
    }

    if (ethWallet) {
      const accounts = await ethWallet.request({ method: "eth_accounts" });
      handleAccount(accounts);
    }
  };

  const handleAccount = (accounts) => {
    if (accounts && accounts.length > 0) {
      console.log("Account connected: ", accounts[0]);
      setAccount(accounts[0]);
      getBalance(accounts[0]);
    } else {
      console.log("No account found");
    }
  };

  const getBalance = async (account) => {
    if (ethWallet) {
      const provider = new ethers.providers.Web3Provider(ethWallet);
      const balance = await provider.getBalance(account);
      setBalance(ethers.utils.formatEther(balance));
    }
  };

  const connectAccount = async () => {
    if (!ethWallet) {
      alert("MetaMask wallet is required to connect");
      return;
    }

    const accounts = await ethWallet.request({ method: "eth_requestAccounts" });
    handleAccount(accounts);

    getGroceryStoreContract();
  };

  const getGroceryStoreContract = () => {
    const provider = new ethers.providers.Web3Provider(ethWallet);
    const signer = provider.getSigner();
    const groceryStoreContract = new ethers.Contract(contractAddress, groceryStoreABI, signer);

    setGroceryStore(groceryStoreContract);
  };

  const listItem = async () => {
    if (groceryStore) {
      const { name, price } = newItem;
      try {
        const provider = new ethers.providers.Web3Provider(ethWallet);
        const gasPrice = await provider.getGasPrice();
        const gasEstimate = await groceryStore.estimateGas.listItem(name, ethers.utils.parseEther(price.toString()));
        const tx = await groceryStore.listItem(name, ethers.utils.parseEther(price.toString()), {
          gasLimit: gasEstimate,
          maxFeePerGas: gasPrice.add(gasPrice.div(2)),
          maxPriorityFeePerGas: ethers.utils.parseUnits('2', 'gwei')
        });
        await tx.wait();
        loadItems();
      } catch (error) {
        console.error("Error listing item:", error);
        alert("Error listing item: " + (error.message || error));
      }
    }
  };
  

  const buyItem = async (id, price) => {
    if (groceryStore) {
      try {
        const provider = new ethers.providers.Web3Provider(ethWallet);
        const gasPrice = await provider.getGasPrice();
        const gasEstimate = await groceryStore.estimateGas.buyItem(id, { value: ethers.utils.parseEther(price.toString()) });
        const tx = await groceryStore.buyItem(id, { 
          value: ethers.utils.parseEther(price.toString()),
          gasLimit: gasEstimate,
          maxFeePerGas: gasPrice.add(gasPrice.div(2)),
          maxPriorityFeePerGas: ethers.utils.parseUnits('2', 'gwei')
        });
        await tx.wait();
        loadItems(); // Reload items after buying
        getBalance(account);
      } catch (error) {
        console.error("Error buying item:", error);
        alert("Error buying item: " + (error.message || error));
      }
    }
  };
  
  const removeItem = async (id) => {
    if (groceryStore) {
      try {
        const provider = new ethers.providers.Web3Provider(ethWallet);
        const gasPrice = await provider.getGasPrice();
        const gasEstimate = await groceryStore.estimateGas.removeItem(id);
        const tx = await groceryStore.removeItem(id, {
          gasLimit: gasEstimate,
          maxFeePerGas: gasPrice.add(gasPrice.div(2)),
          maxPriorityFeePerGas: ethers.utils.parseUnits('2', 'gwei')
        });
        await tx.wait();
        loadItems(); // Reload items after removing
      } catch (error) {
        console.error("Error removing item:", error);
        alert("Error removing item: " + (error.message || error));
      }
    }
  };  

  const loadItems = async () => {
    if (groceryStore) {
      try {
        const count = await groceryStore.itemCount();
        let itemsArray = [];
        for (let i = 1; i <= count; i++) {
          const item = await groceryStore.getItemDetails(i);
          itemsArray.push({
            ...item,
            price: ethers.utils.formatEther(item.price), // Convert price to string
            id: item.id.toNumber(), // Convert id to number
            forSale: item.forSale
          });
        }
        setItems(itemsArray);
      } catch (error) {
        console.error("Error loading items:", error);
      }
    }
  };
  

  const initUser = () => {
    if (!ethWallet) {
      return <p>Please install MetaMask to use this application.</p>;
    }
  
    if (!account) {
      return <button onClick={connectAccount}>Connect MetaMask Wallet</button>;
    }
  
    if (items.length === 0) {
      loadItems();
    }
  
    return (
      <div className="app-container">
        <p>Your Account: {account}</p>
        <p>Your Balance: {balance} ETH</p>
        <div className="item-form">
          <h2>List New Grocery Item</h2>
          <input 
            type="text" 
            placeholder="Name" 
            onChange={(e) => setNewItem({ ...newItem, name: e.target.value })} 
          />
          <input 
            type="number" 
            placeholder="Price in ETH" 
            onChange={(e) => setNewItem({ ...newItem, price: parseFloat(e.target.value) })} 
          />
          <button onClick={listItem}>List Grocery Item</button>
        </div>
        <h2>Available Grocery Items</h2>
        <div className="items-list">
          {items.map((item) => (
            <div key={item.id} className="item-card">
              <p>Item ID: {item.id}</p>
              <p>Name: {item.name}</p>
              <p>Price: {item.price} ETH</p>
              <p>Owner: {item.owner}</p>
              {item.forSale && (
                <>
                  <button onClick={() => buyItem(item.id, item.price)}>Buy Item</button>
                  {account.toLowerCase() === item.owner.toLowerCase() && (
                    <button onClick={() => removeItem(item.id)}>Remove Item</button>
                  )}
                </>
              )}
            </div>
          ))}
        </div>
      </div>
    );
  };
  
  useEffect(() => { getWallet(); }, [ethWallet]);
  
  return (
    <main className="container">
      <header>
        <h1>A Decentralized Grocery Store</h1>
      </header>
      {initUser()}
      <style jsx>{`
        .container {
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          min-height: 100vh;
          background-color: #FFD1DC;
          text-align: center;
          padding: 20px;
        }
        .app-container {
          background-color: white;
          padding: 20px;
          border-radius: 10px;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .item-form {
          margin-bottom: 20px;
        }
        .item-form input {
          margin: 5px;
          padding: 10px;
          width: 80%;
          max-width: 300px;
          border: 1px solid #ccc;
          border-radius: 5px;
        }
        .item-form button {
          background-color: #28a745;
          color: white;
          padding: 10px 20px;
          border: none;
          border-radius: 5px;
          cursor: pointer;
          margin-top: 10px;
        }
        .items-list {
          display: flex;
          flex-direction: column;
          align-items: center;
        }
        .item-card {
          background-color: #ffffff;
          border: 1px solid #ccc;
          border-radius: 5px;
          padding: 15px;
          margin: 10px;
          width: 80%;
          max-width: 400px;
          box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .item-card button {
          background-color: #007bff;
          color: white;
          padding: 10px 20px;
          border: none;
          border-radius: 5px;
          cursor: pointer;
          margin-top: 10px;
          margin-right: 5px;
        }
      `}</style>
    </main>
  );
}  