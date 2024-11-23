# **Setting an Alias in Fish Shell**

To set `npm` as an alias for `pnpm` in the `fish` shell on macOS, you can define a function or alias in your `fish` configuration file. Here’s how you can do it:

---

### **1. Create a Fish Function**
Fish uses functions for aliases that involve arguments.

1. Open or create your `config.fish` file:
   ```bash
   nano ~/.config/fish/config.fish
   ```

2. Add the following function to create an alias for `npm`:
   ```fish
   function npm
       pnpm $argv
   end
   ```

   - `$argv` passes all arguments from `npm` to `pnpm`.

3. Save and exit the file (Ctrl + O, then Enter, followed by Ctrl + X).

4. Reload your Fish configuration:
   ```bash
   source ~/.config/fish/config.fish
   ```

---

### **2. Test the Alias**
Run a command like this to test:
```bash
npm install express
```

This should execute `pnpm install express` instead.

---

### **3. Optional: Add a Warning (if needed)**
If you want to show a message every time `npm` is used, modify the function:
```fish
function npm
    echo "Warning: 'npm' is aliased to 'pnpm'."
    pnpm $argv
end
```

---

### **4. Verify the Alias**
To ensure the alias is working, check the output of:
```bash
type npm
```

It should display:
```
npm is a function with definition
function npm
    pnpm $argv
end
```

---

### **Why Not Use a Simple Alias?**
Fish doesn’t support traditional `alias` syntax for commands with arguments. That’s why defining a `function` is the correct approach for aliasing commands like `npm` to `pnpm`.
