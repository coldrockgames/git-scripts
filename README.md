![coldrock-banner-itch-960x110](https://github.com/user-attachments/assets/2b8c07be-5c83-4f21-9b38-6df178758918)

# ![git32](https://github.com/user-attachments/assets/e57eef6d-49d1-430f-8f62-5818384f7d28) git-scripts
A set of scripts to make git-life easier.

These are the scripts we use internally at _coldrock.games_. The repository is public to allow my students and course participants to gain access to them.
Feel free to give them a shot; they solve almost all git-related tasks with ease.

There's also a `pdf` cheatsheet available with a short help for each of the available scripts here.

### Got a question before you start? Head over to the [Discussions](https://github.com/coldrockgames/git-scripts/discussions)!

> [!CAUTION]
> **DISCLAIMER**\
> These scripts perform _write_ operations on your repositories, which means there's a risk of damaging your repository or codebase if they're used incorrectly.
> We want to make it clear that we are not responsible, directly or indirectly, for any damage to your repository, codebase, or computer resulting from the use of these scripts.
> Our internal team is well-trained in using these scripts, and we’ve had great success with them, but the same risks apply as with any Git GUI client.
> Incorrect use may lead to data loss.

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
> These URLs typically include your username, which is why the script asks for it.

To create a clone identity, the script needs some information from you:
* A shortname of the identity (like `gh` for _github_ or `bb` for _bitbucket_)
* The provider (currently github and bitbucket are supported)

Then, depending on the provider, some or all of these informations are required:
* The main branch name (github uses `main`, while bitbucket still uses `master`, depending on your bitbucket configuration)
* Your user name (which is part of the clone URL)
* Your workspace name (bitbucket only)

## Location of the identity scripts
Your clone scripts will be created in your _local app_data folder_ in `coldrock.games.git-identities`. For example, here is a screenshot of my identities folder. I use three identities: Bitbucket, GitHub personal and the Coldrock organization.

![image](https://github.com/user-attachments/assets/7cbbc56c-db0d-4a34-b344-06d8589427b4)


> [!NOTE]
> You may start the identity script at any time!\
> You are not tied to the installer script for your identities.\
> Just run `identity` from a script prompt to create a new one!
