# Pycharm

- enable the 80 column guideline: Settings -> Search: right margin -> 
  Visual Guides at 80. This is a good rule of thumb when programming
  or writing documentation as 
    - screen real estate is always a problem for some people.
    - it is good indication of code complexity (lookup code complexity
      metrics)
      
- Use `.ideavimrc` provided through this project.

- Editor -> General -> Soft-Wraps -> Soft-Wrap these files: `.md, ...`
  When writing more complex documentation there is almost no way around soft wrapping because of the simple problem of extending text that is hard-wrapped (except it is hard-wrapped automatically).

- Under Windows:
  - Keymap: Stay at Windows Keymap (even though IntelliJ IDEA Classic (macOS) is also interesting)
    - Keymap: New... -> Ctrl+N
    - Keymap: Generate... -> Ctrl+N
    - Keymap: Tool Windows -> Project: Ctrl+1   (to mimick: Cmd+1 behaviour)