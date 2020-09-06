import { API } from "../backend";

export const getTodos = () => {
  return fetch(`${API}todo/`, { method: "GET" })
    .then((response) => response.json())
    .catch((err) => {
      console.log("🌧 Getting Todos Failed", err);
      return 0; // No response
    });
};

export const deleteTodo = (id) => {
  return fetch(`${API}todo/${id}/`, { method: "DELETE" })
    .then((response) => {
      console.log("🌈 Successfully deleted todo", response);
      return 1;
    })
    .catch((err) => {
      console.log("🚫 Delete a todo failed", err);
      return 0;
    });
};

export const toggleTodoCompleteStatus = (data) => {
  const formData = new FormData();
  for (const field in data) {
    if (field === "id") {
      formData.append(field, data.id);
    } else {
      formData.append(field, data[field]);
    }
  }

  return fetch(`${API}todo/${data.id}/`, { method: "PUT", body: formData })
    .then((response) => {
      console.log("⭐ Todo is_completed toggled", response);
      return 1;
    })
    .catch((err) => {
      console.log("👎 Todo cannot be toggled");
      return 0;
    });
};

export const changePriority = (newPriority, data) => {
  data.priority = newPriority;
  const formData = new FormData();
  for (const field in data) {
    formData.append(field, data[field]);
  }

  return fetch(`${API}todo/${data.id}/`, { method: "PUT", body: formData })
    .then((response) => {
      console.log(`💃 Priority changed to ${data.priority}`);
      return 1;
    })
    .catch((err) => {
      console.log("💔 Priority change failed");
      return 0;
    });
};

export const addTodo = (data) => {
  data.priority = parseInt(data.priority);
  const formData = new FormData();
  for (const field in data) {
    formData.append(field, data[field]);
  }

  return fetch(`${API}todo/`, { method: "POST", body: formData })
    .then((response) => {
      console.log("🍺 Added a new Todo");
      return 1;
    })
    .catch((err) => {
      console.log("🍩 Failed to add new Todo");
      return 0;
    });
};
