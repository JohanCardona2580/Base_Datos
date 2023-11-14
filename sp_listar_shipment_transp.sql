USE [CONTROL]
GO

/****** Object:  StoredProcedure [dbo].[sp_listar_shipment_transp]    Script Date: 14/11/2023 6:40:04 p. m. ******/
DROP PROCEDURE [dbo].[sp_listar_shipment_transp]
GO

/****** Object:  StoredProcedure [dbo].[sp_listar_shipment_transp]    Script Date: 14/11/2023 6:40:04 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Johan Cardona>
-- Create date: <07/10/2023>
-- Description:	<Procedimiento que retorna los pedidos asociados a un shipment por transportador>
-- =============================================
CREATE PROCEDURE [dbo].[sp_listar_shipment_transp]
(	-- Add the parameters for the stored procedure here
     @conductor int
)
AS
BEGIN
 SELECT distinct(s.Id_Shipment) AS id_shipment,
       s.Conductor,
       s.Fecha_Despacho,
       s.Muelle,
       s.Placa_Vehiculo,
       u.Nombre as nombre_conductor,
       t.Nombre_Transportadora,
       dp.Id_Pedido,
	   S.IdRuta,
	   p.nombre_cliente,
	   p.fecha_pedido,
	   p.ciudad,
	   p.barrio,
	   P.direccion,
	   p.telefono
FROM TblShipment s
INNER JOIN TblShipment_dtl d ON s.Id_Shipment=d.id_shipment
INNER JOIN TblUsuario u ON s.Conductor=u.IdUsuario
INNER JOIN TblTransportadora t ON t.Id_Transportadora=u.id_transportadora
INNER JOIN TblDetallePedido dp ON dp.Id_Detalle_Pedido=d.id_detalle_pedido
INNER JOIN TblPedido p ON p.id_pedido=dp.Id_Pedido
WHERE s.Conductor=@conductor;

END

GO

