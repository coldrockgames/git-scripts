# ![git32](https://github.com/user-attachments/assets/e57eef6d-49d1-430f-8f62-5818384f7d28) git-scripts
A set of scripts to make git-life easier.

These are the scripts we use internally at _coldrock.games_. The repository is public to allow my students and course participants to gain access to them.
Feel free to give them a shot, they solve almost all git related tasks with ease.

There's also a `pdf` cheatsheet available with a short help for each of the available scripts here.

> [!CAUTION]
> **DISCLAIMER**\
> As it's the nature of these scripts to perform _writing_ operations on your repositories, there _is a chance_, that you damage your repository/code base when using them wrong.
> Therefore we want to state clearly, that we are in no way responsible, neither directly nor indirectly, for any damage that occurs to your repository or codebase or computer when using the scripts.
> Our internal members are well trained with the scripts and we all use them with great success, but of course, here's the same danger alive, that also comes with GUI clients for Git. If you use them wrong, you may damage your data.

# Setting up your scripts
After cloning the repository, simply double-click the `install-scripts.cmd` file and follow the instructions on screen.

This script will create a shortcut on your desktop, pre-configured for your working folder, with all PATH variables set (temporarily, only in this script - it will _not_ modify any of your system configurations!).

This is your main shell for working with the scripts. If you know the .net world, you may find this similar to the _Visual Studio Developer Command Prompt_, which gets set up, when you install Visual Studio.

At the end of the script, you will be asked, whether you want to setup your identities now. Read on...

# Setting up git clone identities
If you answered the question from the installer with `y` (what you should), you get redirected to the `identity.cmd` script.

> [!TIP]
> A clone identity does **NOT** require your password, there is nothing creepy going on!\
> It just creates a pre-configured `cloneXY` script for you, which holds the base URL for
> the git provider (like github or bitbucket).\
> Those urls mostly contain your username, that's why the script asks for it.

To create a clone identity, the script needs some information from you:
* A shortname of the identity (like `gh` for _github_ or `bb` for _bitbucket_)
* The provider (currently github and bitbucket are supported)

Then, depending on the provider, some or all of these informations are required:
* The main branch name (github uses `main`, while bitbucket still uses `master`, depending on your bitbucket configuration)
* Your user name (is part of the clone-url)
* Your workspace name (bitbucket only)

## Location of the identity scripts
Your clone scripts will be created in your _local app_data folder_ in `coldrock.games.git-identities`. As an example, here is the screenshot of my identities folder. I use three identities, bitbucket, github personal and the coldrock organization.

![image](https://github.com/user-attachments/assets/7cbbc56c-db0d-4a34-b344-06d8589427b4)


> [!NOTE]
> You may start the identity script any time!\
> It just creates a new pre-configured clone script to clone from a git provider (like github or bitbucket) without caring about user, organization or workspace names.\
> THESE SCRIPTS DO NOT STORE YOUR PASSWORD! No security-topics here!\
> They use whatever you have configured in your git-config for authentication and authorization. It's just simple .cmd scripts.
