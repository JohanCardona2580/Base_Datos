USE [CONTROL]
GO

/****** Object:  UserDefinedTableType [dbo].[detelleshipskuTableType]    Script Date: 14/11/2023 7:32:31 p. m. ******/
DROP TYPE [dbo].[detelleshipskuTableType]
GO

/****** Object:  UserDefinedTableType [dbo].[detelleshipskuTableType]    Script Date: 14/11/2023 7:32:31 p. m. ******/
CREATE TYPE [dbo].[detelleshipskuTableType] AS TABLE(
	[id_detalle_pedido] [int] NULL,
	[cant_aud_alistada] [int] NULL,
	[id_estado_producto] [int] NULL
)
GO

