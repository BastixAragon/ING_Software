using System;
using System.Data.SqlClient;

public class GestionInventario
{
    public static void MostrarMenuInventario(string connectionString)
    {
        bool continuar = true;
        while (continuar)
        {
            Console.WriteLine("\nGestión de Inventario:");
            Console.WriteLine("1. Ver inventario");
            Console.WriteLine("2. Ajustes de inventario");
            Console.WriteLine("3. Buscar producto en el inventario");
            Console.WriteLine("4. Agregar o quitar producto del inventario");
            Console.WriteLine("5. Volver al menú principal");
            Console.Write("Ingrese el número de la opción deseada: ");

            int opcion = int.Parse(Console.ReadLine());

            switch (opcion)
            {
                case 1:
                    VerInventario(connectionString);
                    break;
                case 2:
                    AjustesDeInventario(connectionString);
                    break;
                case 3:
                    BuscarProductoEnInventario(connectionString);
                    break;
                case 4:
                    AgregarQuitarProductoDelInventario(connectionString);
                    break;
                case 5:
                    continuar = false;
                    break;
                default:
                    Console.WriteLine("Opción inválida. Por favor, seleccione una opción válida.");
                    break;
            }
        }
    }

    public static void VerInventario(string connectionString)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = @"
                SELECT i.ID_inventario, p.Nombre, i.Cantidad, i.Tipo_movimiento, i.Fecha_movimiento, u.Nombre AS Usuario
                FROM Inventario i
                JOIN Productos p ON i.Producto_ID = p.ID_producto
                JOIN Usuarios u ON i.Usuario_ID = u.ID_usuario";

            SqlCommand command = new SqlCommand(query, connection);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            Console.WriteLine("\nInventario:");
            while (reader.Read())
            {
                Console.WriteLine($"ID Inventario: {reader["ID_inventario"]}, Producto: {reader["Nombre"]}, Cantidad: {reader["Cantidad"]}, Tipo Movimiento: {reader["Tipo_movimiento"]}, Fecha: {reader["Fecha_movimiento"]}, Usuario: {reader["Usuario"]}");
            }

