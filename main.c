//
// Created by 0xEDD1E on 2016-02-01.
//

#include "cdplfunc.h"
//#include "cdplftypes.h"

int main(int argc, char *argv[])
{
    printf("CodePeel v1.0\nSeparating codes and comments from a source file.\n");
    if (argc != 4) {
        puts("usage: codepeel <input file> <code file> <comment file>");
        exit(1);
    }


    FILE *fsrc, *fcod, *fcom;

    if ((fsrc = fopen(argv[1], "r")) != NULL) {
        printf("successfully opened %s for reading.\n", argv[1]);
    } else {
        perror(argv[1]);
        exit(errno);
    }

    if ((fcod = fopen(argv[2], "w")) != NULL) {
        printf("successfully opened %s for writing.\n", argv[2]);
    } else {
        perror(argv[2]);
        exit(errno);
    }

    if ((fcom = fopen(argv[3], "w")) != NULL) {
        printf("successfully opened %s for writing.\n", argv[3]);
    } else {
        perror(argv[3]);
        exit(errno);
    }

    n_codelines = 0;
    n_commlines = 0;
    n_rawlines = 0;

    processfiles(fsrc, fcod, fcom);

    printf("%d lines found in %s\n"
           "%d code lines separated into %s\n"
           "%d comment lines separated into %s\n"
           "...Successfully\n", n_rawlines, argv[1], n_codelines, argv[2], n_commlines, argv[3]);
    return 0;
}

