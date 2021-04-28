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
  mapping(address => uint256) deletedTaskAmount;

  modifier onlyTaskOwner(uint256 _id) {
    require(idToTask[_id].author == msg.sender);
    _;
  }

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
    Task[] memory result =
      new Task[](taskAmount[msg.sender] - deletedTaskAmount[msg.sender]);

    for (uint256 i = 0; i < tasks.length; i++) {
      uint256 index = 0;
      if (idToTask[i].author == msg.sender && idToTask[i].active) {
        result[index] = idToTask[i];
        index++;
      }
    }

    return result;
  }

  function deleteTask(uint256 _id) public onlyTaskOwner(_id) {
    idToTask[_id].active = false;
    deletedTaskAmount[msg.sender]++;
  }

  function updateTask(
    uint256 _id,
    string calldata _newTitle,
    string calldata _newDescription
  ) external onlyTaskOwner(_id) {
    idToTask[_id].title = _newTitle;
    idToTask[_id].description = _newDescription;
  }
}
