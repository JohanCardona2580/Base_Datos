USE [CONTROL]
GO

/****** Object:  StoredProcedure [dbo].[spUsuarioInsert]    Script Date: 14/11/2023 7:13:28 p. m. ******/
DROP PROCEDURE [dbo].[spUsuarioInsert]
GO

/****** Object:  StoredProcedure [dbo].[spUsuarioInsert]    Script Date: 14/11/2023 7:13:28 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Batch submitted through debugger: SQLQuery2.sql|7|0|C:\Users\Johan\AppData\Local\Temp\~vsE827.sql

CREATE    PROCEDURE  [dbo].[spUsuarioInsert]
(
	@Nombre varchar(250),
	@Apellido varchar(250),
	@Email varchar(250),
	@Password varchar(30),
	@IdRol int,
	@IdTransportadora int,
	@Placa varchar(6)
	
)
AS
BEGIN 

	SET NOCOUNT ON;
	BEGIN TRY
      -- validar si el usuario ya existe 
      IF EXISTS (SELECT 1 FROM tblusuario WHERE email = @Email)
        BEGIN 
            -- Ruta ya gestionada, hacer rollback y retornar mensaje
            SELECT -1 as codigo_respuesta, 'El usuario ya existe ' AS respuesta;
            RETURN;
        END

		DECLARE @PasswordHash varbinary(32);
		select @PasswordHash= HASHBYTES('SHA2_256',@Password);

		if @IdRol<>6 
		 SET @IdTransportadora=-1;
		ELSE
		SET @IdTransportadora=@IdTransportadora;


		INSERT INTO dbo.TblUsuario
		(Nombre,FechaAlta, Email,Password,id_rol,id_transportadora,placa,flag_proteccion)
		values(@Nombre+ ' '+ @Apellido, GETDATE(),@email,@PasswordHash,@IdRol,@IdTransportadora,@Placa,0);
		SELECT 1 as codigo_respuesta, 'Usuario Creado exitosamente' AS respuesta; 
	END TRY

	BEGIN CATCH
		execute dbo.sp_ControlErrores;
	END CATCH
END 

GO

