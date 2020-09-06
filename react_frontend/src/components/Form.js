import React, { useState } from "react";
import { withRouter } from "react-router-dom";
import { addTodo, toggleTodoCompleteStatus } from "./helper";

const useForm = (initialValues) => {
  const [values, setValues] = useState(initialValues);

  return [
    values,
    (event) => {
      const isCheckbox = event.target.type === "checkbox";

      setValues({
        ...values,
        [event.target.name]: isCheckbox
          ? event.target.checked
          : event.target.value,
      });
    },
  ];
};

export const Form = withRouter((props) => {
  const [formValues, handleFormChange] = useForm(props.initialValues);

  const handleFormSubmit = (event) => {
    event.preventDefault();

    if (props.reload !== undefined) {
      let result = addTodo(formValues);
      if (result !== 0) {
        props.setReload(!props.reload);
      }
    } else if (props.isDetail) {
      // toggleTodoCompleteStatus is used to Update the Todo fields
      toggleTodoCompleteStatus(formValues);
      props.history.push("/");
    }
  };

  return (
    <div>
      <form onSubmit={handleFormSubmit}>
        <input
          type="text"
          name="title"
          value={formValues.title}
          placeholder="Title"
          onChange={handleFormChange}
        />

        <input
          type="text"
          name="description"
          value={formValues.description}
          placeholder="Description"
          onChange={handleFormChange}
        />

        <select
          name="priority"
          onChange={handleFormChange}
          value={formValues.priority}
        >
          <option value="0">Low</option>
          <option value="1">Medium</option>
          <option value="2">High</option>
        </select>

        <input
          type="datetime-local"
          name="deadline"
          value={formValues.deadline}
          onChange={handleFormChange}
        />

        <button type="submit">Submit</button>
      </form>
    </div>
  );
});
