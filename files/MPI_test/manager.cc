#include "mpi.h"
#include <iostream>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    MPI_Init(&argc, &argv);
    if(argc != 2)
    {
        std::cout << "Usage: " << argv[0] << " noWorkers" << std::endl;
        MPI_Finalize();
        return -1;
    }
    int noWorkers = atoi(argv[1]);

    MPI_Comm everyone;
    int my_rank = -1;
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    std::cout <<"my rank is " << my_rank << std::endl;

   std::cout << "Before spawn" << std::endl;

   MPI_Comm_spawn("worker", MPI_ARGV_NULL, noWorkers,
             MPI_INFO_NULL, 0, MPI_COMM_SELF, &everyone,
             MPI_ERRCODES_IGNORE);

   std::cout << "After spawn" << std::endl;

   MPI_Finalize();
   return 0;
}
