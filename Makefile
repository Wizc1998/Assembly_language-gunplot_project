# BY SUBMITTING THIS FILE AS PART OF MY LAB ASSIGNMENT, I CERTIFY THAT
# ALL OF THE CONTENT OF THIS FILE WAS CREATED BY ME WITH NO  
# ASSISTANCE FROM ANY PERSON OTHER THAN THE INSTRUCTOR OF THIS COURSE  
# OR ONE OF OUR UNDERGRADUATE GRADERS.
all:calc_values

calc_values:calc_values.o lea.o
	gcc calc_values.o lea.o -o calc_values

calc_values.o:calc_values.c
	gcc -ansi -pedantic -c -g calc_values.c

lea.o:lea.s
	gcc -g -lc -m64 -c lea.s

clean:
	rm -rf *.o calc_values
