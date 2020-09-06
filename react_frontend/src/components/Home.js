import React, { createContext, useState } from "react";
import { BrowserRouter as Router, Route } from "react-router-dom";
import { Detail } from "./Detail";
import { TodoList } from "./TodoList";

export const TodoDetailContext = createContext(null);

export const Home = () => {
  const initialState = {
    id: null,
    title: "",
    description: "",
    is_completed: null,
    deadline: "null",
    priority: 0,
  };

  const [details, setDetails] = useState(initialState);

  return (
    <div>
      <Router>
        <TodoDetailContext.Provider value={{ details, setDetails }}>
          <Route path="/" exact component={TodoList} />
          <Route path="/info" exact component={Detail} />
        </TodoDetailContext.Provider>
      </Router>
    </div>
  );
};
