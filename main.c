//
// Created by 0xEDD1E on 2016-02-01.
//

#include "cdplfunc.h"
//#include "cdplftypes.h"

int main(int argc, char *argv[])
{
    if (argc != 4) {
        puts("usage: asmcodepeel <input file> <code file> <comment file>");
        exit(1);
    }

    FILE *fsrc, *fcod, *fcom;

    if ((fsrc = fopen(argv[1], "r")) == NULL) {
        perror("source file");
        exit(errno);
    }

    if ((fcod = fopen(argv[2], "w")) == NULL) {
        perror("creating code file");
        exit(errno);
    }

    if ((fcom = fopen(argv[3], "w")) == NULL) {
        perror("creating comment file");
        exit(errno);
    }

    n_codelines = 0;
    n_commlines = 0;
    n_rawlines = 0;

    processfiles(fsrc, fcod, fcom);

    printf("Assembly Code Peeler v 1.1\nSeparates Codes and Comments in an assembly code file\n"
                   "%d lines found in %s\n"
                   "%d code lines separated into %s\n"
                   "%d comment lines separated into %s\n"
                   "...Successfully\n", n_rawlines, argv[1], n_codelines, argv[2], n_commlines, argv[3]);
    return 0;
}

