
DROP TABLE [dbo].TblShipment_dtl
DROP TABLE [dbo].TblShipment
CREATE TABLE [dbo].[TblShipment](
	Id_Shipment int IDENTITY(1,1)  primary key,
	Fecha_Despacho  date,
	IdRuta int,
	Conductor int, 
	Tipo_Vehiculo  nvarchar(10),
	Placa_Vehiculo [nvarchar](50),
	Muelle [int],
	Estado int 
	FOREIGN KEY (tipo_vehiculo) references dbo.TblTipoVehiculo(Id_Tipo_Vehiculo)
) 
GO


CREATE TABLE dbo.TblShipment_dtl
(
    id_detalle_envio  int IDENTITY(1,1)  primary key,
	id_shipment int, 
    id_detalle_pedido INT,
    cant_aud_alistada INT,
    id_estado_producto INT,
	cant_aud_transp INT,
	id_aud_producto INT,
	fecha_aud_transp INT, 
	obs_transp nvarchar(max),
    FOREIGN KEY (id_shipment) REFERENCES dbo.TblShipment(id_shipment),
	FOREIGN KEY (id_detalle_pedido) REFERENCES dbo.TblDetallePedido(id_detalle_pedido),
	FOREIGN KEY (id_estado_producto) REFERENCES dbo.TblEstadoProducto(id_estado),
	FOREIGN KEY (id_aud_producto) REFERENCES dbo.TblEstadoProducto(id_estado)
);