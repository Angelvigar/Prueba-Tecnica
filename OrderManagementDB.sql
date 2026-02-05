USE [OrderManagementDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDashboardSummary]    Script Date: 5/2/2026 16:11:08 ******/
DROP PROCEDURE [dbo].[sp_GetDashboardSummary]
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_Orders_Clients]
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [DF__Orders__Creation__412EB0B6]
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [DF__Orders__Creation__403A8C7D]
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [DF__Orders__Status__3F466844]
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [DF__Orders__OrderSta__3E52440B]
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [DF__Orders__OrderDat__3D5E1FD2]
GO
ALTER TABLE [dbo].[Clients] DROP CONSTRAINT [DF__Clients__Creatio__3A81B327]
GO
ALTER TABLE [dbo].[Clients] DROP CONSTRAINT [DF__Clients__Creatio__398D8EEE]
GO
ALTER TABLE [dbo].[Clients] DROP CONSTRAINT [DF__Clients__Status__38996AB5]
GO
/****** Object:  Index [UQ_Clients_Email]    Script Date: 5/2/2026 16:11:08 ******/
ALTER TABLE [dbo].[Clients] DROP CONSTRAINT [UQ_Clients_Email]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 5/2/2026 16:11:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orders]') AND type in (N'U'))
DROP TABLE [dbo].[Orders]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 5/2/2026 16:11:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Clients]') AND type in (N'U'))
DROP TABLE [dbo].[Clients]
GO
USE [master]
GO
/****** Object:  Database [OrderManagementDB]    Script Date: 5/2/2026 16:11:08 ******/
DROP DATABASE [OrderManagementDB]
GO
/****** Object:  Database [OrderManagementDB]    Script Date: 5/2/2026 16:11:08 ******/
CREATE DATABASE [OrderManagementDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OrderManagementDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\OrderManagementDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OrderManagementDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS01\MSSQL\DATA\OrderManagementDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [OrderManagementDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OrderManagementDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OrderManagementDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OrderManagementDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OrderManagementDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OrderManagementDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OrderManagementDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [OrderManagementDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OrderManagementDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OrderManagementDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OrderManagementDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OrderManagementDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OrderManagementDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OrderManagementDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OrderManagementDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OrderManagementDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OrderManagementDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OrderManagementDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OrderManagementDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OrderManagementDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OrderManagementDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OrderManagementDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OrderManagementDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OrderManagementDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OrderManagementDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [OrderManagementDB] SET  MULTI_USER 
GO
ALTER DATABASE [OrderManagementDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OrderManagementDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OrderManagementDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OrderManagementDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OrderManagementDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OrderManagementDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [OrderManagementDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [OrderManagementDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [OrderManagementDB]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 5/2/2026 16:11:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](20) NULL,
	[Status] [bit] NOT NULL,
	[CreationUser] [nvarchar](50) NOT NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ModificationUser] [nvarchar](50) NULL,
	[ModificationDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 5/2/2026 16:11:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[OrderDate] [datetime2](7) NOT NULL,
	[OrderState] [nvarchar](50) NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[Status] [bit] NOT NULL,
	[CreationUser] [nvarchar](50) NOT NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[ModificationUser] [nvarchar](50) NULL,
	[ModificationDate] [datetime2](7) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Clients] ON 
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (1, N'Angel', N'Vivanco', N'angel@gmail.com', N'0998338557', 1, N'admin', CAST(N'2026-02-04T13:57:28.2152086' AS DateTime2), N'admin', CAST(N'2026-02-04T15:31:28.2576779' AS DateTime2))
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (2, N'Joel', N'Piguave', N'joel@gmail.com', N'0956873456', 0, N'admin', CAST(N'2026-02-04T15:30:28.7271047' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (3, N'Ricardo', N'Garces', N'ricardo@gmail.com', N'0945762345', 1, N'admin', CAST(N'2026-02-04T15:31:19.0941567' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (4, N'Jonathan', N'Vivas', N'jonathan@gmail.com', N'0956873423', 1, N'admin', CAST(N'2026-02-04T15:32:15.1357648' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (5, N'Laura', N'Méndez', N'laura.mendez@test.com', N'0991112233', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3466667' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (6, N'Carlos', N'Vargas', N'carlos.vargas@test.com', N'0982223344', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (7, N'Ana', N'Torres', N'ana.torres@test.com', N'0973334455', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (8, N'Fernando', N'Ruiz', N'fernando.ruiz@test.com', N'0964445566', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (9, N'Isabel', N'Castro', N'isabel.castro@test.com', N'0955556677', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (10, N'Ricardo', N'Morales', N'ricardo.morales@test.com', N'0998889900', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (11, N'Gabriela', N'Solis', N'gabriela.solis@test.com', N'0987776655', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (12, N'Javier', N'Ortiz', N'javier.ortiz@test.com', N'0991122334', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (13, N'Ruben', N'Pro', N'pro@gmail.com', N'0956874556', 1, N'SYSTEM', CAST(N'2026-02-05T17:00:13.9144118' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Clients] ([Id], [FirstName], [LastName], [Email], [Phone], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (14, N'string', N'string', N'sdijfs@example.com', N'0945454545', 1, N'Angel', CAST(N'2026-02-05T20:15:27.3495824' AS DateTime2), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Clients] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (1, 1, CAST(N'2026-02-04T14:55:17.6178284' AS DateTime2), N'Completado', CAST(50.00 AS Decimal(18, 2)), N'Productos de limpieza', 1, N'admin', CAST(N'2026-02-04T14:55:17.6180300' AS DateTime2), N'admin', CAST(N'2026-02-04T15:46:41.3196052' AS DateTime2))
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (2, 4, CAST(N'2026-02-04T15:50:17.0103219' AS DateTime2), N'Cancelado', CAST(38.00 AS Decimal(18, 2)), N'Mochila nike', 0, N'admin', CAST(N'2026-02-04T15:50:17.0103831' AS DateTime2), N'admin', CAST(N'2026-02-04T15:50:22.5373228' AS DateTime2))
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (3, 4, CAST(N'2026-02-04T15:54:14.1939694' AS DateTime2), N'Cancelado', CAST(35.50 AS Decimal(18, 2)), N'Borradores', 1, N'admin', CAST(N'2026-02-04T15:54:14.1939722' AS DateTime2), N'admin', CAST(N'2026-02-04T16:16:28.9952700' AS DateTime2))
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (4, 1, CAST(N'2026-02-04T16:20:32.5465969' AS DateTime2), N'Cancelado', CAST(34.06 AS Decimal(18, 2)), N'Monitores MSI', 1, N'admin', CAST(N'2026-02-04T16:20:32.5467467' AS DateTime2), N'admin', CAST(N'2026-02-04T16:23:12.0613260' AS DateTime2))
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (5, 5, CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), N'Pendiente', CAST(120.50 AS Decimal(18, 2)), N'Auriculares Bluetooth', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (6, 6, CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), N'Completado', CAST(45.00 AS Decimal(18, 2)), N'Funda para Laptop', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (7, 7, CAST(N'2026-02-04T14:28:04.3500000' AS DateTime2), N'Pendiente', CAST(890.00 AS Decimal(18, 2)), N'Monitor Curvo 27"', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (8, 8, CAST(N'2026-02-03T16:28:04.3500000' AS DateTime2), N'Completado', CAST(1500.00 AS Decimal(18, 2)), N'Laptop Gamer MSI', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (9, 9, CAST(N'2026-02-03T16:28:04.3500000' AS DateTime2), N'Cancelado', CAST(50.00 AS Decimal(18, 2)), N'Mouse Inalámbrico', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (10, 10, CAST(N'2026-02-02T16:28:04.3500000' AS DateTime2), N'Completado', CAST(300.00 AS Decimal(18, 2)), N'Silla Ergonómica', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (11, 11, CAST(N'2026-02-02T16:28:04.3500000' AS DateTime2), N'Pendiente', CAST(75.00 AS Decimal(18, 2)), N'Teclado Mecánico 60%', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (12, 5, CAST(N'2026-01-30T16:28:04.3500000' AS DateTime2), N'Completado', CAST(25.99 AS Decimal(18, 2)), N'Alfombrilla Mouse', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (13, 6, CAST(N'2026-01-29T16:28:04.3500000' AS DateTime2), N'Completado', CAST(110.00 AS Decimal(18, 2)), N'Memoria RAM 16GB', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (14, 7, CAST(N'2026-01-28T16:28:04.3500000' AS DateTime2), N'Pendiente', CAST(220.00 AS Decimal(18, 2)), N'Disco SSD 2TB', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (15, 8, CAST(N'2026-01-28T16:28:04.3500000' AS DateTime2), N'Completado', CAST(60.00 AS Decimal(18, 2)), N'Webcam HD', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (16, 9, CAST(N'2026-01-04T16:28:04.3500000' AS DateTime2), N'Completado', CAST(1200.00 AS Decimal(18, 2)), N'PC Escritorio Oficina', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (17, 10, CAST(N'2026-01-04T16:28:04.3500000' AS DateTime2), N'Completado', CAST(400.00 AS Decimal(18, 2)), N'Tablet Android', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (18, 11, CAST(N'2026-01-04T16:28:04.3500000' AS DateTime2), N'Cancelado', CAST(35.00 AS Decimal(18, 2)), N'Cables HDMI', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (19, 5, CAST(N'2025-12-31T16:28:04.3500000' AS DateTime2), N'Completado', CAST(90.00 AS Decimal(18, 2)), N'Mochila Antirrobo', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3500000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (20, 6, CAST(N'2025-12-04T16:28:04.3533333' AS DateTime2), N'Completado', CAST(2500.00 AS Decimal(18, 2)), N'Servidor Pequeño', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3533333' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (21, 7, CAST(N'2025-12-04T16:28:04.3533333' AS DateTime2), N'Completado', CAST(150.00 AS Decimal(18, 2)), N'Licencia Software', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3533333' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (22, 8, CAST(N'2025-12-04T16:28:04.3533333' AS DateTime2), N'Pendiente', CAST(80.00 AS Decimal(18, 2)), N'Router Wi-Fi 6', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3533333' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (23, 9, CAST(N'2025-11-04T16:28:04.3533333' AS DateTime2), N'Completado', CAST(55.00 AS Decimal(18, 2)), N'Hub USB-C', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3533333' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (24, 10, CAST(N'2025-11-04T16:28:04.3533333' AS DateTime2), N'Completado', CAST(12.00 AS Decimal(18, 2)), N'Limpiador de Pantallas', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3533333' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (25, 5, CAST(N'2026-01-25T16:28:04.3533333' AS DateTime2), N'Pendiente', CAST(45.50 AS Decimal(18, 2)), N'Soporte Laptop', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3533333' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (26, 6, CAST(N'2026-01-23T16:28:04.3533333' AS DateTime2), N'Completado', CAST(300.00 AS Decimal(18, 2)), N'Impresora Multifunción', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3533333' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (27, 11, CAST(N'2026-01-20T16:28:04.3533333' AS DateTime2), N'Cancelado', CAST(100.00 AS Decimal(18, 2)), N'Toner Impresora', 1, N'SEED_DATA', CAST(N'2026-02-04T16:28:04.3533333' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (28, 6, CAST(N'2026-01-20T16:37:38.0600000' AS DateTime2), N'Completado', CAST(1500.00 AS Decimal(18, 2)), N'Laptop Gamer Alta Gama', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (29, 8, CAST(N'2026-01-19T16:37:38.0600000' AS DateTime2), N'Completado', CAST(200.00 AS Decimal(18, 2)), N'Monitor 24 pulg', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (30, 12, CAST(N'2026-01-18T16:37:38.0600000' AS DateTime2), N'Completado', CAST(50.00 AS Decimal(18, 2)), N'Mouse Gamer', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (31, 10, CAST(N'2026-01-17T16:37:38.0600000' AS DateTime2), N'Completado', CAST(120.00 AS Decimal(18, 2)), N'Teclado Mecánico', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (32, 6, CAST(N'2026-01-16T16:37:38.0600000' AS DateTime2), N'Completado', CAST(300.00 AS Decimal(18, 2)), N'Silla de Oficina', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (33, 8, CAST(N'2026-01-15T16:37:38.0600000' AS DateTime2), N'Cancelado', CAST(1000.00 AS Decimal(18, 2)), N'TV 4K (Cancelado)', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (34, 12, CAST(N'2026-01-14T16:37:38.0600000' AS DateTime2), N'Completado', CAST(80.00 AS Decimal(18, 2)), N'Audífonos', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (35, 10, CAST(N'2026-01-13T16:37:38.0600000' AS DateTime2), N'Completado', CAST(45.00 AS Decimal(18, 2)), N'Mochila', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (36, 6, CAST(N'2026-01-12T16:37:38.0600000' AS DateTime2), N'Completado', CAST(1200.00 AS Decimal(18, 2)), N'PC Escritorio', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (37, 8, CAST(N'2026-01-11T16:37:38.0600000' AS DateTime2), N'Completado', CAST(150.00 AS Decimal(18, 2)), N'Disco Duro Externo', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (38, 12, CAST(N'2026-01-10T16:37:38.0600000' AS DateTime2), N'Completado', CAST(60.00 AS Decimal(18, 2)), N'Webcam', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (39, 10, CAST(N'2026-01-09T16:37:38.0600000' AS DateTime2), N'Completado', CAST(90.00 AS Decimal(18, 2)), N'Impresora', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (40, 6, CAST(N'2026-01-08T16:37:38.0600000' AS DateTime2), N'Completado', CAST(25.00 AS Decimal(18, 2)), N'USB 64GB', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (41, 8, CAST(N'2026-01-07T16:37:38.0600000' AS DateTime2), N'Completado', CAST(15.00 AS Decimal(18, 2)), N'Cable HDMI', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (42, 12, CAST(N'2026-01-06T16:37:38.0600000' AS DateTime2), N'Completado', CAST(2000.00 AS Decimal(18, 2)), N'Servidor Rack', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (43, 10, CAST(N'2026-01-05T16:37:38.0600000' AS DateTime2), N'Completado', CAST(500.00 AS Decimal(18, 2)), N'Tablet Gráfica', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (44, 6, CAST(N'2025-12-04T16:37:38.0600000' AS DateTime2), N'Completado', CAST(100.00 AS Decimal(18, 2)), N'Regalo Navidad 1', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (45, 8, CAST(N'2025-12-04T16:37:38.0600000' AS DateTime2), N'Completado', CAST(200.00 AS Decimal(18, 2)), N'Regalo Navidad 2', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (46, 12, CAST(N'2025-12-04T16:37:38.0600000' AS DateTime2), N'Completado', CAST(150.00 AS Decimal(18, 2)), N'Regalo Navidad 3', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (47, 10, CAST(N'2025-12-04T16:37:38.0600000' AS DateTime2), N'Completado', CAST(300.00 AS Decimal(18, 2)), N'Regalo Navidad 4', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (48, 6, CAST(N'2025-12-04T16:37:38.0600000' AS DateTime2), N'Cancelado', CAST(50.00 AS Decimal(18, 2)), N'Regalo Devuelto', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (49, 6, CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), N'Cancelado', CAST(450.00 AS Decimal(18, 2)), N'Celular Nuevo', 0, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), N'SYSTEM', NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (50, 8, CAST(N'2026-02-04T11:37:38.0600000' AS DateTime2), N'Pendiente', CAST(25.00 AS Decimal(18, 2)), N'Cargador Rápido', 1, N'DEMO_DATA', CAST(N'2026-02-04T16:37:38.0600000' AS DateTime2), NULL, NULL)
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (51, 13, CAST(N'2026-02-05T17:00:49.7020980' AS DateTime2), N'Completado', CAST(56.00 AS Decimal(18, 2)), N'rsgrgfffffffffffff', 1, N'SYSTEM', CAST(N'2026-02-05T17:00:49.7020994' AS DateTime2), N'SYSTEM', CAST(N'2026-02-05T17:01:04.3122573' AS DateTime2))
GO
INSERT [dbo].[Orders] ([Id], [ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [Status], [CreationUser], [CreationDate], [ModificationUser], [ModificationDate]) VALUES (52, 3, CAST(N'2026-02-05T20:15:46.8029466' AS DateTime2), N'Pendiente', CAST(0.01 AS Decimal(18, 2)), N'string', 1, N'Angel', CAST(N'2026-02-05T20:15:46.8029472' AS DateTime2), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Clients_Email]    Script Date: 5/2/2026 16:11:08 ******/
ALTER TABLE [dbo].[Clients] ADD  CONSTRAINT [UQ_Clients_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Clients] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Clients] ADD  DEFAULT ('SYSTEM') FOR [CreationUser]
GO
ALTER TABLE [dbo].[Clients] ADD  DEFAULT (getutcdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getutcdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ('Pendiente') FOR [OrderState]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ('SYSTEM') FOR [CreationUser]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getutcdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Clients] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Clients] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Clients]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDashboardSummary]    Script Date: 5/2/2026 16:11:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetDashboardSummary]
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Contadores generales
    SELECT 
        (SELECT COUNT(*) FROM Orders WHERE Status = 1) AS TotalOrders,
        (SELECT COUNT(*) FROM Orders WHERE OrderState = 'Completado' AND Status = 1) AS CompletedOrders,
        (SELECT COUNT(*) FROM Orders WHERE OrderState = 'Pendiente' AND Status = 1) AS PendingOrders,
        (SELECT COUNT(*) FROM Clients WHERE Status = 1) AS ActiveClients;

    -- 2. Actividad por día (últimos 30 días)
    SELECT 
        FORMAT(OrderDate, 'yyyy-MM-dd') AS [Label],
        COUNT(*) AS [Value]
    FROM Orders
    WHERE OrderDate >= DATEADD(DAY, -30, GETUTCDATE()) AND Status = 1
    GROUP BY FORMAT(OrderDate, 'yyyy-MM-dd')
    ORDER BY [Label] ASC;

    -- 3. Actividad por mes (Año actual)
    SELECT 
        FORMAT(OrderDate, 'MMMM') AS [Label],
        COUNT(*) AS [Value]
    FROM Orders
    WHERE YEAR(OrderDate) = YEAR(GETUTCDATE()) AND Status = 1
    GROUP BY FORMAT(OrderDate, 'MMMM'), MONTH(OrderDate)
    ORDER BY MONTH(OrderDate) ASC;
END;
GO
USE [master]
GO
ALTER DATABASE [OrderManagementDB] SET  READ_WRITE 
GO
