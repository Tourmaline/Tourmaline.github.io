#include "mpi.h"
#include <iostream>


int main(int argc, char *argv[])
{
   MPI_Init(&argc, &argv);

   std::cout << "worker: After init" << std::endl;

   int size;
   MPI_Comm parent;
   MPI_Comm_get_parent(&parent);
   if (parent == MPI_COMM_NULL) std::cout << "No parent!" << std::endl;
   MPI_Comm_remote_size(parent, &size);
   if (size != 1) std::cout << "Something's wrong with the parent" << std::endl;

   MPI_Finalize();
   return 0;
}
