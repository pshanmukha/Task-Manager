const express = require("express");
const router = express.Router();
const {
  getAllTasks,
  getSingleTasks,
  createTask,
  updateTask,
  deleteTask,
} = require("../controllers/tasks");

router.route("/").get(getAllTasks).post(createTask);
router.route("/:id").get(getSingleTasks).patch(updateTask).delete(deleteTask);

module.exports = router;
