Pushing local Project to Github 
============================
*  TOC
    * [Purpose](#purpose)
    * [Step 1](#step1)



###Purpose
One way to create a new project in Github is to first create a repository, clone it in the local system and then
to copy project files there and commit and push it.
But sometimes you already have a project folder, and the above steps seems too much work,so what do we do?


###Step1 Initialize Project as a Git repository###
>git init 


###Step 2 Add files in your new local repository. This stages them for first commit
>git add .


###Step 3 Commit the files that you've staged in local repository
>git commit -m "First commit"


###Step4 Create a new github repository
>Goto github.com and create a new repository. Do avoid errors, do not Initialize the repository with a readme, license etc
Now copy the remote repository url

###Step 5 Add remote remote URL
>In command prompt, add the URL for the remote repository where your local repository will be pushed</br>
>$ git remote add origin *remote repository url* <br/>
>$ git remote set-url *remote repository url * //for windows <br/>
>//verify the new remote URL<br/>
git remote -v

###Step 6 Push changes
>$git push origin master
