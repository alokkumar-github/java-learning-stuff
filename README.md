# java-learning-stuff


# git and Github  learning.............
----------------------------------------------------------------------------------------------------------------------------------------
git status
git add file.txt
git status
git commit -m "some msg"
git log -1

git difftool HEAD


1. undo uncommited change

git checkout --

2. undo commited change

git log

// this will revert and commit the change
git revert <hash code>

// this will revert. and you have to explicitly commit the change
git revert -n <hash code>


// reseting change ; this will reset to till that history or commit id or hash code and beyond that you will lose further history commit

git reset --hard <commit id or hash code you got using git log>

// what is HEAD ; it is the reference to most recent commit in current branch (in most of the cases).   pointer of the most recent commit; HEAD~n ..... HEAD~2 HEAD~1 HEAD

git show HEAD

git show <commit id or hash code>

so we can say HEAD is just short form of writing this commit.<commit id>
 
git difftool HEAD~2 HEAD~1
//or 
git difftool <privious commit id> <current commit id>

git branch
git checkout master or<any branch> // see the .git folder for HEAD file ( ref: refs/heads/master )


//// .gitignore

git status
touch .gitignore  // it create file and you simply add the file/folder/direcory that you want to ignore or not want to view when we do git status
git  status

// Diff and Merge using meld tool

// what is pull request.


refrences ::::::::::::::::::::::::::::::::::::::
---------------------------------------------------------
https://www.youtube.com/playlist?list=PLeo1K3hjS3usJuxZZUBdjAcilgfQHkRzW



 
 
 
