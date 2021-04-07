const ToDoApp = artifacts.require('ToDoApp');

module.exports = async function (deployer) {
  await deployer.deploy(ToDoApp);
};
