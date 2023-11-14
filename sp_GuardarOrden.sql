USE [CONTROL]
GO

/****** Object:  StoredProcedure [dbo].[sp_GuardarOrden]    Script Date: 13/11/2023 1:01:27 p. m. ******/
DROP PROCEDURE [dbo].[sp_GuardarOrden]
GO

/****** Object:  StoredProcedure [dbo].[sp_GuardarOrden]    Script Date: 13/11/2023 1:01:27 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GuardarOrden]
    @idruta INT,
    @idconductor INT,
    @muelle INT,
    @detalle dbo.detelleshipskuTableType READONLY -- Usamos el tipo de tabla definido
AS
BEGIN
    BEGIN TRY
        -- Iniciar la transacción
        BEGIN TRANSACTION;

        -- Verificar si la ruta ya está gestionada
        IF EXISTS (SELECT 1 FROM TblShipment WHERE IdRuta = @idruta)
        BEGIN 
            -- Ruta ya gestionada, hacer rollback y retornar mensaje
            ROLLBACK;
            SELECT -1 as codigo_respuesta, 'La ruta ya está gestionada' AS respuesta;
            RETURN;
        END

		-- Verificar si el conductor ya tiene una shipment abierto
        IF EXISTS (SELECT 1 FROM TblShipment WHERE Conductor = @idconductor and Estado=1)
        BEGIN 
            -- Ruta ya gestionada, hacer rollback y retornar mensaje
            ROLLBACK;
            SELECT -1 as codigo_respuesta, 'El conductor ya tiene asociado un shipment' AS respuesta;
            RETURN;
        END


        -- Insertar la cabecera del shipment
        INSERT INTO TblShipment
        (
            Fecha_Despacho,
            IdRuta,
            Conductor,
            Tipo_Vehiculo,
            Placa_Vehiculo,
            Muelle,
            Estado
        )
        VALUES
        (
            GETDATE(),
            @idruta,
            @idconductor,
            'C2',
            (SELECT placa FROM TblUsuario WHERE idusuario = @idconductor),
            @muelle,
            1
        )

        -- Obtener el último ID insertado
        DECLARE @lastID INT = SCOPE_IDENTITY();

        -- Insertar los detalles desde la tabla de valor tipo tabla
        -- Insertar los detalles desde la tabla de valor tipo tabla
        INSERT INTO TblShipment_dtl
        (
            id_shipment,
            id_detalle_pedido,
            cant_aud_alistada,
            id_estado_producto
        )
        SELECT @lastID,
               id_detalle_pedido,
               cant_aud_alistada,
               id_estado_producto
        FROM @detalle;

        -- Commit si todo se ejecutó correctamente
        COMMIT;

		update TblRuta 
		set EstadoRuta='I'
		WHERE IdRuta=@idruta


        -- Todo se insertó correctamente, devolver algún valor indicando éxito
        SELECT 1 as codigo_respuesta, 'Se ha creado el Shipment Nº ' + CAST(@lastID AS NVARCHAR(10)) AS respuesta; 
        RETURN;
    END TRY
    BEGIN CATCH
        -- Capturar el mensaje de error
        DECLARE @ErrorMessage NVARCHAR(500) = ERROR_MESSAGE();

        -- Rollback en caso de error
        ROLLBACK;

        -- Verificar si el error es de clave externa
        IF CHARINDEX('FK__TblShipme__id_de', @ErrorMessage) > 0
        BEGIN
            -- Este es un mensaje personalizado para un error de clave externa
            SELECT -1 as codigo_respuesta, 'Error: Se ha producido un conflicto con la clave externa en TblDetallePedido.' AS respuesta;
        END
        ELSE IF CHARINDEX('FK__TblShipme__id_es', @ErrorMessage) > 0
        BEGIN
            -- Este es un mensaje personalizado para un error de clave externa en TblEstadoProducto
            SELECT -1 as codigo_respuesta, 'Error: Se ha producido un conflicto con la clave externa en TblEstadoProducto.' AS respuesta;
        END
        ELSE
        BEGIN
            -- Si no es un error de clave externa, ejecutar el procedimiento normal de control de errores
            EXECUTE dbo.sp_ControlErrores;
        END
    END CATCH
END;

GO

