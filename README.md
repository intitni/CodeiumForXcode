# Codeium for Xcode <img alt="Logo" src="/AppIcon.png" align="right" height="50">

Codeium for Xcode is a fork of [Copilot for Xcode](https://github.com/intitni/CopilotForXcode.git) that exposes the features supported by Codeium.

If you have any trouble using the app, please open an issue at [https://github.com/intitni/CopilotForXcode/issues](https://github.com/intitni/CopilotForXcode/issues).

<a href="https://www.buymeacoffee.com/intitni" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

## Features

- Code Suggestions.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Permissions Required](#permissions-required)
- [Installation and Setup](#installation-and-setup)
  - [Install](#install)
  - [Enable the Extension](#enable-the-extension)
  - [Setting Up Codeium](#setting-up-codeium)
  - [Granting Permissions to the App](#granting-permissions-to-the-app)
- [Update](#update)
- [Feature](#feature)
- [Key Bindings](#key-bindings)
- [Limitations](#limitations)
- [License](#license)

For frequently asked questions, check [FAQ](https://github.com/intitni/CopilotForXcode/issues/65).

For development instruction, check [Development.md](DEVELOPMENT.md).

## Prerequisites

- Public network connection.
- Active Codeium account.

## Permissions Required

- Folder Access
- Accessibility API

> If you are concerned about key logging and cannot trust the binary, we recommend examining the code and [building it yourself](DEVELOPMENT.md). To address any concerns, you can specifically search for `CGEvent.tapCreate`, `AXObserver`, `AX___` within the code.

## Installation and Setup

### Install

You can install it manually, by downloading the `Codeium for Xcode.app` from the latest [release](https://github.com/intitni/CodeiumForXcode/releases), and extract it to the Applications folder.

Open the app, the app will create a launch agent to setup a background running Service that does the real job.

### Enable the Extension

Enable the extension in `System Settings.app`.

From the Apple menu located in the top-left corner of your screen click `System Settings`. Navigate to `Privacy & Security` then toward the bottom click `Extensions`. Click `Xcode Source Editor` and tick `Copilot`.

If you are using macOS Monterey, enter the `Extensions` menu in `System Preferences.app` with its dedicated icon.

### Granting Permissions to the App

The first time the app is open and command run, the extension will ask for the necessary permissions.

Alternatively, you may manually grant the required permissions by navigating to the `Privacy & Security` tab in the `System Settings.app`.

- To grant permissions for the Accessibility API, click `Accessibility`, and drag `CopilotForXcodeExtensionService.app` to the list. You can locate the extension app by clicking `Reveal Extension App in Finder` in the host app.

<img alt="Accessibility API" src="/accessibility_api_permission.png" width="500px">

If you encounter an alert requesting permission that you have previously granted, please remove the permission from the list and add it again to re-grant the necessary permissions.

### Setting Up GitHub Copilot

1. In the host app, switch to the service tab and click on GitHub Copilot to access your GitHub Copilot account settings.
2. Click "Install" to install the language server.
3. Optionally setup the path to Node. The default value is just `node`, Copilot for Xcode.app will try to find the Node from the PATH available in a login shell. If your Node is installed somewhere else, you can run `which node` from terminal to get the path.
4. Click "Sign In", and you will be directed to a verification website provided by GitHub, and a user code will be pasted into your clipboard.
5. After signing in, go back to the app and click "Confirm Sign-in" to finish.
6. Go to "Feature - Suggestion" and update the feature provider to "GitHub Copilot".

The installed language server is located at `~/Library/Application Support/com.intii.CopilotForXcode/GitHub Copilot/executable/`.

### Setting Up Codeium

1. In the host app, switch to the service tab and click Codeium to access the Codeium account settings.
2. Click "Install" to install the language server.
3. Click "Sign In", and you will be directed to codeium.com. After signing in, a token will be presented. You will need to paste the token back to the app to finish signing in.
4. Go to "Feature - Suggestion" and update the feature provider to "Codeium".

> The key is stored in the keychain. When the helper app tries to access the key for the first time, it will prompt you to enter the password to access the keychain. Please select "Always Allow" to let the helper app access the key.

The installed language server is located at `~/Library/Application Support/com.intii.CodeiumForXcode/Codeium/executable/`.

### Managing `CopilotForXcodeExtensionService.app`

This app runs whenever you open `Codeium for Xcode.app` or `Xcode.app`. You can quit it with its menu bar item that looks like a steering wheel.

You can also set it to quit automatically when the above 2 apps are closed.

## Update

You can use the in-app updater or download the latest version manually from the latest [release](https://github.com/intitni/CodeiumForXcode/releases).  

After updating, please restart Xcode to allow the extension to reload.

If you find that some of the features are no longer working, please first try regranting permissions to the app.

## Feature

### Suggestion

The app can provide real-time code suggestions based on the files you have opened. 

The feature provides two presentation modes:
- Nearby Text Cursor: This mode shows suggestions based on the position of the text cursor.
- Floating Widget: This mode shows suggestions next to the circular widget.

When using the "Nearby Text Cursor" mode, it is recommended to set the real-time suggestion debounce to 0.1.

If you're working on a company project and don't want the suggestion feature to be triggered, you can globally disable it and choose to enable it only for specific projects.

Whenever your code is updated, the app will automatically fetch suggestions for you, you can cancel this by pressing **Escape**.

\*: If a file is already open before the helper app launches, you will need to switch to those files in order to send the open file notification.

#### Commands

- Get Suggestions: Get suggestions for the editing file at the current cursor position.
- Next Suggestion: If there is more than one suggestion, switch to the next one.
- Previous Suggestion: If there is more than one suggestion, switch to the previous one.
- Accept Suggestion: Add the suggestion to the code.
- Reject Suggestion: Remove the suggestion comments.
- Prefetch Suggestions: Call only by Codeium for Xcode. In the background, Codeium for Xcode will occasionally run this command to prefetch real-time suggestions.
- Real-time Suggestions: Call only by Codeium for Xcode. When suggestions are successfully fetched, Copilot for Xcode will run this command to present the suggestions.

For Open Chat and Custom Chat commands, you can use the following template arguments:

| Argument                      | Description                                    |
| ----------------------------- | ---------------------------------------------- |
| `{{selected_code}}`           | The currently selected code in the editor.     |
| `{{active_editor_language}}`  | The programming language of the active editor. |
| `{{active_editor_file_url}}`  | The URL of the active file in the editor.      |
| `{{active_editor_file_name}}` | The name of the active file in the editor.     |

## Key Bindings

It looks like there is no way to add default key bindings to commands, but you can set them up in `Xcode settings > Key Bindings`. You can filter the list by typing `codeium` in the search bar.

A [recommended setup](https://github.com/intitni/CopilotForXcode/issues/14) that should cause no conflict is

| Command | Key Binding |
| --- | --- |
| Get Suggestions | `⌥?` |
| Accept Suggestions | `⌥}` |
| Reject Suggestion | `⌥{` |
| Next Suggestion | `⌥>` |
| Previous Suggestion | `⌥<` |

Essentially using `⌥⇧` as the "access" key combination for all bindings.

Another convenient method to access commands is by using the `⇧⌘/` shortcut to search for a command in the menu bar.

## Limitations

- The extension uses some dirty tricks to get the file and project/workspace paths. It may fail, it may be incorrect, especially when you have multiple Xcode windows running, and maybe even worse when they are in different displays. I am not sure about that though.

## License

Please check [LICENSE](LICENSE) for details.

