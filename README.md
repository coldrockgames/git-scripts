![coldrock-banner-itch-960x110](https://github.com/user-attachments/assets/2b8c07be-5c83-4f21-9b38-6df178758918)

# ![git32](https://github.com/user-attachments/assets/e57eef6d-49d1-430f-8f62-5818384f7d28) git-scripts
A set of scripts to make git-life easier.

These are the scripts we use internally at _coldrock.games_. The repository is public to allow my students and course participants to gain access to them.
Feel free to give them a shot; they solve almost all git-related tasks with ease.

There's also a `pdf` cheatsheet available with a short help for each of the available scripts here.

### Have a question before you start? Head over to the [Discussions](https://github.com/coldrockgames/git-scripts/discussions)!

> [!CAUTION]
> **DISCLAIMER**\
> As these scripts perform _writing_ operations on your repositories, there _is a chance_ that you may damage your repository or codebase if they are used incorrectly.
> Therefore, we want to state clearly that we are in no way responsible, either directly or indirectly, for any damage that occurs to your repository, codebase, or computer when using the scripts.
> Our internal members are well-trained with the scripts, and we all use them with great success, but of course, the same risks exist as with GUI clients for Git. If you use them incorrectly, you may damage your data.

# Setting up your scripts
After cloning the repository, simply double-click the `install-scripts.cmd` file and follow the instructions on-screen.

This script will create a shortcut on your desktop, pre-configured for your working folder, with all PATH variables set (temporarily, only in this script. It will _not_ modify any of your system configurations!).

This is your main shell for working with the scripts. If you’re familiar with the .NET world, you may find this similar to the _Visual Studio Developer Command Prompt_, which is set up when you install Visual Studio.

At the end of the script, you will be asked, whether you want to set up your identities now. Read on...

# Setting up git clone identities
If you answered the question from the installer with `y` (which you should), you will be redirected to the `identity.cmd` script.

> [!TIP]
> A clone identity does **NOT** require your password—there is nothing creepy going on!\
> It simply creates a pre-configured `cloneXY` script for you, which holds the base URL for
> the git provider (like github or bitbucket).\
> These URLs mostly contain your username, which is why the script asks for it.

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
> You may start the identity script at any time!\
> You are not tied to the installer script for your identities.\
> Just run `identity` from a script prompt to create a new one!
