import React, { useState } from "react";
import { changePriority } from "./helper";

export const Dropdown = (props) => {
  const [drop, setDrop] = useState(false);

  const LOW = 0;
  const MEDIUM = 1;
  const HIGH = 2;

  // 0: Low, 1: Medium, 2: High
  const handlePriorityChange = async (newPriority) => {
    if (newPriority === props.data.priority) {
      return null;
    }
    let result = await changePriority(newPriority, props.data);
    if (result !== 0) {
      props.setReload(!props.reload);
    }
  };

  return (
    <div>
      Change priority
      <button onClick={() => setDrop(!drop)}>🔻</button>
      <div style={{ display: drop ? "inline" : "none" }}>
        <button onClick={() => handlePriorityChange(LOW)}>Low</button>
        <button onClick={() => handlePriorityChange(MEDIUM)}>Medium</button>
        <button onClick={() => handlePriorityChange(HIGH)}>High</button>
      </div>
    </div>
  );
};
