USE [CONTROL]
GO

/****** Object:  StoredProcedure [dbo].[sp_lista_conductores]    Script Date: 14/11/2023 8:27:57 p. m. ******/
DROP PROCEDURE [dbo].[sp_lista_conductores]
GO

/****** Object:  StoredProcedure [dbo].[sp_lista_conductores]    Script Date: 14/11/2023 8:27:57 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create  procedure  [dbo].[sp_lista_conductores]
as
begin 
SELECT t.placa_vehiculo, t.nombre_conductor, t.muelle, t.fecha_despacho, p.nombre_transportadora, T.ID_SHIPMENT
FROM tblshipment t
inner join tbltransportadora p
on t.id_transportadora=p.id_transportadora
WHERE T.id_estado=1
end 

GO

