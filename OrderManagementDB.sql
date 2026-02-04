USE master;
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'OrderManagementDB')
BEGIN
    CREATE DATABASE OrderManagementDB;
    PRINT 'Base de datos OrderManagementDB creada.';
END
GO

USE OrderManagementDB;
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Clients]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Clients] (
        [Id] INT IDENTITY(1,1) NOT NULL,
        [FirstName] NVARCHAR(100) NOT NULL,
        [LastName] NVARCHAR(100) NOT NULL,
        [Email] NVARCHAR(100) NOT NULL,
        [Phone] NVARCHAR(20) NULL,
        [Status] BIT NOT NULL DEFAULT 1,
        [CreationUser] NVARCHAR(50) NOT NULL DEFAULT 'SYSTEM',
        [CreationDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
        [ModificationUser] NVARCHAR(50) NULL,
        [ModificationDate] DATETIME2 NULL,
        CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED ([Id] ASC),
        CONSTRAINT [UQ_Clients_Email] UNIQUE ([Email])
    );
    CREATE INDEX [IX_Clients_Email] ON [dbo].[Clients] ([Email]);
    PRINT 'Tabla Clients creada.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orders]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[Orders] (
        [Id] INT IDENTITY(1,1) NOT NULL,
        [ClientId] INT NOT NULL,
        [OrderDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
        [OrderState] NVARCHAR(50) NOT NULL DEFAULT 'Pendiente', -- Pendiente, Completado, Cancelado
        [TotalAmount] DECIMAL(18,2) NOT NULL,
        [Description] NVARCHAR(500) NULL,
        [Status] BIT NOT NULL DEFAULT 1,
        [CreationUser] NVARCHAR(50) NOT NULL DEFAULT 'SYSTEM',
        [CreationDate] DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
        [ModificationUser] NVARCHAR(50) NULL,
        [ModificationDate] DATETIME2 NULL,
        CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([Id] ASC),
        CONSTRAINT [FK_Orders_Clients] FOREIGN KEY ([ClientId]) 
            REFERENCES [dbo].[Clients] ([Id])
    );
    CREATE INDEX [IX_Orders_ClientId] ON [dbo].[Orders] ([ClientId]);
    CREATE INDEX [IX_Orders_OrderState] ON [dbo].[Orders] ([OrderState]);
    CREATE INDEX [IX_Orders_OrderDate] ON [dbo].[Orders] ([OrderDate]);
    PRINT 'Tabla Orders creada.';
END
GO

CREATE OR ALTER PROCEDURE sp_GetDashboardSummary
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        (SELECT COUNT(*) FROM Orders WHERE Status = 1) AS TotalOrders,
        (SELECT COUNT(*) FROM Orders WHERE OrderState = 'Completado' AND Status = 1) AS CompletedOrders,
        (SELECT COUNT(*) FROM Orders WHERE OrderState = 'Pendiente' AND Status = 1) AS PendingOrders,
        (SELECT COUNT(*) FROM Clients WHERE Status = 1) AS ActiveClients;

    SELECT 
        FORMAT(OrderDate, 'yyyy-MM-dd') AS [Label],
        COUNT(*) AS [Value]
    FROM Orders
    WHERE OrderDate >= DATEADD(DAY, -30, GETUTCDATE()) AND Status = 1
    GROUP BY FORMAT(OrderDate, 'yyyy-MM-dd')
    ORDER BY [Label] ASC;

    SELECT 
        FORMAT(OrderDate, 'MMMM') AS [Label], 
        COUNT(*) AS [Value]
    FROM Orders
    WHERE YEAR(OrderDate) = YEAR(GETUTCDATE()) AND Status = 1
    GROUP BY FORMAT(OrderDate, 'MMMM'), MONTH(OrderDate)
    ORDER BY MONTH(OrderDate) ASC;
END;
GO
PRINT 'Stored Procedure sp_GetDashboardSummary creado/actualizado.';
GO

IF NOT EXISTS (SELECT 1 FROM [dbo].[Clients])
BEGIN
    INSERT INTO [dbo].[Clients] ([FirstName], [LastName], [Email], [Phone], [CreationUser])
    VALUES 
        ('Andrés', 'López', 'andres.lopez@prueba.com', '0991234567', 'SEED'),
        ('Sofía', 'Herrera', 'sofia.herrera@empresa.com', '0987654321', 'SEED'),
        ('Mateo', 'Salazar', 'mateo.salazar99@test.com', '0955554444', 'SEED'),
        ('Valentina', 'Mendoza', 'valentina.mendoza@demo.com', '0998887777', 'SEED'),
        ('Diego', 'Paredes', 'diego.paredes@test.com', '0961112222', 'SEED');
    PRINT 'Clientes de prueba insertados.';
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Orders])
BEGIN
    DECLARE @C1 INT = (SELECT TOP 1 Id FROM Clients WHERE Email = 'andres.lopez@prueba.com');
    DECLARE @C2 INT = (SELECT TOP 1 Id FROM Clients WHERE Email = 'sofia.herrera@empresa.com');
    DECLARE @C3 INT = (SELECT TOP 1 Id FROM Clients WHERE Email = 'mateo.salazar99@test.com');

    INSERT INTO [dbo].[Orders] ([ClientId], [OrderDate], [OrderState], [TotalAmount], [Description], [CreationUser])
    VALUES 
        (@C1, GETUTCDATE(), 'Pendiente', 150.50, 'Laptop Accesorio', 'SEED'),
        (@C2, GETUTCDATE(), 'Completado', 25.00, 'Libro técnico', 'SEED'),
        
        (@C1, DATEADD(DAY, -2, GETUTCDATE()), 'Completado', 500.00, 'Monitor 24"', 'SEED'),
        (@C3, DATEADD(DAY, -2, GETUTCDATE()), 'Pendiente', 80.00, 'Teclado Mecánico', 'SEED'),
        
        (@C2, DATEADD(DAY, -5, GETUTCDATE()), 'Cancelado', 1200.00, 'PC Gamer (Cancelado)', 'SEED'),
        
        (@C3, DATEADD(MONTH, -1, GETUTCDATE()), 'Completado', 45.00, 'Mousepad XL', 'SEED');
        
    PRINT 'Pedidos de prueba insertados.';
END
GO