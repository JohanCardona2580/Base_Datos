USE [CONTROL]
GO

/****** Object:  StoredProcedure [dbo].[sp_listar_ruta_id]    Script Date: 14/11/2023 8:27:35 p. m. ******/
DROP PROCEDURE [dbo].[sp_listar_ruta_id]
GO

/****** Object:  StoredProcedure [dbo].[sp_listar_ruta_id]    Script Date: 14/11/2023 8:27:35 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create  procedure  [dbo].[sp_listar_ruta_id]
as
begin 
select idruta,fechageneracion, estadoruta from TblRuta
where estadoruta='A'
end 

GO

