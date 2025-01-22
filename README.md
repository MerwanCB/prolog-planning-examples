# Prolog Planning Examples

This repository contains two Prolog programs that demonstrate planning capabilities using breadth-first search. The programs emphasize logical reasoning and state transitions to achieve specific goals.

## Contents

1. **Riddle Solver (`riddle.pl`)**  
   A solution to the classic farmer, wolf, sheep, and cabbage riddle. The program uses logical axioms to ensure the farmer safely transports all items across the river without violating the constraints of the puzzle.

   - **Query to run the solver:**
     ```prolog
     ?- plan(solve_riddle(S), S).
     ```
   - **Expected Output:**
     A sequence of actions to solve the riddle, such as:
     ```
     S = [cross_with_sheep(e, w), cross_alone(w, e), cross_with_cabbage(e, w), ...]
     ```

2. **Coffee Making Planner (`coffee_making.pl`)**  
   A planner that models the steps needed to make a cup of instant coffee. The program ensures logical transitions between states, like filling the kettle, boiling water, and adding coffee.

   - **Query to run the planner:**
     ```prolog
     ?- plan(make_coffee(S), S).
     ```
   - **Expected Output:**
     A sequence of actions to prepare coffee, such as:
     ```
     S = [add_instant_coffee, pour_hot_water, wait_for_boiling, ...]
     ```

## Features

- **Logical Representation**: State transitions are defined using logical axioms.
- **Breadth-First Search**: Both programs use BFS to explore possible action sequences.
- **Real-World Scenarios**: Practical examples of planning in Prolog.

## How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/MerwanCB/prolog-planning-examples.git
   cd prolog-planning-examples
   ```

2. Load the desired program into a Prolog interpreter, such as SWI-Prolog:
   ```prolog
   ?- [riddle].
   ```

3. Execute the relevant query (see above).

## Requirements

- [SWI-Prolog](https://www.swi-prolog.org/) or another Prolog interpreter.

## Author

Merwan Chaoui

## License

This repository is licensed under the MIT License. Feel free to use, modify, and share the code.

---

Feel free to suggest improvements or report issues.
