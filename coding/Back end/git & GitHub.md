# Setting Up Git and Pushing Code to GitHub

## 1. Initialize a Git Repository
- Open your project folder in **VS Code**.
- Open the terminal (`Ctrl + ~`) and run:
  ```bash
  git init
```

- Add your files to Git:
    
    ```bash
    git add .
    ```
    
- Commit your changes:
    
    ```bash
    git commit -m "Initial commit"
    ```
    

## 2. Create a New Repository on GitHub

- Go to [GitHub](https://github.com) and create a new repository.

## 3. Push Code to GitHub

- Link your local repository to GitHub:
    
    ```bash
    git remote add origin <repository-url>
    ```
    
    Replace `<repository-url>` with the URL you copied from GitHub.
- Push your code to GitHub:
    
    ```bash
    git branch -M main
    git push -u origin main
    ```
