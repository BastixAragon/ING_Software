USE [master]
GO
/****** Object:  Database [sistema]    Script Date: 3/6/2024 23:10:43 ******/
CREATE DATABASE [sistema]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'sistema', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\sistema.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'sistema_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\sistema_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [sistema] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [sistema].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [sistema] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [sistema] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [sistema] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [sistema] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [sistema] SET ARITHABORT OFF 
GO
ALTER DATABASE [sistema] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [sistema] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [sistema] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [sistema] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [sistema] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [sistema] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [sistema] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [sistema] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [sistema] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [sistema] SET  ENABLE_BROKER 
GO
ALTER DATABASE [sistema] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [sistema] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [sistema] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [sistema] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [sistema] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [sistema] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [sistema] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [sistema] SET RECOVERY FULL 
GO
ALTER DATABASE [sistema] SET  MULTI_USER 
GO
ALTER DATABASE [sistema] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [sistema] SET DB_CHAINING OFF 
GO
ALTER DATABASE [sistema] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [sistema] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [sistema] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [sistema] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'sistema', N'ON'
GO
ALTER DATABASE [sistema] SET QUERY_STORE = ON
GO
ALTER DATABASE [sistema] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [sistema]
GO
/****** Object:  Table [dbo].[Categorías]    Script Date: 3/6/2024 23:10:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorías](
	[ID_categoria] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Descripción] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Compras]    Script Date: 3/6/2024 23:10:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Compras](
	[ID_compra] [int] IDENTITY(1,1) NOT NULL,
	[Proveedor_ID] [int] NOT NULL,
	[Fecha_compra] [datetime] NOT NULL,
	[Monto_total] [decimal](10, 2) NOT NULL,
	[Impuestos] [decimal](10, 2) NOT NULL,
	[Descuentos] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalles_Compra]    Script Date: 3/6/2024 23:10:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalles_Compra](
	[ID_detalle_compra] [int] IDENTITY(1,1) NOT NULL,
	[Compra_ID] [int] NOT NULL,
	[Producto_ID] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Precio_unitario] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_detalle_compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detalles_Venta]    Script Date: 3/6/2024 23:10:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detalles_Venta](
	[ID_detalle_venta] [int] IDENTITY(1,1) NOT NULL,
	[Venta_ID] [int] NOT NULL,
	[Producto_ID] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Precio_unitario] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_detalle_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Historial_Inventario]    Script Date: 3/6/2024 23:10:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Historial_Inventario](
	[ID_historial] [int] IDENTITY(1,1) NOT NULL,
	[Producto_ID] [int] NOT NULL,
	[Fecha_movimiento] [datetime] NOT NULL,
	[Tipo_movimiento] [nvarchar](50) NULL,
	[Cantidad] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_historial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventario]    Script Date: 3/6/2024 23:10:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario](
	[ID_inventario] [int] IDENTITY(1,1) NOT NULL,
	[Producto_ID] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Tipo_movimiento] [nvarchar](50) NULL,
	[Fecha_movimiento] [datetime] NOT NULL,
	[Usuario_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_inventario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mermas]    Script Date: 3/6/2024 23:10:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mermas](
	[ID_merma] [int] IDENTITY(1,1) NOT NULL,
	[Producto_ID] [int] NOT NULL,
	[Tipo_merma] [nvarchar](50) NULL,
	[Cantidad] [int] NOT NULL,
	[Fecha_merma] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_merma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 3/6/2024 23:10:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[ID_producto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Descripción] [nvarchar](255) NULL,
	[Categoría_ID] [int] NULL,
	[Código_de_barras] [nvarchar](50) NULL,
	[Fecha_de_caducidad] [date] NULL,
	[Stock_actual] [int] NULL,
	[Precio] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proveedores]    Script Date: 3/6/2024 23:10:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedores](
	[ID_proveedor] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_empresa] [nvarchar](100) NOT NULL,
	[Nombre_mediador] [nvarchar](100) NULL,
	[Contacto] [nvarchar](100) NULL,
	[Correo] [nvarchar](100) NOT NULL,
	[Dirección] [nvarchar](255) NULL,
	[RUT_empresa] [nvarchar](50) NOT NULL,
	[Tipo_productos] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 3/6/2024 23:10:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[ID_usuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[Contacto] [nvarchar](100) NULL,
	[Rol] [nvarchar](50) NULL,
	[Clave] [nvarchar](100) NOT NULL,
	[Últimas_Acciones] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ventas]    Script Date: 3/6/2024 23:10:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ventas](
	[ID_venta] [int] IDENTITY(1,1) NOT NULL,
	[Fecha_venta] [datetime] NOT NULL,
	[Monto_total] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Compras]  WITH CHECK ADD  CONSTRAINT [FK_Proveedor] FOREIGN KEY([Proveedor_ID])
REFERENCES [dbo].[Proveedores] ([ID_proveedor])
GO
ALTER TABLE [dbo].[Compras] CHECK CONSTRAINT [FK_Proveedor]
GO
ALTER TABLE [dbo].[Detalles_Compra]  WITH CHECK ADD  CONSTRAINT [FK_Compra_Detalle_Compra] FOREIGN KEY([Compra_ID])
REFERENCES [dbo].[Compras] ([ID_compra])
GO
ALTER TABLE [dbo].[Detalles_Compra] CHECK CONSTRAINT [FK_Compra_Detalle_Compra]
GO
ALTER TABLE [dbo].[Detalles_Compra]  WITH CHECK ADD  CONSTRAINT [FK_Producto_Detalle_Compra] FOREIGN KEY([Producto_ID])
REFERENCES [dbo].[Productos] ([ID_producto])
GO
ALTER TABLE [dbo].[Detalles_Compra] CHECK CONSTRAINT [FK_Producto_Detalle_Compra]
GO
ALTER TABLE [dbo].[Detalles_Venta]  WITH CHECK ADD  CONSTRAINT [FK_Producto_Detalle_Venta] FOREIGN KEY([Producto_ID])
REFERENCES [dbo].[Productos] ([ID_producto])
GO
ALTER TABLE [dbo].[Detalles_Venta] CHECK CONSTRAINT [FK_Producto_Detalle_Venta]
GO
ALTER TABLE [dbo].[Detalles_Venta]  WITH CHECK ADD  CONSTRAINT [FK_Venta_Detalle_Venta] FOREIGN KEY([Venta_ID])
REFERENCES [dbo].[Ventas] ([ID_venta])
GO
ALTER TABLE [dbo].[Detalles_Venta] CHECK CONSTRAINT [FK_Venta_Detalle_Venta]
GO
ALTER TABLE [dbo].[Historial_Inventario]  WITH CHECK ADD  CONSTRAINT [FK_Producto_Historial_inventario] FOREIGN KEY([Producto_ID])
REFERENCES [dbo].[Productos] ([ID_producto])
GO
ALTER TABLE [dbo].[Historial_Inventario] CHECK CONSTRAINT [FK_Producto_Historial_inventario]
GO
ALTER TABLE [dbo].[Inventario]  WITH CHECK ADD  CONSTRAINT [FK_Producto] FOREIGN KEY([Producto_ID])
REFERENCES [dbo].[Productos] ([ID_producto])
GO
ALTER TABLE [dbo].[Inventario] CHECK CONSTRAINT [FK_Producto]
GO
ALTER TABLE [dbo].[Inventario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario] FOREIGN KEY([Usuario_ID])
REFERENCES [dbo].[Usuarios] ([ID_usuario])
GO
ALTER TABLE [dbo].[Inventario] CHECK CONSTRAINT [FK_Usuario]
GO
ALTER TABLE [dbo].[Mermas]  WITH CHECK ADD  CONSTRAINT [FK_Producto_Mermas] FOREIGN KEY([Producto_ID])
REFERENCES [dbo].[Productos] ([ID_producto])
GO
ALTER TABLE [dbo].[Mermas] CHECK CONSTRAINT [FK_Producto_Mermas]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Categoría] FOREIGN KEY([Categoría_ID])
REFERENCES [dbo].[Categorías] ([ID_categoria])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Categoría]
GO
ALTER TABLE [dbo].[Historial_Inventario]  WITH CHECK ADD CHECK  (([Tipo_movimiento]='Ajuste' OR [Tipo_movimiento]='Venta' OR [Tipo_movimiento]='Compra'))
GO
ALTER TABLE [dbo].[Inventario]  WITH CHECK ADD CHECK  (([Tipo_movimiento]='Ajuste' OR [Tipo_movimiento]='Salida' OR [Tipo_movimiento]='Entrada'))
GO
ALTER TABLE [dbo].[Mermas]  WITH CHECK ADD CHECK  (([Tipo_merma]='Error de fábrica' OR [Tipo_merma]='Daño' OR [Tipo_merma]='Obsolescencia' OR [Tipo_merma]='Pérdida' OR [Tipo_merma]='Robo' OR [Tipo_merma]='Caducidad'))
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD CHECK  (([Rol]='Administrativo' OR [Rol]='Vendedor' OR [Rol]='Dueño/Jefe'))
GO
USE [master]
GO
ALTER DATABASE [sistema] SET  READ_WRITE 
GO
