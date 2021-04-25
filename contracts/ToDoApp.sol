// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ToDoApp {
  uint256 public counter = 0;

  struct Task {
    address author;
    string title;
    string description;
    bool active;
  }

  Task[] public tasks;

  mapping(uint256 => Task) public idToTask;
  mapping(address => uint256) taskAmount;

  function createTask(string calldata _title, string calldata _description)
    external
  {
    Task memory newTask = Task(msg.sender, _title, _description, true);
    tasks.push(newTask);
    idToTask[counter] = newTask;
    taskAmount[msg.sender]++;
    counter++;
  }

  function getMyTasks() external view returns (Task[] memory) {
    Task[] memory result = new Task[](taskAmount[msg.sender]);

    for (uint256 i = 0; i < tasks.length; i++) {
      uint256 index = 0;
      if (idToTask[i].author == msg.sender) {
        result[index] = idToTask[i];
        index++;
      }
    }

    return result;
  }
}
