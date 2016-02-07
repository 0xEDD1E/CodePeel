//
// Created by 0xEDD1E on 2016-02-01.
//

#include <string.h>
#include "cdplfunc.h"

#define MAXRAWCHAR 1000
#define MAXCODCHAR 1000
#define MAXCOMCHAR 1000

void processfiles(FILE *fsrc, FILE *fcod, FILE *fcom)
{
    char rawline[MAXRAWCHAR] = "", codline[MAXCODCHAR] = "", comline[MAXCOMCHAR] = "";
    char *rp, *cp, *cop;


    while (fgets(rawline, MAXRAWCHAR, fsrc) != NULL) {
        rp = rawline;
        cp = codline;
        cop = comline;
        n_rawlines++;
        if (strlen(rawline) > 1) {
            n_codelines++;

            while (*rp != ';' && *rp != '\n' && *rp != '\0') {
                *cp++ = *rp++;
                *cop++ = ' ';
            }

            if (*rp == ';' || *rp == '\n' || *rp == '\0')
                *cp = '\0';

            fprintf(fcod, "%s\n", codline);

            if (*rp == ';') {
                n_commlines++;

                while (*rp != '\n' && *rp)
                    *cop++ = *rp++;

                if (*rp == '\n' || *rp == '\0')
                    *cop = '\0';

                fprintf(fcom, "%s\n", comline);
            }
        }
    }
}

