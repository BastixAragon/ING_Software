using System;
using System.Data.SqlClient;

class GestionCategorias
{
    public static void AgregarNuevaCategoria(string connectionString)
    {
        Console.Write("Ingrese el nombre de la nueva categoría: ");
        string nuevaCategoriaNombre = Console.ReadLine();

        Console.Write("Ingrese la descripción de la nueva categoría: ");
        string nuevaCategoriaDescripcion = Console.ReadLine();

        // Insertar la nueva categoría en la base de datos
        string queryInsertarCategoria = @"
            INSERT INTO Categorías (Nombre, Descripción)
            VALUES (@NombreNuevo, @DescripcionNuevo);
            SELECT SCOPE_IDENTITY();";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();

            SqlCommand command = new SqlCommand(queryInsertarCategoria, connection);
            command.Parameters.AddWithValue("@NombreNuevo", nuevaCategoriaNombre);
            command.Parameters.AddWithValue("@DescripcionNuevo", nuevaCategoriaDescripcion);

            command.ExecuteNonQuery();

            Console.WriteLine($"Categoría '{nuevaCategoriaNombre}' agregada exitosamente.");
        }
    }
}

