// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SchoolRegistration {
    // Structure to represent a student
    struct Student {
        string name;
        uint score;
        bool isRegistered;
    }

    address public owner;
    uint public totalStudents;
    uint public maxStudents;

    mapping(address => Student) public students;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor(uint _maxStudents) {
        owner = msg.sender;
        maxStudents = _maxStudents;
    }

    // Register a student in the course
    function registerStudent(address _studentAddress, string memory _name) public onlyOwner {
        require(!students[_studentAddress].isRegistered, "Student is already registered");
        require(bytes(_name).length > 0, "Invalid student name");

        // Check if total students exceed max allowed students
        require(totalStudents < maxStudents, "Max students reached, cannot register more");

        students[_studentAddress] = Student({
            name: _name,
            score: 0, // Default score to 0
            isRegistered: true
        });

        totalStudents += 1;
    }

    // Set score for a registered student
    function setScore(address _studentAddress, uint _score) public onlyOwner {
        Student storage student = students[_studentAddress];

        require(student.isRegistered, "Student is not registered");
        require(_score >= 0 && _score <= 100, "Score must be between 0 and 100");

        student.score = _score;
    }

    // Get student details
    function getStudentDetails(address _studentAddress) public view returns (string memory name, uint score) {
        Student storage student = students[_studentAddress];
        require(student.isRegistered, "Student is not registered");
        return (student.name, student.score);
    }

    // Critical invariant check using assert to ensure maxStudents is never exceeded
    function checkInvariant() public view {
        // Ensure that the number of students does not exceed the maximum allowed students
        assert(totalStudents <= maxStudents);
    }

    // A function to deregister a student, demonstrating the use of revert
    function deregisterStudent(address _studentAddress) public onlyOwner {
        Student storage student = students[_studentAddress];

        if (!student.isRegistered) {
            revert("Cannot deregister a student who is not registered");
        }

        // Deregister the student
        student.isRegistered = false;
        totalStudents -= 1;
    }
}
