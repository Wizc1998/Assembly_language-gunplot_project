/*BY SUBMITTING THIS FILE AS PART OF MY LAB ASSIGNMENT, I CERTIFY THAT
* ALL OF THE CONTENT OF THIS FILE WAS CREATED BY ME WITH NO  
* ASSISTANCE FROM ANY PERSON OTHER THAN THE INSTRUCTOR OF THIS COURSE  
* OR ONE OF OUR UNDERGRADUATE GRADERS.
*/

#include "time.h"
#include "stdlib.h"
#include "stdio.h"


int main(int argc, char ** argv){

	long x, y, z;
	int i;
	int size_count;
	FILE * fp;

	/*declear the structure organization*/
	struct ThreeD_values{
	 int x;
	 int y;
	 int z;
	};


	/*declear my_output to store all (x,y,z)*/
	struct ThreeD_values * my_output;


	/*check if we got proper number of command arguments*/
	if (argc !=4) {
		printf("Usage: %s <val1> <val2>\n", argv[0]);
		return;
	}

	/*get value of x and y*/
	x = atoi(argv[1]);
	y = atoi(argv[2]);


	/*malloc the size of this structure, the total number of (x,y,z) are (x*2+1)(y*2+1), this is the range of |(-x~x)||(-y~y)|*/
	size_count = (x*2+1)*(y*2+1);
	my_output = malloc(size_count*sizeof(struct ThreeD_values));

	/*call the function*/
	lea_calc(x, y, my_output);

	/* open the file for writing*/
	fp = fopen (argv[3],"w");
	/* write size_count lines of text into the file stream*/
	for(i = 0; i < size_count;i++){
		fprintf (fp, "%d %d %d\n",my_output[i].x,my_output[i].y,my_output[i].z);
	}
	/* close the file*/  
	fclose (fp);
	free(my_output);
}





