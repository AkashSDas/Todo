import React, { useContext } from "react";
import { Link } from "react-router-dom";
import { Form } from "./Form";
import { TodoDetailContext } from "./Home";

export const Detail = () => {
  const { details, setDetails } = useContext(TodoDetailContext);

  return (
    <div>
      <h1>Todo Detail</h1>

      <Link to="/">Home</Link>

      <Form initialValues={details} isDetail={true} />
    </div>
  );
};
