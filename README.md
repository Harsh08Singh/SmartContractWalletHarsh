
# Smart Contract Wallet

## Overview

This Smart Contract Wallet is designed to provide enhanced security features and flexibility for managing funds and permissions on the Ethereum blockchain. It consists of two main contracts: `SmartContractWallet` and `Consumer`.

### SmartContractWallet Contract

#### Features:

1. **Owner Management:**
   - The contract allows the assignment of an owner during deployment (`constructor` function). The owner has the highest level of control over the contract.

2. **Guardians:**
   - Guardians can be set by the owner using the `setGuardian` function. Guardians have certain privileges, such as participating in the process of proposing a new owner.

3. **Proposed Ownership Transfer:**
   - The contract allows for a proposed ownership transfer initiated by guardians. A specified number of guardian confirmations (`confirmationsFromGuardianForReset`) is required to complete the ownership transfer.

4. **Allowance Management:**
   - The owner can set allowances for specific addresses using the `setAllowance` function. This allows fine-grained control over who is permitted to send funds and the amount they can send.

5. **Dynamic Permission System:**
   - Addresses can be dynamically allowed or disallowed to send funds using the `isAllowedToSend` mapping.

6. **Flexible Transfer Function:**
   - The `transfer` function enables the transfer of funds to a specified address. It includes security checks based on allowances and permissions.

7. **Fallback Function:**
   - The contract includes a `receive` function to accept incoming Ether transactions.

### Consumer Contract

#### Features:

1. **Balance Inquiry:**
   - The `Consumer` contract provides a function (`getBalance`) for checking the balance of the contract.

2. **Deposit Function:**
   - The `deposit` function allows the contract to receive Ether deposits.

## Security Considerations

1. **Access Control:**
   - The contract uses access control mechanisms to ensure that only the owner or designated guardians have certain privileges.

2. **Ownership Transfer Safeguards:**
   - The proposed ownership transfer requires multiple guardian confirmations to prevent unauthorized changes.

3. **Allowance and Permission System:**
   - The contract implements a flexible allowance and permission system, enabling the owner to control fund transfers effectively.

4. **Security Checks:**
   - The `transfer` function includes checks to ensure that the sender has the necessary permissions and allowances.

## Usage

1. **Deploy the Contract:**
   - Deploy the `SmartContractWallet` contract to the Ethereum blockchain, setting the initial owner during deployment.

2. **Owner and Guardian Actions:**
   - The owner can set guardians, propose ownership transfers, and manage allowances using the provided functions.

3. **Transfer Funds:**
   - Use the `transfer` function to send funds to a specified address, considering allowances and permissions.

4. **Balance Inquiry:**
   - Utilize the `getBalance` function in the `Consumer` contract to check the balance.

## Important Notes

- Ensure proper management of guardians to maintain the security of the ownership transfer process.
- Carefully manage allowances and permissions to control fund transfers.

