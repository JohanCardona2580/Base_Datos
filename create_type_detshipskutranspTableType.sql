USE [CONTROL]
GO

/****** Object:  UserDefinedTableType [dbo].[detelleshipskuTableType]    Script Date: 13/11/2023 1:37:55 p. m. ******/
CREATE TYPE [dbo].[detshipskutranspTableType] AS TABLE(
	[id_detalle_pedido] [int] NULL,
	cant_aud_transp [int] NULL,
	[id_estado_producto] [int] NULL,
	obs_transp varchar(max)
)
GO


