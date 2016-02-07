//
// Created by 0xEDD1E on 2016-02-01.
//


#include <string.h>   // add String Library
#include "cdplfunc.h" // add CodePeel's function library

#define MAXRAWCHAR 1000 // Maximum characters for a raw line
#define MAXCODCHAR 1000 // Maximum characters for a code line
#define MAXCOMCHAR 1000 // Maximum characters for a comment line

// processfiles function separates code lines and comments from the source file
// it also write code lines and comments lines to the code and comment files
void processfiles(FILE *fsrc, FILE *fcod, FILE *fcom)
{
    // initialize rawline, codline, comline array (initialized to an emmpty string for safety)
    char rawline[MAXRAWCHAR] = "", codline[MAXCODCHAR] = "", comline[MAXCOMCHAR] = "";
    // pointers to handle above arrays
    char *rp, *cp, *cop;

    // while there is lines to process 
    while (fgets(rawline, MAXRAWCHAR, fsrc) != NULL) { // using fgets to fill the rawline array from fsrc stream
        rp = rawline;   // rp initially points to the rawline's first element (base address)
        cp = codline;   // cp initially points to the codline's first element
        cop = comline;  // cop initially points to the comline's first element
        
        n_rawlines++;   // increment number of rawlines processed so far.
        
        if (strlen(rawline) > 1) { // process if rawline is not a one character
                                   // this prevents proccessing empty lines
            
            if (*rp != ';')        // if the string not begins with a ';' it's a code line
                n_codelines++;     // so increment the number of codelines processed so far
            
            // this loop copy the codes from rawline[] to codline[]   
            while (*rp != ';' && *rp != '\n' && *rp != '\0') { // if rp is semi-colon, LF, or null end copying
                *cp++ = *rp++; // copy character from rp to cp then increment cp and rp
                *cop++ = ' ';  // add a spaces in comline[] for each character copied into codline[] 
            }
            
            //if (*rp == ';' || *rp == '\n' || *rp == '\0')
            // terminate the codline string
            *cp = '\0';
            
            // print the codline[] string on fcod stream
            fprintf(fcod, "%s\n", codline);
            
            // if a comment found 
            if (*rp == ';') {
                // increment n_commlines (number of comment lines processed so far)
                n_commlines++;
                // while a LF or NULL char occurs copy rawline[] to commline[]
                while (*rp != '\n' && *rp)
                    *cop++ = *rp++;

                //if (*rp == '\n' || *rp == '\0')
                // terminate the commline[] string
                *cop = '\0';
                
                // print the commline[] string on fcomm strin
                fprintf(fcom, "%s\n", comline);
            }
        }
    }
}

