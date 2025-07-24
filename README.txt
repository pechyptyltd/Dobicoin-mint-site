# DobieCoin NFT - Hardhat Project

## 👣 Step-by-Step (No Jargon) Deployment

1. Install [Node.js](https://nodejs.org/) if you haven’t already.
2. Open your terminal (Command Prompt or Terminal app).
3. Run these commands one by one:

```
npm install -g hardhat
cd DobieCoin-Hardhat
npm install
```

4. Replace `YOUR_PRIVATE_KEY` in `hardhat.config.js` with your wallet’s private key.
   - Use a test wallet first on BNB Testnet!

5. Replace `"ipfs://YOUR_PLACEHOLDER_URI/"` in `deploy.js` with your actual image URI.

6. Deploy the contract to BNB Testnet:
```
npx hardhat run scripts/deploy.js --network bscTestnet
```

7. Once it works on Testnet, switch the network config to Mainnet and deploy again.

---

Need help? Just ask ChatGPT!
