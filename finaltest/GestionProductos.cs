using System;
using System.Collections.Generic;
using System.Data.SqlClient;

class GestionProductos
{
    public static void RegistrarNuevoProducto(string connectionString)
    {
        // Obtener y mostrar las categorías disponibles
        Dictionary<int, string> categorias = ObtenerCategorias(connectionString);
        Console.WriteLine("Categorías disponibles:");
        foreach (var categoria in categorias)
        {
            Console.WriteLine($"{categoria.Key}: {categoria.Value}");
        }

        Console.Write("Seleccione el número correspondiente a la categoría del producto: ");
        int categoriaID = int.Parse(Console.ReadLine());

        Console.Write("Ingrese el nombre del producto: ");
        string nombreProducto = Console.ReadLine();

        Console.Write("Ingrese la descripción del producto: ");
        string descripcionProducto = Console.ReadLine();

        Console.Write("Ingrese el código de barras del producto: ");
        string codigoDeBarras = Console.ReadLine();

        Console.Write("Ingrese la fecha de caducidad del producto (YYYY-MM-DD): ");
        DateTime fechaDeCaducidad = DateTime.Parse(Console.ReadLine());

        Console.Write("Ingrese el stock actual del producto: ");
        int stockActual = int.Parse(Console.ReadLine());

        Console.Write("Ingrese el precio del producto: ");
        decimal precio = decimal.Parse(Console.ReadLine());

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            try
            {
                connection.Open();

                // Insertar el nuevo producto en la base de datos
                string query = @"
                    INSERT INTO Productos (Nombre, Descripción, Categoría_ID, Código_de_barras, Fecha_de_caducidad, Stock_actual, Precio)
                    VALUES (@Nombre, @Descripción, @Categoría_ID, @Código_de_barras, @Fecha_de_caducidad, @Stock_actual, @Precio);
                    SELECT SCOPE_IDENTITY();";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Nombre", nombreProducto);
                command.Parameters.AddWithValue("@Descripción", descripcionProducto);
                command.Parameters.AddWithValue("@Categoría_ID", categoriaID);
                command.Parameters.AddWithValue("@Código_de_barras", codigoDeBarras);
                command.Parameters.AddWithValue("@Fecha_de_caducidad", fechaDeCaducidad);
                command.Parameters.AddWithValue("@Stock_actual", stockActual);
                command.Parameters.AddWithValue("@Precio", precio);

                // Ejecutar la consulta y obtener el ID generado automáticamente
                int nuevoID = Convert.ToInt32(command.ExecuteScalar());

                Console.WriteLine($"Producto registrado exitosamente con ID {nuevoID}.");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al registrar nuevo producto: " + ex.Message);
            }
        }
    }

    private static Dictionary<int, string> ObtenerCategorias(string connectionString)
    {
        Dictionary<int, string> categorias = new Dictionary<int, string>();

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT ID_categoria, Nombre FROM Categorías";

            SqlCommand command = new SqlCommand(query, connection);
            connection.Open();

            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                int categoriaID = reader.GetInt32(0);
                string nombreCategoria = reader.GetString(1);
                categorias.Add(categoriaID, nombreCategoria);
            }
        }

        return categorias;
    }
}





