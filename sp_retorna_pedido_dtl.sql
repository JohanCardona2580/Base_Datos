USE [CONTROL]
GO

/****** Object:  StoredProcedure [dbo].[sp_retornar_pedido_dtl]    Script Date: 14/11/2023 8:46:19 p. m. ******/
DROP PROCEDURE [dbo].[sp_retornar_pedido_dtl]
GO

/****** Object:  StoredProcedure [dbo].[sp_retornar_pedido_dtl]    Script Date: 14/11/2023 8:46:19 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Johan Cardona>
-- Create date: <07/10/2023>
-- Description:	<Procedimiento que retorna los pedidos de una ruta >
-- =============================================
CREATE PROCEDURE [dbo].[sp_retornar_pedido_dtl]
(	-- Add the parameters for the stored procedure here
     @idpedido int
)
AS
BEGIN
  SELECT
    Id_Detalle_Pedido,
    id_pedido,
    Sku,
	Descripcion,
	Cantidad,
	UnidadEmpaque
  FROM TblDetallePedido
  WHERE Id_Pedido = @idpedido
END

GO

