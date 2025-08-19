🔧 1. Setup & Configuration
These commands are used to set up Git and configure user info.

Command	Definition
git config	Sets Git configuration values like username, email, and editor.
git config --global user.name "Your Name"	Sets your name globally for all repositories.
git config --global user.email "you@example.com"	Sets your email globally.
git config --list	Shows current Git configuration.

📂 2. Repository Initialization, Creating & Linking Remote
Start a new repo locally, create a remote one with the GitHub CLI (gh), and link them together.

Command	Definition
git init	Initializes a new Git repository in the current directory.
gh repo create my-project --public --source=. --remote=origin --push
git remote add origin <repo_url>	Links your local repo to the remote. (Usually done by gh)
git push -u origin <branch>	Pushes commits to the remote repo and sets upstream tracking.
git clone <repo_url>	Copies a remote repository locally.

📈 3. Basic Snapshotting
Core commands to record changes in the repository.

Command	Definition
git add <file>	Stages a file for the next commit.
git add .	Stages all changes (new, modified, deleted) in the directory.
git commit -m "message"	Records the staged snapshot with a message.
git commit -a -m is a shortcut that means ✍️ “Automatically stage all tracked files that have been modified, and commit them in one step.”
    Is equivalent to...
    git add -u
    git commit -m "Your message"
git status	Shows the state of the working directory and staging area.
git diff	Shows changes between working directory and staged files.
git ls-files  Shows all the files that are currently tracked by git

🧭 4. Branching & Merging
Commands to manage branches and combine changes.

Command	Definition
git branch	Lists all local branches.
git branch <name>	Creates a new branch.
git checkout <name>	Switches to the specified branch.
git switch <name>	Also switches branches (modern alternative).
git checkout -b <name>	Creates and switches to a new branch.
git merge <branch>	Merges changes from the named branch into the current one.
git rebase <branch>	Reapplies commits on top of another base branch.

🔄 5. Remote Repositories
Work with remote repositories like GitHub.

Command	Definition
git remote -v	Shows URLs of the remote repos.
git remote add origin <url>	Adds a remote repository.
git push origin <branch>	Uploads local commits to the remote repo.
git pull	Fetches and merges changes from the remote repo.
git fetch	Downloads changes but doesn't merge.

🗑️ 6. Undoing Changes
Commands to undo or redo changes.

Command	Definition
git reset <file>	Unstages a file.
git reset --hard <commit>	Resets to a specific commit and discards all changes.
git revert <commit>	Creates a new commit that undoes changes from a previous commit.
git clean -fd	Removes untracked files and directories.

🚫 7. Excluding a File from Tracking After It Has Been Committed
How to stop tracking a file that was already committed (and optionally ignore it going forward).

Command	Definition
git rm --cached <file>	Removes the file from Git’s index (stops tracking) but leaves it in your working directory.
git commit -m "Stop tracking <file>"	Records the removal of the file from tracking.
Add <file> or pattern to .gitignore	Prevents Git from showing this file as untracked in future.

Notes:

**Adding a file to .gitignore does NOT stop tracking if the file is already committed.**

You must git rm --cached it first to untrack it.

After that, Git will ignore the file based on .gitignore.

🕵️ 7. Viewing History
See the project history and inspect changes.

Command	Definition
git log	Shows commit history.
git log --oneline	Shows a simplified commit history.
git show <commit>	Displays detailed info about a specific commit.
git blame <file>	Shows who made each change to a file.

🧪 8. Stashing
Temporarily shelve changes.

Command	Definition
git stash	Saves uncommitted changes temporarily.
git stash pop	Reapplies the most recent stashed changes.
git stash list	Shows all stashed changes.