            reader.Close();
        }
    }

    public static void AjustesDeInventario(string connectionString)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();

            // Mostrar productos disponibles
            string queryProductos = "SELECT ID_producto, Nombre FROM Productos";
            SqlCommand commandProductos = new SqlCommand(queryProductos, connection);
            SqlDataReader readerProductos = commandProductos.ExecuteReader();

            Console.WriteLine("\nProductos disponibles:");
            while (readerProductos.Read())
            {
                Console.WriteLine($"ID: {readerProductos["ID_producto"]}, Nombre: {readerProductos["Nombre"]}");
            }
            readerProductos.Close();

            // Pedir datos para los ajustes
            Console.Write("\nIngrese el ID del producto a ajustar: ");
            int productoID = int.Parse(Console.ReadLine());

            Console.WriteLine("\nSeleccione el campo a ajustar:");
            Console.WriteLine("1. Nombre");
            Console.WriteLine("2. Descripción");
            Console.WriteLine("3. Categoría");
            Console.WriteLine("4. Código de barras");
            Console.WriteLine("5. Fecha de caducidad");
            Console.WriteLine("6. Stock actual");
            Console.WriteLine("7. Precio");
            Console.Write("Ingrese el número de la opción deseada: ");
            int opcionAjuste = int.Parse(Console.ReadLine());

            string campo = string.Empty;
            switch (opcionAjuste)
            {
                case 1:
                    campo = "Nombre";
                    break;
                case 2:
                    campo = "Descripción";
                    break;
                case 3:
                    campo = "Categoría_ID";
                    break;
                case 4:
                    campo = "Código_de_barras";
                    break;
                case 5:
                    campo = "Fecha_de_caducidad";
                    break;
                case 6:
                    campo = "Stock_actual";
                    break;
                case 7:
                    campo = "Precio";
                    break;
                default:
                    Console.WriteLine("Opción inválida.");
                    return;
            }

            Console.Write($"Ingrese el nuevo valor para {campo}: ");
            string nuevoValor = Console.ReadLine();

            string queryUpdate = $"UPDATE Productos SET {campo} = @nuevoValor WHERE ID_producto = @productoID";
            SqlCommand commandUpdate = new SqlCommand(queryUpdate, connection);
            commandUpdate.Parameters.AddWithValue("@nuevoValor", nuevoValor);
            commandUpdate.Parameters.AddWithValue("@productoID", productoID);

            commandUpdate.ExecuteNonQuery();

            Console.WriteLine("Ajuste realizado exitosamente.");
        }
    }

    public static void BuscarProductoEnInventario(string connectionString)
    {
        Console.WriteLine("\nBuscar producto en el inventario por:");
        Console.WriteLine("1. Nombre");
        Console.WriteLine("2. Categoría");
        Console.WriteLine("3. Código de barras");
        Console.Write("Ingrese el número de la opción deseada: ");

        int opcion = int.Parse(Console.ReadLine());

        string query = string.Empty;
        SqlCommand command = null;

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            switch (opcion)
            {
                case 1:
                    Console.Write("Ingrese el nombre del producto: ");
                    string nombre = Console.ReadLine();
                    query = "SELECT * FROM Productos WHERE Nombre LIKE @filtro";
                    command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@filtro", $"%{nombre}%");
                    break;
                case 2:
                    Console.Write("Ingrese el nombre de la categoría: ");
                    string categoria = Console.ReadLine();
                    query = @"
                        SELECT p.*
                        FROM Productos p
                        INNER JOIN Categorías c ON p.Categoría_ID = c.ID_categoria
                        WHERE c.Nombre LIKE @filtro";
                    command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@filtro", $"%{categoria}%");
                    break;
                case 3:
                    Console.Write("Ingrese el código de barras del producto: ");
                    string codigoDeBarras = Console.ReadLine();
                    query = "SELECT * FROM Productos WHERE Código_de_barras = @filtro";
                    command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@filtro", codigoDeBarras);
                    break;
                default:
                    Console.WriteLine("Opción inválida.");
                    return;
            }

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();

            Console.WriteLine("\nResultados de la búsqueda:");
            while (reader.Read())
            {
                Console.WriteLine($"ID: {reader["ID_producto"]}, Nombre: {reader["Nombre"]}, Descripción: {reader["Descripción"]}, Código de barras: {reader["Código_de_barras"]}, Stock: {reader["Stock_actual"]}, Precio: {reader["Precio"]}");
            }

            reader.Close();
        }
    }

    public static void AgregarQuitarProductoDelInventario(string connectionString)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();

            // Mostrar productos disponibles
            string queryProductos = "SELECT ID_producto, Nombre FROM Productos";
            SqlCommand commandProductos = new SqlCommand(queryProductos, connection);
            SqlDataReader readerProductos = commandProductos.ExecuteReader();

            Console.WriteLine("\nProductos disponibles:");
            while (readerProductos.Read())
            {
                Console.WriteLine($"ID: {readerProductos["ID_producto"]}, Nombre: {readerProductos["Nombre"]}");
            }
            readerProductos.Close();

            // Pedir datos para el nuevo movimiento de inventario
            Console.Write("\nIngrese el ID del producto: ");
            int productoID = int.Parse(Console.ReadLine());

            Console.Write("Ingrese la cantidad: ");
            int cantidad = int.Parse(Console.ReadLine());

            Console.Write("Ingrese el tipo de movimiento (Entrada/Salida/Ajuste): ");
            string tipoMovimiento = Console.ReadLine();

            Console.Write("Ingrese su ID de usuario: ");
            int usuarioID = int.Parse(Console.ReadLine());

            string queryInsertInventario = @"
                INSERT INTO Inventario (Producto_ID, Cantidad, Tipo_movimiento, Fecha_movimiento, Usuario_ID)
                VALUES (@ProductoID, @Cantidad, @TipoMovimiento, @FechaMovimiento, @UsuarioID)";

            SqlCommand commandInsert = new SqlCommand(queryInsertInventario, connection);
            commandInsert.Parameters.AddWithValue("@ProductoID", productoID);
            commandInsert.Parameters.AddWithValue("@Cantidad", cantidad);
            commandInsert.Parameters.AddWithValue("@TipoMovimiento", tipoMovimiento);
            commandInsert.Parameters.AddWithValue("@FechaMovimiento", DateTime.Now);
            commandInsert.Parameters.AddWithValue("@UsuarioID", usuarioID);

            commandInsert.ExecuteNonQuery();

            // Actualizar la tabla de productos
            string queryUpdateProducto = tipoMovimiento == "Salida"
                ? "UPDATE Productos SET Stock_actual = Stock_actual - @Cantidad WHERE ID_producto = @ProductoID"
                : "UPDATE Productos SET Stock_actual = Stock_actual + @Cantidad WHERE ID_producto = @ProductoID";

            SqlCommand commandUpdateProducto = new SqlCommand(queryUpdateProducto, connection);
            commandUpdateProducto.Parameters.AddWithValue("@Cantidad", cantidad);
            commandUpdateProducto.Parameters.AddWithValue("@ProductoID", productoID);

            commandUpdateProducto.ExecuteNonQuery();

            Console.WriteLine("Movimiento de inventario registrado exitosamente.");
        }
    }
}



///queda pendiente lo del filtro por categoria, BASTIAN POR DIOS
///

