import React, { useContext, useEffect, useState } from "react";
import { withRouter } from "react-router-dom";
import { Dropdown } from "./Dropdown";
import { Form } from "./Form";
import { deleteTodo, getTodos, toggleTodoCompleteStatus } from "./helper";
import { TodoDetailContext } from "./Home";

export const TodoList = withRouter((props) => {
  const [todos, setTodos] = useState({ list: [], error: false });
  const [reload, setReload] = useState(false);
  const { details, setDetails } = useContext(TodoDetailContext);

  // Initial Form values
  const initialValues = {
    title: "",
    description: "",
    priority: "0",
    deadline: "null",
  };

  const getTodosList = async () => {
    let result = await getTodos();
    if (result !== 0) {
      setTodos({ list: result, error: false });
    } else {
      setTodos({ ...todos, error: true });
      console.log("Fetch Failed");
    }
  };

  const handleDelete = async (id) => {
    let result = await deleteTodo(id);
    console.log(result);
    if (result !== 0) {
      setReload(!reload);
    }
  };

  const handleTodoStatus = async (data) => {
    data.is_completed = !data.is_completed;
    let result = await toggleTodoCompleteStatus(data);
    if (result !== 0) {
      setReload(!reload);
    }
  };

  const goToDetail = (data) => {
    setDetails({
      id: data.id,
      title: data.title,
      description: data.description,
      is_completed: data.is_completed,
      deadline: data.deadline,
      priority: data.priority,
    });
    props.history.push("/info");
  };

  useEffect(() => {
    getTodosList();
  }, [reload]);

  return (
    <div>
      <h1>All Todos</h1>

      <Form
        initialValues={initialValues}
        reload={reload}
        setReload={setReload}
      />

      {!todos.error ? (
        <div>
          {todos.list.map((todo, index) => (
            <div
              key={index}
              style={{ color: todo.is_completed ? "gray" : "black" }}
            >
              <h3>{todo.title}</h3>
              <p>{todo.description}</p>
              <h4>{todo.priority}</h4>

              <Dropdown data={todo} reload={reload} setReload={setReload} />

              <button onClick={() => handleTodoStatus(todo)}>
                {todo.is_completed ? <span>✅</span> : <span>❌</span>}
              </button>
              <button onClick={() => handleDelete(todo.id)}>Delete</button>

              <button onClick={() => goToDetail(todo)}>🖋 Edit</button>
            </div>
          ))}
        </div>
      ) : (
        <h3>Didn't received data</h3>
      )}
    </div>
  );
});
