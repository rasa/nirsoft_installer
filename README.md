# nirsoft_installer [![Flattr this][flatter_png]][flatter]

Download and install most of the freeware applications available at
http://nirsoft.net.

nirsoft_installer looks in the directory where nirsoft_installer.exe is for
any files it needs before attempting to download them. If it does download a
file, it will attempt to save a copy of the file in this same directory.

nirsoft_installer adds the installation directory to your PATH environment variable.
On 32-bit systems, this directory is usually `C:\Program Files\NirSoft`.
On 64-bit systems, this directory is usually `C:\Program Files(x86)\NirSoft`.

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
           10: Added in release 1.47 (32-bit)
           11: Added in release 1.47 (64-bit)
           12: Added in release 1.49 (32-bit)
           13: Added in release 1.49 (64-bit)
````

## Verify a Release

To verify a release, download the .zip, .sha256, and .asc files for the release 
(replacing nirsoft_installer-1.49-win32.zip with the release you are verifying):

````
$ wget https://github.com/rasa/nirsoft_installer/releases/download/v1.47/nirsoft_installer-1.49-win32.zip{,.sha256,.asc}
````

Next, check that sha256sum reports "OK":
````
$ sha256sum -c nirsoft_installer-1.49-win32.zip.sha256
nirsoft_installer-1.49-win32.zip: OK
````

Lastly, check that GPG reports "Good signature":

````
$ gpg --keyserver hkps.pool.sks-keyservers.net --recv-key 0x105a5225b6ab4b22
$ gpg --verify nirsoft_installer-1.49-win32.zip.asc nirsoft_installer-1.49-win32.zip
gpg:                using RSA key 0xFF914F74B4BB6EF3
gpg: Good signature from "Ross Smith II <ross@smithii.com>" [ultimate]
...
````

## Contributing

To contribute to this project, please see [CONTRIBUTING.md](CONTRIBUTING.md).

## Bugs

To view existing bugs, or report a new bug, please see [issues](../../issues).

## Changelog

To view the version history for this project, please see [CHANGELOG.md](CHANGELOG.md).

## License

This project is [MIT licensed](LICENSE).

## Contact

This project was created and is maintained by [Ross Smith II][] [![endorse][endorse_png]][endorse]

Feedback, suggestions, and enhancements are welcome.

[Ross Smith II]: mailto:ross@smithii.com "ross@smithii.com"
[flatter]: https://flattr.com/submit/auto?user_id=rasa&url=https%3A%2F%2Fgithub.com%2Frasa%2Fnirsoft_installer
[flatter_png]: http://button.flattr.com/flattr-badge-large.png "Flattr this"
[endorse]: https://coderwall.com/rasa
[endorse_png]: https://api.coderwall.com/rasa/endorsecount.png "endorse"

