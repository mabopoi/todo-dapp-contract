const ToDoApp = artifacts.require('ToDoApp');

require('chai').use(require('chai-as-promised')).should();

contract('ToDoApp', (accounts) => {
  let toDoContract;

  before(async () => {
    toDoContract = await ToDoApp.new();
    await toDoContract.createTask('title test', 'description test');
  });

  describe('Creating a task', () => {
    it('should insert a new task properly', async () => {
      const counter = await toDoContract.counter();
      assert.equal(counter, 1);
    });

    it('should return the right task, given the id 0', async () => {
      const task = await toDoContract.idToTask(0);
      assert.equal(task.title, 'title test');
      assert.equal(task.description, 'description test');
    });

    it('should return our tasks, given the address', async () => {
      const tasks = await toDoContract.getMyTasks();
      assert.equal(tasks.length, 1);
      const firstTask = tasks[0];
      assert.equal(firstTask.title, 'title test');
      assert.equal(firstTask.description, 'description test');
    });
  });

  describe('Updating and deleting a task', () => {
    it('should update the task', async () => {
      await toDoContract.updateTask(0, 'updated title', 'updated description');
      const task = await toDoContract.idToTask(0);
      assert.equal(task.title, 'updated title');
      assert.equal(task.description, 'updated description');
    });

    it('should delete the task', async () => {
      await toDoContract.createTask('title test 1', 'description test 1');
      await toDoContract.deleteTask(0);

      const tasks = await toDoContract.getMyTasks();

      //Testing if the task has been deleted properly
      assert.equal(tasks.length, 1);

      //Testing if the task in the array is not the deleted one
      assert.equal(tasks[0].title, 'title test 1');
      assert.equal(tasks[0].description, 'description test 1');
    });
  });
});
