# Sistema de Gestión de Pedidos 
Sistema completo de gestión de pedidos con autenticación JWT, desarrollado con .NET 8, Angular 17 y SQL Server.

# Arquitectura del Sistema
El sistema está compuesto por tres componentes principales:
AuthBE - Servicio de autenticación (Puerto 7024)
OrderBE - Servicio de gestión de pedidos y clientes (Puerto 7061)
Frontend Angular - Interfaz de usuario (Puerto 4200)

# Tecnologías Utilizadas
Backend
.NET 8.0 - Framework principal
Entity Framework Core 8.0 - ORM
SQL Server - Base de datos
JWT (JSON Web Tokens) - Autenticación
BCrypt - Encriptación de contraseñas
AutoMapper - Mapeo de objetos
Swagger/OpenAPI - Documentación de API

# Frontend
Angular 17 - Framework frontend
Angular Material - Componentes UI
RxJS - Programación reactiva
Chart.js - Gráficos y estadísticas
TypeScript - Lenguaje de programación

# Configuración:
Para la api de Auth se debe cambiar la cade de conexión ubicada en el appsettings.json y appsettings.Development.json.
Para la api de Auth se debe cambiar la cade de conexión ubicada en el appsettings.json.

# Inicio de sesión:
Puede hacer uso de las credenciales que se encuentran ingresadas:
Usuario: Admin	Contraseña: admin123	
Usuario: Gestor	Contraseña: gestor123	
Usuario: Consultor	Contraseña: consultor123	


