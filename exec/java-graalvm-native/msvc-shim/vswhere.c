/* Minimal vswhere.exe stand-in for the hand-extracted MSVC tree.
 *
 * GraalVM's native-image runs
 *   %ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe
 * with arguments such as
 *   -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64
 *           -property installationPath
 * and takes the printed line as the Visual Studio root, whose
 * VC\Auxiliary\Build\vcvarsall.bat it then runs.  There is no real Visual
 * Studio installation on this machine, so this prints the root of the
 * hand-extracted tree instead and ignores every argument except -property.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
    const char *root = getenv("SS_VSROOT");
    if (root == NULL || root[0] == '\0') {
        root = "C:\\stupidspeed\\exec\\java-graalvm-native\\msvc-shim\\VS";
    }
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-property") == 0 && i + 1 < argc) {
            if (strcmp(argv[i + 1], "installationVersion") == 0) {
                printf("17.14.35207.0\n");
                return 0;
            }
            if (strcmp(argv[i + 1], "installationPath") == 0) {
                printf("%s\n", root);
                return 0;
            }
        }
    }
    printf("%s\n", root);
    return 0;
}
