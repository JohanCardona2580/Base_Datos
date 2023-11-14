USE [CONTROL]
GO

/****** Object:  StoredProcedure [dbo].[sp_listar_shipment_transp_dtl]    Script Date: 14/11/2023 6:40:30 p. m. ******/
DROP PROCEDURE [dbo].[sp_listar_shipment_transp_dtl]
GO

/****** Object:  StoredProcedure [dbo].[sp_listar_shipment_transp_dtl]    Script Date: 14/11/2023 6:40:30 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Johan Cardona>
-- Create date: <07/10/2023>
-- Description:	<Procedimiento que retorna los pedidos asociados a un shipment por transportador>
-- =============================================
CREATE PROCEDURE [dbo].[sp_listar_shipment_transp_dtl]
(	-- Add the parameters for the stored procedure here
     @id_pedido int
)
AS
BEGIN
SELECT d.id_shipment, 
       d.id_detalle_pedido,
	   dp.id_pedido, 
	   dp.sku,
	   dp.descripcion,
	   dp.cantidad as cantidad_pedido,
	   dp.UnidadEmpaque,
	   d.cant_aud_alistada,
	   e.descripcion as estado_producto
FROM TblShipment s
INNER JOIN TblShipment_dtl d ON s.Id_Shipment=d.id_shipment
INNER JOIN TblUsuario u ON s.Conductor=u.IdUsuario
INNER JOIN TblTransportadora t ON t.Id_Transportadora=u.id_transportadora
INNER JOIN TblDetallePedido dp ON dp.Id_Detalle_Pedido=d.id_detalle_pedido
INNER JOIN TblPedido p ON p.id_pedido=dp.Id_Pedido
INNER JOIN TblEstadoProducto e ON d.id_estado_producto=e.id_estado
WHERE dp.Id_Pedido=@id_pedido;

END

GO

