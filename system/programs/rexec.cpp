#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <grp.h>

#include <message/message.h>
#include <argument/argument.h>

int main(int argc, char **argv)
{
    Argument::ListeMap liste;
    int largc;
    char **largv;

    liste["locale"] = Argument::Liste("-locale", 'c', 1, DEF_LOCALE);

#include "rexec.inc"

    largc = argc;
    largv = argv;

    Argument a(&liste, *argv);
    a.scan(--largc, ++largv);

    setuid( 0 );
    setgroups(0, NULL);
    setgid( 0 );

    if ( chdir((char*)a["projectroot"]) < 0)
    {
        fprintf(stderr, "can't change to projectroot\n");
        exit (-1);
    }

    execl( (std::string("exec/system/shell/") + *largv).c_str(), (std::string("exec/system/shell/") + *largv).c_str(), "-locale", (char*)a["locale"], "-project", (char*)a["project"], NULL );

    fprintf(stderr, "command not found <%s>\n", *largv);
    exit(-1);
}
