/*~*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>

#define BiggestOf(H, B, S) ((S) > (B) ? (S) : ((H) > (B) ? (H) : (B)))

#define BUFFLEN 1024

int main(int argc, char *argv[])
{
	if (argc !=  4) {
		puts("usage: codepeel <src-file> <code-file> <comment-file>\n");
		exit(EXIT_FAILURE);
	}
	
	FILE *source, *code, *comment;
	int codepeel(FILE *, FILE *, FILE *, char *);
	
	if ((source = fopen(argv[1], "r")) == NULL) {
		perror(argv[1]);
		exit(2);
	}
	
	if ((code = fopen(argv[2], "w")) == NULL) {
		perror(argv[2]);
		exit(3);
	}
	
	if ((comment = fopen(argv[3], "w")) == NULL) {
		perror(argv[3]);
		exit(4);
	}
	
	int cdpl_ret = codepeel(source, code, comment, "(//)[/*]{*/}");
	if (cdpl_ret > 0) {
		fprintf(stderr, "=======ERROR=======\n[1] Error occured in Codepeel function\n[2] ERR_CODE := ERR_%d\n", cdpl_ret);
		exit(5);
	}
	
	
	
}
int codepeel(FILE *fsrc, FILE *fcod, FILE *fcom, char *comstr)
{
    if (fsrc == NULL || fcod == NULL || fcom == NULL)
		return 1;
	
	char *raw_buff = malloc(BUFFLEN * sizeof (char));
	char *cod_buff = malloc(BUFFLEN * sizeof (char));
	char *com_buff = malloc(BUFFLEN * sizeof (char));
	char *ss, *mb, *me, *rbufp = raw_buff, *ptr_buff = cod_buff;
	char *cod_buff_svp = cod_buff, *com_buff_svp = com_buff;
	int brkcom(char *, char **, char **, char **);
	int n_read;
	
	brkcom(comstr, &ss, &mb, &me);
	
	const int SSLEN = strlen(ss);
	const int MBLEN = strlen(mb);
	const int MELEN = strlen(me);
	int IN = 0;
	// int sz_cod = 0, sz_com = 0;
	char *tokbuf = malloc(sizeof (char) * 2/*BiggestOf(MELEN, MBLEN, SSLEN)*/);
	// printf("%s, %s, %s\n\n\n", ss, mb, me);
	
	// when read chars into raw_buff, ptr_buff initialy points to the cod_buff;
	while ((n_read = read(fileno(fsrc), raw_buff, BUFFLEN)) > 0) {
		if (feof(fsrc)) break;
		cod_buff_svp = cod_buff;
		com_buff_svp = com_buff;
		ptr_buff = cod_buff; // this ptr_buff indicate the buffer to copy raw_buff's chars
							 // if "code" ptr_buff points to cod_buff,
							 // if "comment" ptr_buff points to com_buff.
							 // DEFAULT ptr_buff->cod_buff
		for (rbufp = raw_buff; rbufp < raw_buff + n_read; rbufp++) {
			// snippet below will handle the string literals
			if (*rbufp == '\"') {
				if (IN == 0) IN = 1;
				else IN = 0;
			}
			// if *rbufp == first char of ss, mb, me or rbufp is in a string literal 
			//	copy the *rbufp to *cod_buff
			// else
			//	comment has occured.
			// reconsider the "|| IN" condition 
			if (*rbufp != *ss && *rbufp != *mb && *rbufp != *me || IN) {
				*ptr_buff++ = *rbufp;
			} else {
				/*
				 * This Algotithm roughly separate code and comments
				 * Because program reads a chunk of characters this 
				 * Algotithm should properly handle LFs[\n], and be carefull
				 * when copying NULL chars (see [1:NULL])
				 */
				 
				/** ERROR EXISTS IN strncpy,
				 ** copying produce an error
				 **/
				strncpy(tokbuf, rbufp, SSLEN);
				
				if (strcmp(tokbuf, ss) == 0) {
					cod_buff_svp = ptr_buff; 
					ptr_buff = com_buff;
					ptr_buff = strcat(ptr_buff, ss);
					while (*rbufp != '\n' && !*rbufp) {
						*ptr_buff++ = *rbufp++;
					}
					if (*rbufp == '\n') 
						ptr_buff = strcat(ptr_buff, "\n"); 
					com_buff_svp = ptr_buff;
					ptr_buff = cod_buff_svp; 
				
				} else {
					strncpy(tokbuf, rbufp, MBLEN);
					if (strcmp(tokbuf, mb) == 0) {
						// save cod_buff position //-----------------------------------------
						cod_buff_svp = ptr_buff;
						ptr_buff = com_buff_svp;
						ptr_buff = strcat(ptr_buff, mb);
						// ** FOR loop will take care of copying **
				
					} else {
						strncpy(tokbuf, rbufp, MELEN);
						if (strcmp(tokbuf, me) == 0) {
							ptr_buff = strcat(ptr_buff, me);
							com_buff_svp = ptr_buff; //----------------------------------------
							ptr_buff = cod_buff_svp;
						} else // it's just an innocent characters
							*ptr_buff = *rbufp; // it nothing above happened ptr_buff -> cod_buff;
				
					}

				}
			}
			
		// END FOR	
		}
		write(1, cod_buff, BUFFLEN);
	}
	
	
	return 0;
	
	
}

int brkcom(char *com, char **sin, char **mb, char **me)
{
	if (com == NULL)
		return 1;
	
	char *comp = com;
	int cc;
	
	*sin = *mb = *me = NULL;
	
	// (//)[/*.*/]
	if (*comp == '(') {
		cc = 0;
		while (*(comp + cc) != ')')
			cc++;
		*sin = malloc(cc);
		strncpy(*sin, comp + 1, cc - 1);
		*(*sin + cc - 1) = '\0';
		comp += cc + 1;
	}
	
	if (*comp == '[') {
		cc = 0;
		while (*(comp + cc) != ']')
			cc++;
		*mb = malloc(cc);
		strncpy(*mb, comp + 1, cc - 1);
		*(*mb + cc - 1) = '\0';
		comp += cc + 1;
	}
	
	if (*comp == '{') {
		cc = 0;
		while (*(comp + cc) != '}')
			cc++;
		*me = malloc(cc);
		strncpy(*me, comp + 1, cc - 1);
		*(*me + cc - 1) = '\0';
		comp += cc + 1;
	}
	
	if (*sin == NULL && *mb == NULL && *me == NULL)
		return 2;
	else
		return 0;
}

// IF tokbuf == ss THEN
//	ptr_buff -> com_buff                                  
// 	strcat(com_buff, ss); // ** without NULL char         
//	while (*rbufp != '\n' && !*rbufp)                      
//		*ptr_buff++ = *rbufp++;                           
//  IF *rbufp = '\n' THEN *ptr_buff = '\n'; 
//	ptr_buff -> cod_buff;
// ELSE
// 	IF tokbuff == mb THEN 
//		ptr_buff -> com_buff.
// 		strcat(ptr_buff, mb); 
//	ELSE
//		strncpy(tokbuf, rbufp, MELEN);
//			IF tokbuff == me then	
//				*ptr_buff = '\0';----------------------------[1:NULL]
//				ptr_buff -> cod_buff;
//			FI			
//	FI	
// FI