# nirsoft_installer

nirsoft_installer downloads and installs most of the freeware
applications available at http://nirsoft.net.

nirsoft_installer looks in the directory where nirsoft_installer.exe is for
any files it needs before attempting to download them. If it does download a
file, it will attempt to save a copy of the file in this same directory.

nirsoft_installer adds the installation directory (typically
`C:\Program Files\NirSoft`) to your PATH environment variable.

If the program is a Windows GUI application, an icon is created in the
`C:\Documents and Settings\%username%\Start Menu\Programs\NirSoft` directory.

Applications that require Windows 98, ME, or NT 4.0, are listed as such.

Note: you are responsible to verify that each program you install using
nirsoft_installer is designed to work in your environment.
If you are unsure, then please visit http://nirsoft.net for more information.

## Usage

````
nirsoft_installer [options]

Options:
/S         Install the application silently with the default options selected
/D=path    Install into the directory 'path' (default is
           %ProgramFiles%\NirSoft)
/INSTYPE n Where n is a number between 1 and 11:
            1: Top Ten (Windows 32-bit)
            2: Top Ten (Windows 64-bit)
            3: All - Windows 64-bit - All versions
            4: All - Windows 32-bit - 8/7/Vista or newer
            5: All - Windows 32-bit - 2008/2003/XP
            6: All - Windows 2000/NT
            7: All - Windows NT
            8: All - Windows ME/98/95
            9: All - Windows 95
           10: Added in release 1.46 (32-bit)
           11: Added in release 1.46 (64-bit)

The following options are planned to be implemented in a future version:

/SAVEDIR d Save downloaded files in directory d
/PROXY     Set proxy settings
/RETRIES n Number of times to retry each download before reporting failure
           (default: 5)
/ALLUSERS  Install icons for all users
           This is the default if the user is an administrator
/USER      Install icons for the current user only
           This is the default if the user is not an administrator
/VERSION   Show the version and quit
/?         Show this help message and quit

If you encounter any errors, please post your installation log to smithii.com.
The installation log will normally be created in %ProgramFiles%\SysInternals\install.log
````

## Contributing

To contribute to this project, please see [CONTRIBUTING.md](CONTRIBUTING.md).

## Bugs

To view existing bugs, or report a new bug, please see the [issues](/issues) page for this project.

## License

This project is [MIT licensed](LICENSE).

## Changelog

Please see [CHANGELOG.md](CHANGELOG.md) for the version history for this project.

## Contact

This project was originally developed by [Ross Smith II](mailto:ross@smithii.com).
Any enhancements and suggestions are welcome.
