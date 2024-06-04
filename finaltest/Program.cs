using System;

class Program
{
    static void Main()
    {
        string connectionString = "Server=localhost;Database=sistema;Trusted_Connection=True;";//direccion de base de datos

        bool continuar = true;
        while (continuar)
        {
            Console.WriteLine("Bienvenido al sistema de gestión de productos.");
            Console.WriteLine("Seleccione una opción:");
            Console.WriteLine("1. Gestión de productos");
            Console.WriteLine("2. Gestión de categorías");
            Console.WriteLine("3. Gestión de inventario");
            Console.WriteLine("4. Salir");
            Console.Write("Ingrese el número de la opción deseada: ");

            int opcion = int.Parse(Console.ReadLine());

            switch (opcion)
            {
                case 1:
                    GestionProductos.RegistrarNuevoProducto(connectionString);
                    break;
                case 2:
                    GestionCategorias.AgregarNuevaCategoria(connectionString);
                    break;
                case 3:
                    GestionInventario.MostrarMenuInventario(connectionString);
                    break;
                case 4:
                    continuar = false;
                    Console.WriteLine("Saliendo del programa...");
                    break;
                default:
                    Console.WriteLine("Opción inválida. Por favor, seleccione una opción válida.");
                    break;
            }
        }
    }
}






