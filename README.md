### School Registration Smart Contract Repository

This repository contains the **SchoolRegistration** smart contract that enables a course administrator to register students, assign scores, and manage student data. The contract is built with **Solidity** and designed to be deployed on the **Ethereum blockchain** using the **Remix** IDE.

---

#### Files in This Repository

- **SchoolRegistration.sol** - The smart contract source code.
- **README.md** - Instructions on using the contract and deploying it on Remix.

---

### Contract Overview

The **SchoolRegistration** contract allows an owner (typically the course administrator) to:
- Register students in a course.
- Set scores for registered students.
- Retrieve student details.
- Deregister students.
- Check the invariant to ensure that the number of registered students does not exceed the specified limit.

#### Key Components

- **Struct: Student**  
  A structure that stores details about each student:
  - `name`: The name of the student.
  - `score`: The student's score (default is `0` upon registration).
  - `isRegistered`: A boolean flag indicating if the student is currently registered.

- **Variables**:
  - `owner`: The address of the contract owner.
  - `totalStudents`: Tracks the total number of registered students.
  - `maxStudents`: The maximum number of students that can be registered.

- **Mappings**:
  - `students`: Maps an Ethereum address to a `Student` struct, storing information about each registered student.

- **Modifiers**:
  - `onlyOwner`: Ensures that only the owner of the contract can perform certain actions.

---

### Functions

1. **Constructor**:  
   Initializes the contract with the maximum number of students allowed and sets the deployer as the owner.
   ```solidity
   constructor(uint _maxStudents) {
       owner = msg.sender;
       maxStudents = _maxStudents;
   }
   ```

2. **registerStudent**:  
   Registers a new student by adding their address and name to the `students` mapping. Increments `totalStudents` by 1.
   - Requires that the student is not already registered.
   - Requires that the student's name is not empty.
   - Ensures that the total number of students does not exceed `maxStudents`.
   ```solidity
   function registerStudent(address _studentAddress, string memory _name) public onlyOwner {
       require(!students[_studentAddress].isRegistered, "Student is already registered");
       require(bytes(_name).length > 0, "Invalid student name");
       require(totalStudents < maxStudents, "Max students reached, cannot register more");

       students[_studentAddress] = Student({ name: _name, score: 0, isRegistered: true });
       totalStudents += 1;
   }
   ```

3. **setScore**:  
   Sets the score for a registered student. The score must be between `0` and `100`.
   - Requires that the student is registered.
   - Requires that the score is within a valid range.
   ```solidity
   function setScore(address _studentAddress, uint _score) public onlyOwner {
       Student storage student = students[_studentAddress];
       require(student.isRegistered, "Student is not registered");
       require(_score >= 0 && _score <= 100, "Score must be between 0 and 100");

       student.score = _score;
   }
   ```

4. **getStudentDetails**:  
   Retrieves the name and score of a registered student.
   - Requires that the student is registered.
   ```solidity
   function getStudentDetails(address _studentAddress) public view returns (string memory name, uint score) {
       Student storage student = students[_studentAddress];
       require(student.isRegistered, "Student is not registered");
       return (student.name, student.score);
   }
   ```

5. **checkInvariant**:  
   Checks that the total number of registered students does not exceed the `maxStudents` limit.
   - Uses `assert` to verify the condition.
   ```solidity
   function checkInvariant() public view {
       assert(totalStudents <= maxStudents);
   }
   ```

6. **deregisterStudent**:  
   Deregisters a student, removing them from the course.
   - Reverts if the student is not registered.
   - Decrements `totalStudents` by 1.
   ```solidity
   function deregisterStudent(address _studentAddress) public onlyOwner {
       Student storage student = students[_studentAddress];
       if (!student.isRegistered) {
           revert("Cannot deregister a student who is not registered");
       }

       student.isRegistered = false;
       totalStudents -= 1;
   }
   ```

---

### Deployment Instructions

1. **Setup Remix IDE**:
   - Visit [Remix Ethereum IDE](https://remix.ethereum.org/).
   - Create a new file named `SchoolRegistration.sol` in the file explorer.

2. **Copy and Paste Code**:
   - Copy the code from the `SchoolRegistration.sol` file and paste it into the editor in Remix.

3. **Compile the Contract**:
   - Go to the **Solidity Compiler** tab in Remix.
   - Select the appropriate Solidity version (at least `0.8.0`).
   - Click on **Compile SchoolRegistration.sol**.

4. **Deploy the Contract**:
   - Go to the **Deploy & Run Transactions** tab.
   - Select your preferred environment (e.g., JavaScript VM, Injected Web3).
   - Enter the `_maxStudents` parameter (e.g., `50`) for the constructor.
   - Click **Deploy**.
   - Once deployed, the contract will appear under **Deployed Contracts**.

5. **Interact with the Contract**:
   - Use the **Deployed Contracts** section to call functions like `registerStudent`, `setScore`, `getStudentDetails`, `deregisterStudent`, and `checkInvariant`.
   - Ensure to input correct values for parameters and review the results in the **Remix Console**.

---

### Prerequisites

- **Solidity**: Version `0.8.0` or above.
- **Remix IDE**: For deploying and testing the contract.
- **MetaMask**: If deploying on a test network like Ropsten, Goerli, or Sepolia.

### License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

Feel free to explore the functionality of the **SchoolRegistration** contract and extend it as needed! This contract is a basic example, suitable for learning and educational purposes in understanding Solidity and smart contract deployment using Remix.
