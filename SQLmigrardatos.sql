USE GD1C2024
GO

--eliminacion de tablas ------------ 
IF OBJECT_ID('EL_UNICO.envio', 'U') IS NOT NULL DROP TABLE EL_UNICO.envio
IF OBJECT_ID('EL_UNICO.pago', 'U') IS NOT NULL DROP TABLE EL_UNICO.pago
IF OBJECT_ID('EL_UNICO.ticket_detalle', 'U') IS NOT NULL DROP TABLE EL_UNICO.ticket_detalle
IF OBJECT_ID('EL_UNICO.ticket', 'U') IS NOT NULL DROP TABLE EL_UNICO.ticket
IF OBJECT_ID('EL_UNICO.empleado', 'U') IS NOT NULL DROP TABLE EL_UNICO.empleado
IF OBJECT_ID('EL_UNICO.sucursal', 'U') IS NOT NULL DROP TABLE EL_UNICO.sucursal
IF OBJECT_ID('EL_UNICO.super', 'U') IS NOT NULL DROP TABLE EL_UNICO.super
IF OBJECT_ID('EL_UNICO.condicion_fiscal', 'U') IS NOT NULL DROP TABLE EL_UNICO.condicion_fiscal
IF OBJECT_ID('EL_UNICO.cliente', 'U') IS NOT NULL DROP TABLE EL_UNICO.cliente
IF OBJECT_ID('EL_UNICO.direccion', 'U') IS NOT NULL DROP TABLE EL_UNICO.direccion
IF OBJECT_ID('EL_UNICO.localidad', 'U') IS NOT NULL DROP TABLE EL_UNICO.localidad
IF OBJECT_ID('EL_UNICO.provincia', 'U') IS NOT NULL DROP TABLE EL_UNICO.provincia
IF OBJECT_ID('EL_UNICO.envio_estado', 'U') IS NOT NULL DROP TABLE EL_UNICO.envio_estado
IF OBJECT_ID('EL_UNICO.caja', 'U') IS NOT NULL DROP TABLE EL_UNICO.caja
IF OBJECT_ID('EL_UNICO.tipo_caja', 'U') IS NOT NULL DROP TABLE EL_UNICO.tipo_caja
IF OBJECT_ID('EL_UNICO.tipo_comprobante', 'U') IS NOT NULL DROP TABLE EL_UNICO.tipo_comprobante
IF OBJECT_ID('EL_UNICO.promocion_x_producto', 'U') IS NOT NULL DROP TABLE EL_UNICO.promocion_x_producto
IF OBJECT_ID('EL_UNICO.producto', 'U') IS NOT NULL DROP TABLE EL_UNICO.producto
IF OBJECT_ID('EL_UNICO.subcategoria', 'U') IS NOT NULL DROP TABLE EL_UNICO.subcategoria
IF OBJECT_ID('EL_UNICO.categoria', 'U') IS NOT NULL DROP TABLE EL_UNICO.categoria
IF OBJECT_ID('EL_UNICO.marca', 'U') IS NOT NULL DROP TABLE EL_UNICO.marca
IF OBJECT_ID('EL_UNICO.promocion_x_regla', 'U') IS NOT NULL DROP TABLE EL_UNICO.promocion_x_regla
IF OBJECT_ID('EL_UNICO.regla', 'U') IS NOT NULL DROP TABLE EL_UNICO.regla
IF OBJECT_ID('EL_UNICO.promocion', 'U') IS NOT NULL DROP TABLE EL_UNICO.promocion
IF OBJECT_ID('EL_UNICO.promo', 'U') IS NOT NULL DROP TABLE EL_UNICO.promo
IF OBJECT_ID('EL_UNICO.descuento_x_medio_de_pago', 'U') IS NOT NULL DROP TABLE EL_UNICO.descuento_x_medio_de_pago
IF OBJECT_ID('EL_UNICO.medio_de_pago', 'U') IS NOT NULL DROP TABLE EL_UNICO.medio_de_pago
IF OBJECT_ID('EL_UNICO.tipo_medio_pago', 'U') IS NOT NULL DROP TABLE EL_UNICO.tipo_medio_pago
IF OBJECT_ID('EL_UNICO.descuento', 'U') IS NOT NULL DROP TABLE EL_UNICO.descuento
--IF OBJECT_ID('EL_UNICO.tarjeta', 'U') IS NOT NULL DROP TABLE EL_UNICO.tarjeta

PRINT('se borraron las tablas')
GO
--/eliminacion de tablas------------


--eliminacion del schema -----------
IF EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'EL_UNICO')
DROP SCHEMA EL_UNICO;
PRINT('se borro el schema')
GO
--/eliminacion del schema ----------


--creacion del schema -----------
exec('CREATE SCHEMA EL_UNICO')
PRINT('SE CREO EL SCHEMA');
GO
--/creacion del schema -----------


--creacion de tablas -------
CREATE TABLE [EL_UNICO].provincia (
  provincia_id decimal(18,0) IDENTITY(1,1), /*PK*/
  provincia_detalle nvarchar(255) NOT NULL,
  unique(provincia_detalle)
);

CREATE TABLE [EL_UNICO].localidad (
  localidad_id decimal(18,0) IDENTITY(1,1), /*PK*/
  localidad_detalle nvarchar(255) NOT NULL,
  localidad_provincia_id decimal(18,0), /*FK*/
  --unique(localidad_detalle) no sirve para este modelo pues exite detalles repetidos pero pertencen a distintas provincias
);

CREATE TABLE [EL_UNICO].direccion (
  direccion_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  direccion_detalle nvarchar(255) NOT NULL,
  direccion_localidad_id decimal(18,0), /*FK*/
  --unique(direccion_detalle) lo mismo que la anterior puede tener distinta localidad_id
);


CREATE TABLE [EL_UNICO].condicion_fiscal (
  condicion_fiscal_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  condicion_fiscal_detalle nvarchar(255) NOT NULL,
  unique(condicion_fiscal_detalle)
);

CREATE TABLE [EL_UNICO].super(
  super_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  super_nombre nvarchar(255),
  super_cuit nvarchar(255) NOT NULL,
  super_razon_soc nvarchar(255) NOT NULL, 
  super_iibb nvarchar(255),
  super_direccion_id decimal(18,0), /*FK*/
  super_fecha_ini_actividad datetime,
  super_condicion_fiscal_id decimal(18,0), /*FK*/
  unique(super_cuit, super_razon_soc)
);

CREATE TABLE [EL_UNICO].cliente (
  cliente_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  cliente_nombre nvarchar(255) NOT NULL,
  cliente_apellido nvarchar(255) NOT NULL,
  cliente_dni decimal(18,0) NOT NULL,
  cliente_fecha_registro datetime,
  cliente_telefono decimal(18,0),
  cliente_mail nvarchar(255),
  cliente_fecha_nacimiento date,
  cliente_direccion_id decimal(18,0), /*FK*/
  unique(cliente_nombre,cliente_apellido,cliente_dni)
);

CREATE TABLE [EL_UNICO].envio_estado (
  envio_estado_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  envio_estado_detalle nvarchar(255) NOT NULL,
  unique(envio_estado_detalle)
);

CREATE TABLE [EL_UNICO].sucursal(
  sucursal_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  sucursal_nombre nvarchar(255) NOT NULL,
  sucursal_direccion_id decimal(18,0), /*FK*/
  sucursal_super_id decimal(18,0), /*FK*/
);


CREATE TABLE [EL_UNICO].empleado (
  empleado_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  empleado_nombre nvarchar(255) NOT NULL, 
  empleado_apellido nvarchar(255) NOT NULL,
  empleado_dni decimal(18,0) NOT NULL,
  empleado_fecha_registro datetime,
  empleado_telefono decimal(18,0),
  empleado_mail nvarchar(255),
  empleado_fecha_nacimiento date,
  empleado_sucursal_id decimal(18,0), /*FK*/
  unique(empleado_nombre, empleado_apellido, empleado_dni)
);

CREATE TABLE [EL_UNICO].tipo_caja (
  tipo_caja_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  tipo_caja_detalle nvarchar(255),
  unique(tipo_caja_detalle),
);

CREATE TABLE [EL_UNICO].caja (
  caja_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  caja_numero decimal(18,0) NOT NULL,
  caja_tipo_caja_id decimal(18,0) NOT NULL, /*FK*/
);

CREATE TABLE [EL_UNICO].tipo_comprobante (
  tipo_compr_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  tipo_compr_detalle nvarchar(255),
  --PRIMARY KEY (`tipo_compr_id`)
);

CREATE TABLE [EL_UNICO].categoria (
  categoria_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  categoria_detalle nvarchar(255),
  unique(categoria_detalle)
);

CREATE TABLE [EL_UNICO].subcategoria (
  subcategoria_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  subcategoria_detalle nvarchar(255),
  subcategoria_categoria_id decimal(18,0), /*FK*/
);

CREATE TABLE [EL_UNICO].marca (
  marca_id decimal(18,0) IDENTiTY(1,1),/*PK*/
  marca_detalle nvarchar(255),
  unique(marca_detalle)
);

CREATE TABLE [EL_UNICO].producto (
  producto_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  producto_nombre nvarchar(255),
  producto_descripcion nvarchar(255),
  producto_precio decimal(18,2),
  producto_marca_id decimal(18,0), /*FK*/
  producto_subcategoria_id decimal(18,0), /*FK*/
);

CREATE TABLE [EL_UNICO].regla (
  regla_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  regla_descripcion nvarchar(255),
  regla_descuento_aplicable_prod decimal(18,2),
  regla_cant_aplicable_regla decimal(18,0),
  regla_cant_aplica_descuento decimal(18,0),
  regla_cant_max_prod decimal(18,0),
  regla_aplica_misma_marca decimal(18,0),
  regla_aplica_mismo_prod decimal(18,0),
);

CREATE TABLE [EL_UNICO].promocion (
  promocion_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  promocion_descripcion nvarchar(255),
  promocion_fecha_inicio datetime,
  promocion_fecha_fin datetime,
  --CHECK(envio_hora_inicio < envio_hora_fin) deberia ser con fecha inicio fecha fin
);

CREATE TABLE [EL_UNICO].promocion_x_regla(
  promocion_id decimal(18,0) NOT NULL, /*PK FK*/
  regla_id decimal(18,0) NOT NULL, /*PK FK*/
);

CREATE TABLE [EL_UNICO].promocion_x_producto(
  producto_id decimal(18,0) NOT NULL, /*PK FK*/
  promocion_id decimal(18,0) NOT NULL, /*PK FK*/
);

CREATE TABLE [EL_UNICO].promo(
  promo_id decimal(18,0) IDENTiTY(1,1),  /*PK*/
  promo_codigo decimal(18,0),
  promo_aplica_descuento decimal(18,2),
);

CREATE TABLE [EL_UNICO].tipo_medio_pago(
  tipo_medio_pago_id decimal(18,0) IDENTiTY(1,1),/*PK*/
  tipo_medio_pago_detalle nvarchar(255),
  unique(tipo_medio_pago_detalle),
);

CREATE TABLE [EL_UNICO].medio_de_pago (
  medio_pago_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  medio_pago_detalle nvarchar(255),
  medio_pago_tipo_id decimal(18,0), /*FK*/
);

CREATE TABLE [EL_UNICO].descuento (
  descuento_codigo decimal(18,0) NOT NULL, /*PK*/
  descuento_Descripcion nvarchar(255),
  descuento_fecha_inicio datetime,
  descuento_fecha_fin datetime,
  descuento_porcentaje_desc decimal(18,2),
  descuento_tope decimal(18,2),
);

CREATE TABLE [EL_UNICO].descuento_x_medio_de_pago(
  descuento_codigo decimal(18,0) NOT NULL, /*PK FK*/
  medio_de_pago_id decimal(18,0) NOT NULL, /*PK FK*/
);
/*
CREATE TABLE [EL_UNICO].tarjeta(
  tarjeta_id decimal(18,0) IDENTiTY(1,1),
  pago_tarjeta_nro nvarchar(50),
  pago_tarjetas_cuotas decimal(18,0),
  pago_tarjetas_fecha_venc datetime,
);
*/
CREATE TABLE [EL_UNICO].ticket (
  ticket_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  ticket_numero decimal(18,0),
  ticket_fecha_hora datetime,
  ticket_tipo_comprobante_id decimal(18,0), /*FK*/
  ticket_caja_id decimal(18,0), /*FK*/
  ticket_empleado_id decimal(18,0), /*FK*/
  ticket_sucursal_id decimal(18,0), /*FK*/
  ticket_subtotal_productos decimal(18,2),
  ticket_total_envio decimal(18,2),
  ticket_total_descuento_aplicado decimal(18,2),
  ticket_total_descuento_aplicado_mp decimal(18,2),
  ticket_total_ticket decimal(18,2),
  --ticket_envio_id decimal(18,0) NULL, /*FK*/ /*hay ticket que no tienen envio*/
);

CREATE TABLE [EL_UNICO].envio (
  envio_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  envio_fecha_programada datetime NOT NULL,
  envio_hora_inicio decimal(18,0),
  envio_hora_fin decimal(18,0),
  envio_cliente_id decimal(18,0), /*FK*/
  envio_ticket_id decimal(18,0), /*FK*/
  envio_costo decimal(18,2) NOT NULL,
  envio_envio_estado_id decimal(18,0), /*FK*/
  envio_fecha_entrega datetime NOT NULL,
  --CHECK(envio_hora_inicio < envio_hora_fin) deberia ser con fecha programda fecha entregada
);


CREATE TABLE [EL_UNICO].pago (
  pago_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  pago_ticket_id decimal(18,0), /*FK*/
  pago_fecha datetime,
  pago_medio_pago_id decimal(18,0), /*FK*/
  pago_descuento_aplicado decimal(18,0),
  pago_importe decimal(18,2),
  --pago_tarjeta_id decimal(18,0) NULL, /*FK hay medio de pago efectivo por lo que esto seria null */
  pago_tarjeta_nro nvarchar(50),
  pago_tarjetas_cuotas decimal(18,0),
  pago_tarjetas_fecha_venc datetime,
);

CREATE TABLE [EL_UNICO].ticket_detalle(
  ticket_id decimal(18,0) NOT NULL, /*PK FK*/
  prodcuto_id decimal(18,0) NOT NULL, /*PK FK*/
  ticket_det_cantidad decimal(18,0),
  ticket_det_precio decimal(18,2),
  ticket_det_total decimal(18,2),
  ticket_det_promo_id decimal(18,0) NULL, /*FK algunos no tienen descuento aplicado*/ 
);

PRINT('SE CREARON LAS TABLAS')
GO
--/creacion de tablas -------

--agregado de PK------------
ALTER TABLE [EL_UNICO].provincia ADD CONSTRAINT PK_provincia PRIMARY KEY(provincia_id);
ALTER TABLE [EL_UNICO].localidad ADD CONSTRAINT PK_localidad PRIMARY KEY(localidad_id);
ALTER TABLE [EL_UNICO].direccion ADD CONSTRAINT PK_direccion PRIMARY KEY(direccion_id);
ALTER TABLE [EL_UNICO].condicion_fiscal ADD CONSTRAINT PK_condicion_fiscal PRIMARY KEY(condicion_fiscal_id);
ALTER TABLE [EL_UNICO].super ADD CONSTRAINT PK_super PRIMARY KEY(super_id);
ALTER TABLE [EL_UNICO].cliente ADD CONSTRAINT PK_cliente PRIMARY KEY(cliente_id);
ALTER TABLE [EL_UNICO].envio_estado ADD CONSTRAINT PK_envio_estado PRIMARY KEY(envio_estado_id);
ALTER TABLE [EL_UNICO].envio ADD CONSTRAINT PK_envio PRIMARY KEY(envio_id);
ALTER TABLE [EL_UNICO].sucursal ADD CONSTRAINT PK_sucursal PRIMARY KEY(sucursal_id);
ALTER TABLE [EL_UNICO].empleado ADD CONSTRAINT PK_empleado PRIMARY KEY(empleado_id);
ALTER TABLE [EL_UNICO].tipo_caja ADD CONSTRAINT PK_tipo_caja PRIMARY KEY(tipo_caja_id);
ALTER TABLE [EL_UNICO].caja ADD CONSTRAINT PK_caja PRIMARY KEY(caja_id);
ALTER TABLE [EL_UNICO].tipo_comprobante ADD CONSTRAINT PK_tipo_comprobante PRIMARY KEY(tipo_compr_id);
ALTER TABLE [EL_UNICO].categoria ADD CONSTRAINT PK_categoria PRIMARY KEY(categoria_id);
ALTER TABLE [EL_UNICO].subcategoria ADD CONSTRAINT PK_subcategoria PRIMARY KEY(subcategoria_id);
ALTER TABLE [EL_UNICO].marca ADD CONSTRAINT PK_marca PRIMARY KEY(marca_id);
ALTER TABLE [EL_UNICO].producto ADD CONSTRAINT PK_producto PRIMARY KEY(producto_id);
ALTER TABLE [EL_UNICO].regla ADD CONSTRAINT PK_regla PRIMARY KEY(regla_id);
ALTER TABLE [EL_UNICO].promocion ADD CONSTRAINT PK_promocion PRIMARY KEY(promocion_id);
ALTER TABLE [EL_UNICO].promocion_x_regla ADD CONSTRAINT PK_promocion_x_regla PRIMARY KEY(promocion_id, regla_id);
ALTER TABLE [EL_UNICO].promocion_x_producto ADD CONSTRAINT PK_promocion_x_producto PRIMARY KEY(producto_id,promocion_id);
ALTER TABLE [EL_UNICO].promo ADD CONSTRAINT PK_promo_id PRIMARY KEY(promo_id);
ALTER TABLE [EL_UNICO].tipo_medio_pago ADD CONSTRAINT PK_tipo_medio_pago PRIMARY KEY(tipo_medio_pago_id);
ALTER TABLE [EL_UNICO].medio_de_pago ADD CONSTRAINT PK_medio_pago PRIMARY KEY(medio_pago_id);
ALTER TABLE [EL_UNICO].descuento ADD CONSTRAINT PK_descuento PRIMARY KEY(descuento_codigo);
ALTER TABLE [EL_UNICO].descuento_x_medio_de_pago ADD CONSTRAINT PK_descuento_x_medio_pago PRIMARY KEY(descuento_codigo, medio_de_pago_id);
--ALTER TABLE [EL_UNICO].tarjeta ADD CONSTRAINT PK_tarjeta PRIMARY KEY(tarjeta_id);
ALTER TABLE [EL_UNICO].ticket ADD CONSTRAINT PK_TICKET PRIMARY KEY(ticket_id);
ALTER TABLE [EL_UNICO].pago ADD CONSTRAINT PK_pago PRIMARY KEY(pago_id);
GO

--agregado de FK-------------
ALTER TABLE [EL_UNICO].localidad ADD CONSTRAINT FK_loc_provincia FOREIGN KEY(localidad_provincia_id) REFERENCES [EL_UNICO].provincia(provincia_id);
ALTER TABLE [EL_UNICO].direccion ADD CONSTRAINT FK_dir_localidad FOREIGN KEY(direccion_localidad_id) REFERENCES [EL_UNICO].localidad(localidad_id);
ALTER TABLE [EL_UNICO].super ADD CONSTRAINT FK_super_direccion FOREIGN KEY(super_direccion_id) REFERENCES [EL_UNICO].direccion(direccion_id);
ALTER TABLE [EL_UNICO].super ADD CONSTRAINT FK_super_condicion_fiscal FOREIGN KEY(super_condicion_fiscal_id) REFERENCES [EL_UNICO].condicion_fiscal(condicion_fiscal_id);
ALTER TABLE [EL_UNICO].cliente ADD CONSTRAINT FK_clie_direccion FOREIGN KEY(cliente_direccion_id) REFERENCES [EL_unico].direccion(direccion_id);
ALTER TABLE [EL_UNICO].envio ADD CONSTRAINT FK_env_envio_estado FOREIGN KEY(envio_envio_estado_id) REFERENCES [EL_UNICO].envio_estado(envio_estado_id);
ALTER TABLE [EL_UNICO].envio ADD CONSTRAINT FK_env_ticket FOREIGN KEY(envio_ticket_id) REFERENCES [EL_UNICO].ticket(ticket_id);
ALTER TABLE [EL_UNICO].sucursal ADD CONSTRAINT FK_suc_direccion FOREIGN KEY(sucursal_direccion_id) REFERENCES [EL_UNICO].direccion(direccion_id);
ALTER TABLE [EL_UNICO].sucursal ADD CONSTRAINT FK_suc_super FOREIGN KEY(sucursal_super_id) REFERENCES [EL_UNICO].super(super_id);
ALTER TABLE [EL_UNICO].empleado ADD CONSTRAINT FK_empl_sucursal FOREIGN KEY(empleado_sucursal_id) REFERENCES [EL_UNICO].sucursal(sucursal_id);
ALTER TABLE [EL_UNICO].caja ADD CONSTRAINT FK_caja_tipo_caja FOREIGN KEY(caja_tipo_caja_id) REFERENCES [EL_UNICO].tipo_caja(tipo_caja_id);
ALTER TABLE [EL_UNICO].subcategoria ADD CONSTRAINT FK_subcat_categoria FOREIGN KEY(subcategoria_categoria_id) REFERENCES [EL_UNICO].categoria(categoria_id);
ALTER TABLE [EL_UNICO].producto ADD CONSTRAINT FK_prod_subcategoria FOREIGN KEY(producto_subcategoria_id) REFERENCES [EL_UNICO].subcategoria(subcategoria_id);
ALTER TABLE [EL_UNICO].producto ADD CONSTRAINT FK_prod_marca FOREIGN KEY(producto_marca_id) REFERENCES [EL_UNICO].marca(marca_id);
ALTER TABLE [EL_UNICO].promocion_x_regla ADD CONSTRAINT FK_promo_x_regla FOREIGN KEY(promocion_id) REFERENCES [EL_UNICO].promocion(promocion_id);
ALTER TABLE [EL_UNICO].promocion_x_regla ADD CONSTRAINT FK_regla FOREIGN KEY(regla_id) REFERENCES [EL_UNICO].regla(regla_id);
ALTER TABLE [EL_UNICO].promocion_x_producto ADD CONSTRAINT FK_producto FOREIGN KEY(producto_id) REFERENCES [EL_UNICO].producto(producto_id);
ALTER TABLE [EL_UNICO].promocion_x_producto ADD CONSTRAINT FK_promo_x_prod FOREIGN KEY(promocion_id) REFERENCES [EL_UNICO].promocion(promocion_id);
ALTER TABLE [EL_UNICO].medio_de_pago ADD CONSTRAINT FK_tipo_medio_pago FOREIGN KEY(medio_pago_tipo_id) REFERENCES [EL_UNICO].tipo_medio_pago(tipo_medio_pago_id);
ALTER TABLE [EL_UNICO].descuento_x_medio_de_pago ADD CONSTRAINT FK_descuento_codigo FOREIGN KEY(descuento_codigo) REFERENCES [EL_UNICO].descuento(descuento_codigo);
ALTER TABLE [EL_UNICO].descuento_x_medio_de_pago ADD CONSTRAINT FK_medio_de_pago FOREIGN KEY(medio_de_pago_id) REFERENCES [EL_UNICO].medio_de_pago(medio_pago_id);
ALTER TABLE [EL_UNICO].ticket ADD CONSTRAINT FK_tick_tipo_comprobante FOREIGN KEY(ticket_tipo_comprobante_id) REFERENCES [EL_UNICO].tipo_comprobante(tipo_compr_id);
ALTER TABLE [EL_UNICO].ticket ADD CONSTRAINT FK_tick_caja_id FOREIGN KEY(ticket_caja_id) REFERENCES [EL_UNICO].caja(caja_id);
ALTER TABLE [EL_UNICO].ticket ADD CONSTRAINT FK_empleado FOREIGN KEY(ticket_empleado_id) REFERENCES [EL_UNICO].empleado(empleado_id);
ALTER TABLE [EL_UNICO].ticket ADD CONSTRAINT FK_sucursal FOREIGN KEY(ticket_sucursal_id) REFERENCES [EL_UNICO].sucursal(sucursal_id);
ALTER TABLE [EL_UNICO].pago ADD CONSTRAINT FK_pago_ticket FOREIGN KEY(pago_ticket_id) REFERENCES [EL_UNICO].ticket(ticket_id)
ALTER TABLE [EL_UNICO].pago ADD CONSTRAINT FK_pago_medio_pago FOREIGN KEY(pago_medio_pago_id) REFERENCES [EL_UNICO].medio_de_pago(medio_pago_id)
--ALTER TABLE [EL_UNICO].pago ADD CONSTRAINT FK_pago_tarjeta FOREIGN KEY(pago_tarjeta_id) REFERENCES [EL_UNICO].tarjeta(tarjeta_id)
GO




--llenado de tablas-------
INSERT INTO [EL_UNICO].provincia (provincia_detalle)
	SELECT distinct CLIENTE_PROVINCIA 
	FROM gd_esquema.Maestra WHERE CLIENTE_PROVINCIA IS NOT NULL
	UNION
	SELECT distinct SUCURSAL_PROVINCIA 
	FROM gd_esquema.Maestra WHERE SUCURSAL_PROVINCIA IS NOT NULL
	UNION 
	SELECT distinct SUPER_PROVINCIA	
	FROM gd_esquema.Maestra	WHERE SUPER_PROVINCIA IS NOT NULL

DECLARE @cantProvincias NVARCHAR(255)
SET @cantProvincias = (SELECT COUNT(*) FROM [EL_UNICO].provincia)
PRINT('Se agregaron ' + @cantProvincias + ' provincias')

---------
INSERT INTO [EL_UNICO].localidad (localidad_detalle, localidad_provincia_id)	
	SELECT distinct SUCURSAL_LOCALIDAD, provincia_id 
	FROM gd_esquema.Maestra JOIN EL_UNICO.provincia ON SUCURSAL_PROVINCIA = provincia_detalle
	UNION 
	SELECT  distinct CLIENTE_LOCALIDAD, provincia_id 
	FROM gd_esquema.Maestra JOIN EL_UNICO.provincia ON CLIENTE_PROVINCIA = provincia_detalle
	UNION 
	SELECT distinct SUPER_LOCALIDAD, provincia_id 
	FROM gd_esquema.Maestra JOIN EL_UNICO.provincia ON SUPER_PROVINCIA = provincia_detalle
	
DECLARE @cantlocalidades NVARCHAR(255)
SET @cantlocalidades = (SELECT COUNT(*) FROM [EL_UNICO].localidad)
PRINT('Se agregaron ' + @cantlocalidades + ' localidades')

/*
	SELECT distinct SUCURSAL_LOCALIDAD, SUCURSAL_PROVINCIA  
	FROM gd_esquema.Maestra 
	WHERE SUCURSAL_LOCALIDAD is not null
	UNION --1
	SELECT distinct CLIENTE_LOCALIDAD, CLIENTE_PROVINCIA 
	FROM gd_esquema.Maestra 
	WHERE CLIENTE_LOCALIDAD is not null
	UNION ----6370
	SELECT distinct SUPER_LOCALIDAD, SUPER_PROVINCIA 
	FROM gd_esquema.Maestra
	WHERE SUPER_LOCALIDAD is not null
*/

/* Ver este detalle va encontra de lo planteado amenos que .....	
	SELECT distinct CLIENTE_LOCALIDAD, CLIENTE_PROVINCIA
	FROM gd_esquema.Maestra
	Where CLIENTE_LOCALIDAD = 'Ciudad Autonoma Buenos Aires'
*/

---------
INSERT INTO [EL_UNICO].direccion (direccion_detalle, direccion_localidad_id)
	SELECT distinct CLIENTE_DOMICILIO, localidad_id
	FROM gd_esquema.Maestra JOIN EL_UNICO.provincia ON CLIENTE_PROVINCIA = provincia_detalle
							JOIN EL_UNICO.localidad ON CLIENTE_LOCALIDAD = localidad_detalle AND localidad_provincia_id = provincia_id		
	UNION
	SELECT distinct SUCURSAL_DIRECCION, localidad_id
	FROM gd_esquema.Maestra JOIN EL_UNICO.provincia on SUCURSAL_PROVINCIA = provincia_detalle
							JOIN EL_UNICO.localidad ON SUCURSAL_LOCALIDAD = localidad_detalle AND localidad_provincia_id = provincia_id
	UNION
	SELECT distinct SUPER_DOMICILIO, localidad_id
	FROM gd_esquema.Maestra JOIN EL_UNICO.provincia on SUPER_PROVINCIA = provincia_detalle
							JOIN EL_UNICO.localidad on SUPER_LOCALIDAD = localidad_detalle AND localidad_provincia_id = provincia_id

/*	
	SELECT distinct CLIENTE_DOMICILIO, CLIENTE_LOCALIDAD, CLIENTE_PROVINCIA
	FROM gd_esquema.Maestra
	where CLIENTE_DOMICILIO is not null
	UNION --6862
	SELECT distinct SUCURSAL_DIRECCION, SUCURSAL_LOCALIDAD, SUCURSAL_PROVINCIA
	FROM gd_esquema.Maestra
	where SUCURSAL_DIRECCION is not null
	UNION --8
	SELECT distinct SUPER_DOMICILIO, SUPER_LOCALIDAD, SUPER_PROVINCIA
	FROM gd_esquema.Maestra 
	where SUPER_DOMICILIO is not null
	--1
*/	
DECLARE @cantdirecciones NVARCHAR(255)
SET @cantdirecciones = (SELECT COUNT(*) FROM [EL_UNICO].direccion)
PRINT('Se agregaron ' + @cantdirecciones + ' direcciones')


-----------
INSERT INTO [EL_UNICO].condicion_fiscal (condicion_fiscal_detalle)
	SELECT distinct SUPER_CONDICION_FISCAL
	FROM gd_esquema.Maestra

DECLARE @cantDeCondicionesFiscal NVARCHAR(255)
SET @cantDeCondicionesFiscal = (SELECT COUNT(*) FROM [EL_UNICO].condicion_fiscal)
PRINT('Se agregaron ' + @cantDeCondicionesFiscal + ' condicion fiscal')

-----------
INSERT INTO [EL_UNICO].super (super_nombre, super_cuit, super_razon_soc, super_iibb, super_direccion_id, super_fecha_ini_actividad, super_condicion_fiscal_id)
	SELECT distinct SUPER_NOMBRE, SUPER_CUIT,SUPER_RAZON_SOC,SUPER_IIBB, direccion_id, SUPER_FECHA_INI_ACTIVIDAD, condicion_fiscal_id
	FROM gd_esquema.Maestra JOIN EL_UNICO.provincia ON SUPER_PROVINCIA = provincia_detalle 
							JOIN EL_UNICO.localidad ON SUPER_LOCALIDAD = localidad_detalle AND localidad_provincia_id = provincia_id				
							JOIN EL_UNICO.direccion ON SUPER_DOMICILIO = direccion_detalle AND direccion_localidad_id = localidad_id
							JOIN EL_UNICO.condicion_fiscal ON SUPER_CONDICION_FISCAL = condicion_fiscal_detalle

/*
	SELECT distinct SUPER_NOMBRE, SUPER_CUIT,SUPER_RAZON_SOC,SUPER_IIBB, SUPER_DOMICILIO, SUPER_FECHA_INI_ACTIVIDAD, SUPER_CONDICION_FISCAL
	FROM gd_esquema.Maestra 
	WHERE SUPER_NOMBRE IS NOT NULL
	--1
*/

DECLARE @cantsupers NVARCHAR(255)
SET @cantsupers = (SELECT COUNT(*) FROM [EL_UNICO].super)
PRINT('Se agregaron ' + @cantsupers + ' super')

-----------
INSERT INTO [EL_UNICO].cliente (cliente_nombre, cliente_apellido, cliente_dni, cliente_fecha_registro, cliente_telefono, cliente_mail, cliente_fecha_nacimiento, cliente_direccion_id)
	SELECT distinct CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_DNI, CLIENTE_FECHA_REGISTRO, CLIENTE_TELEFONO, CLIENTE_MAIL, CLIENTE_FECHA_NACIMIENTO, direccion_id
	FROM gd_esquema.Maestra JOIN [EL_UNICO].provincia ON CLIENTE_PROVINCIA = provincia_detalle
							JOIN [EL_UNICO].localidad ON CLIENTE_LOCALIDAD = localidad_detalle AND localidad_provincia_id = provincia_id
							JOIN [EL_UNICO].direccion ON CLIENTE_DOMICILIO = direccion_detalle AND direccion_localidad_id = localidad_id
/*
	SELECT distinct CLIENTE_NOMBRE, CLIENTE_APELLIDO, CLIENTE_DNI, CLIENTE_FECHA_REGISTRO, CLIENTE_TELEFONO, CLIENTE_MAIL, CLIENTE_FECHA_NACIMIENTO, CLIENTE_DOMICILIO
	FROM gd_esquema.Maestra
	WHERE CLIENTE_NOMBRE IS NOT NULL
	--6862
*/

DECLARE @cantclientes NVARCHAR(255)
SET @cantclientes = (SELECT COUNT(*) FROM [EL_UNICO].cliente)
PRINT('Se agregaron ' + @cantclientes + ' clientes')

------------
INSERT INTO [EL_UNICO].envio_estado (envio_estado_detalle)
	SELECT distinct ENVIO_ESTADO
	FROM gd_esquema.Maestra
	WHERE ENVIO_ESTADO IS NOT NULL

/*
	SELECT distinct ENVIO_ESTADO
	FROM gd_esquema.Maestra
	WHERE ENVIO_ESTADO IS NOT NULL
*/

DECLARE @cantEnvioEstados NVARCHAR(255)
SET @cantEnvioEstados = (SELECT COUNT(*) FROM [EL_UNICO].envio_estado)
PRINT('Se agregaron ' + @cantEnvioEstados + ' envio_estado')

------------
INSERT INTO [EL_UNICO].sucursal (sucursal_nombre, sucursal_direccion_id, sucursal_super_id)
	SELECT distinct SUCURSAL_NOMBRE, direccion_id, s.super_id
	FROM gd_esquema.Maestra M JOIN [EL_UNICO].super s ON M.SUPER_RAZON_SOC = s.super_razon_soc
							JOIN [EL_UNICO].provincia ON SUCURSAL_PROVINCIA = provincia_detalle 
							JOIN [EL_UNICO].localidad ON SUCURSAL_LOCALIDAD = localidad_detalle AND localidad_provincia_id = provincia_id
							JOIN [EL_UNICO].direccion ON SUCURSAL_DIRECCION = direccion_detalle AND direccion_localidad_id = localidad_id

/*
	SELECT distinct SUCURSAL_NOMBRE, SUCURSAL_DIRECCION, SUPER_RAZON_SOC
	FROM gd_esquema.Maestra
	WHERE SUCURSAL_NOMBRE IS NOT NULL
	---8
*/

DECLARE @cantSucursales NVARCHAR(255)
SET @cantSucursales = (SELECT COUNT(*) FROM [EL_UNICO].sucursal)
PRINT('Se agregaron ' + @cantSucursales + ' sucursales')

-----------
INSERT INTO [EL_UNICO].empleado (empleado_nombre, empleado_apellido, empleado_dni, empleado_fecha_registro, empleado_telefono, empleado_mail, empleado_fecha_nacimiento, empleado_sucursal_id)
	SELECT distinct EMPLEADO_NOMBRE, EMPLEADO_APELLIDO, EMPLEADO_DNI, EMPLEADO_FECHA_REGISTRO, EMPLEADO_TELEFONO, EMPLEADO_MAIL, EMPLEADO_FECHA_NACIMIENTO, sucursal_id
	FROM gd_esquema.Maestra M JOIN [El_UNICO].sucursal s ON M.SUCURSAL_NOMBRE = s.sucursal_nombre
	WHERE EMPLEADO_NOMBRE IS NOT NULL

/*	
	SELECT distinct EMPLEADO_NOMBRE, EMPLEADO_APELLIDO, EMPLEADO_DNI, EMPLEADO_FECHA_REGISTRO, EMPLEADO_TELEFONO, EMPLEADO_MAIL, EMPLEADO_FECHA_NACIMIENTO, SUCURSAL_NOMBRE
	FROM gd_esquema.Maestra
	WHERE EMPLEADO_NOMBRE IS NOT NULL
	--63
*/

DECLARE @cantEmpleados NVARCHAR(255)
SET @cantEmpleados = (SELECT COUNT(*) FROM [EL_UNICO].empleado)
PRINT('Se agregaron ' + @cantEmpleados + ' empleados')

-------------
INSERT INTO [EL_UNICO].tipo_caja (tipo_caja_detalle)
	SELECT distinct CAJA_TIPO
	FROM gd_esquema.Maestra
	WHERE CAJA_TIPO IS NOT NULL

/*
SELECT distinct  CAJA_NUMERO, CAJA_TIPO
	FROM gd_esquema.Maestra
	WHERE CAJA_TIPO IS NOT NULL AND CAJA_NUMERO = '10'


	SELECT distinct  CAJA_NUMERO, CAJA_TIPO
	FROM gd_esquema.Maestra
	WHERE CAJA_TIPO IS NOT NULL
	--23
*/
/*
----
SELECT t.TICKET_NUMERO, count(t.TICKET_NUMERO)
FROM (	SELECT distinct CAJA_TIPO, CAJA_NUMERO, TICKET_NUMERO
	FROM gd_esquema.Maestra
	WHERE CAJA_TIPO IS NOT NULL
	)as T
group by t.TICKET_NUMERO
order by 2 desc, 1

-- ver estos cajas y tipos
1351388438
1351465859
1351540937
.
.
.
*/
DECLARE @cantTiposDeCaja NVARCHAR(255)
SET @cantTiposDeCaja = (SELECT COUNT(*) FROM [EL_UNICO].tipo_caja)
PRINT('Se agregaron ' + @cantTiposDeCaja + ' tipos de caja')

----------
INSERT INTO [EL_UNICO].caja (caja_numero, caja_tipo_caja_id)
	SELECT distinct CAJA_NUMERO, tipo_caja_id
	FROM gd_esquema.Maestra JOIN [EL_UNICO].tipo_caja ON CAJA_TIPO = tipo_caja_detalle
	where CAJA_NUMERO is NOT NULL
/*
	SELECT distinct CAJA_NUMERO, CAJA_TIPO
	FROM gd_esquema.Maestra
	where CAJA_NUMERO is NOT NULL
	--23
*/
DECLARE @cantCajas NVARCHAR(255)
SET @cantCajas = (SELECT COUNT(*) FROM [EL_UNICO].caja)
PRINT('Se agregaron ' + @cantCajas + ' cajas')

-----------
INSERT INTO [EL_UNICO].tipo_comprobante (tipo_compr_detalle)
	SELECT distinct TICKET_TIPO_COMPROBANTE
	FROM gd_esquema.Maestra
	WHERE TICKET_TIPO_COMPROBANTE IS NOT NULL
/*
	SELECT distinct TICKET_TIPO_COMPROBANTE
	FROM gd_esquema.Maestra
	WHERE TICKET_TIPO_COMPROBANTE IS NOT NULL
*/
DECLARE @tiposDeComprobante NVARCHAR(255)
SET @tiposDeComprobante = (SELECT COUNT(*) FROM [EL_UNICO].tipo_comprobante)
PRINT('Se agregaron ' + @tiposDeComprobante + ' tipos De Comprobante')

-----------
INSERT INTO [EL_UNICO].categoria (categoria_detalle)
	SELECT distinct PRODUCTO_CATEGORIA
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_CATEGORIA IS NOT NULL
	--297119
	order by 1

DECLARE @categoriasDeProducto NVARCHAR(255)
SET @categoriasDeProducto = (SELECT COUNT(*) FROM [EL_UNICO].categoria)
PRINT('Se agregaron ' + @categoriasDeProducto + ' categorias De Producto')

INSERT INTO [EL_UNICO].subcategoria (subcategoria_detalle, subcategoria_categoria_id)
	SELECT distinct PRODUCTO_SUB_CATEGORIA, categoria_id
	FROM gd_esquema.Maestra JOIN [EL_UNICO].categoria ON PRODUCTO_CATEGORIA = categoria_detalle
/*
	SELECT distinct PRODUCTO_SUB_CATEGORIA, PRODUCTO_CATEGORIA
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_SUB_CATEGORIA IS NOT NULL
	--43
----------
SELECT T.PRODUCTO_SUB_CATEGORIA, count(T.PRODUCTO_SUB_CATEGORIA)
FROM (SELECT distinct PRODUCTO_SUB_CATEGORIA, PRODUCTO_CATEGORIA
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_SUB_CATEGORIA IS NOT NULL) as T
GROUP BY T.PRODUCTO_SUB_CATEGORIA
order by 2
-- una subcategoria puede pertencer a varias categorias
-- se tomo la decision que cada subcategoria son diferentes aun que lleven el mismo numero
SELECT distinct PRODUCTO_SUB_CATEGORIA, PRODUCTO_CATEGORIA
FROM gd_esquema.Maestra
WHERE PRODUCTO_SUB_CATEGORIA = 'SubCategoria N°1019130'
*/

DECLARE @subCategoriasDeProducto NVARCHAR(255)
SET @subCategoriasDeProducto = (SELECT COUNT(*) FROM [EL_UNICO].subcategoria)
PRINT('Se agregaron ' + @subCategoriasDeProducto + ' subcategorias De Producto')

-----------
INSERT INTO [EL_UNICO].marca (marca_detalle)
	SELECT distinct PRODUCTO_MARCA
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_MARCA IS NOT NULL
	--100

DECLARE @marcasDeProducto NVARCHAR(255)
SET @marcasDeProducto = (SELECT COUNT(*) FROM [EL_UNICO].marca)
PRINT('Se agregaron ' + @marcasDeProducto + ' marcas De Producto')

-----------
INSERT INTO [EL_UNICO].producto (producto_nombre, producto_descripcion, producto_precio, producto_marca_id, producto_subcategoria_id)
	SELECT distinct PRODUCTO_NOMBRE,PRODUCTO_DESCRIPCION, PRODUCTO_PRECIO, marca_id, subcategoria_id
	FROM gd_esquema.Maestra JOIN [EL_UNICO].marca ON PRODUCTO_MARCA = marca_detalle
							JOIN [EL_UNICO].categoria ON PRODUCTO_CATEGORIA = categoria_detalle
							JOIN [EL_UNICO].subcategoria ON PRODUCTO_SUB_CATEGORIA = subcategoria_detalle AND subcategoria_categoria_id = categoria_id
	WHERE PRODUCTO_NOMBRE IS NOT NULL 
	order by PRODUCTO_NOMBRE, subcategoria_id
/*
SELECT distinct PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_SUB_CATEGORIA, PRODUCTO_CATEGORIA, PRODUCTO_MARCA
FROM gd_esquema.Maestra 
WHERE PRODUCTO_NOMBRE IS NOT NULL 
--3742
*/

/*
--un producto es de varias categorias
SELECT t.PRODUCTO_NOMBRE, t.PRODUCTO_SUB_CATEGORIA,count(PRODUCTO_CATEGORIA)
FROM (
SELECT distinct PRODUCTO_NOMBRE,PRODUCTO_DESCRIPCION, PRODUCTO_CATEGORIA, PRODUCTO_SUB_CATEGORIA
FROM gd_esquema.Maestra 
WHERE PRODUCTO_NOMBRE IS NOT NULL 
--100 con categoria y subcategoria son 3742
) as T
group by t.PRODUCTO_NOMBRE,  t.PRODUCTO_SUB_CATEGORIA
order by 3 desc
--- ejemplo de que un producto con mismo subproductos se encuentran en categorias distintas
SELECT distinct PRODUCTO_NOMBRE,PRODUCTO_DESCRIPCION,PRODUCTO_CATEGORIA
FROM gd_esquema.Maestra 
WHERE PRODUCTO_NOMBRE = 'Codigo:0131231312'



SELECT t.PRODUCTO_NOMBRE,  t.PRODUCTO_DESCRIPCION, t.PRODUCTO_SUB_CATEGORIA, count(t.PRODUCTO_CATEGORIA), count(t.PRODUCTO_MARCA)
FROM (
SELECT distinct PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_SUB_CATEGORIA, PRODUCTO_CATEGORIA, PRODUCTO_MARCA
FROM gd_esquema.Maestra 
WHERE PRODUCTO_NOMBRE IS NOT NULL 
--100 con categoria y subcategoria son 3742
) as T
group by t.PRODUCTO_NOMBRE,  t.PRODUCTO_DESCRIPCION, t.PRODUCTO_SUB_CATEGORIA
order by count(t.PRODUCTO_MARCA) desc
*/
DECLARE @productos NVARCHAR(255)
SET @productos = (SELECT COUNT(*) FROM [EL_UNICO].producto)
PRINT('Se agregaron ' + @productos + ' productos')

--------
INSERT INTO [EL_UNICO].regla (regla_descripcion, regla_descuento_aplicable_prod, regla_cant_aplicable_regla, regla_cant_aplica_descuento, regla_cant_max_prod, regla_aplica_misma_marca, regla_aplica_mismo_prod)
	SELECT distinct REGLA_DESCRIPCION, REGLA_DESCUENTO_APLICABLE_PROD, REGLA_CANT_APLICABLE_REGLA, REGLA_CANT_APLICA_DESCUENTO, REGLA_CANT_MAX_PROD, REGLA_APLICA_MISMA_MARCA, REGLA_APLICA_MISMO_PROD
	FROM gd_esquema.Maestra
	WHERE REGLA_DESCRIPCION IS NOT NULL
/*
--esta promocion tiene 3 reglas
SELECT distinct PROMOCION_DESCRIPCION, PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN, REGLA_DESCRIPCION
FROM gd_esquema.Maestra
where PROMOCION_DESCRIPCION is not null AND PROMOCION_FECHA_INICIO = '2024-06-10 00:00:00.000' AND PROMOCION_FECHA_FIN = '2024-06-17 00:00:00.000'

--esta regla tiene 44 promo1
SELECT distinct PROMOCION_DESCRIPCION, PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN ,REGLA_DESCRIPCION
FROM gd_esquema.Maestra
where PROMOCION_DESCRIPCION is not null AND REGLA_DESCRIPCION = 'Descuento Producto Unico'
*/
DECLARE @reglas NVARCHAR(255)
SET @reglas = (SELECT COUNT(*) FROM [EL_UNICO].regla)
PRINT('Se agregaron ' + @reglas + ' reglas')

-------
INSERT INTO [EL_UNICO].promocion (promocion_descripcion, promocion_fecha_inicio, promocion_fecha_fin)
	SELECT distinct PROMOCION_DESCRIPCION, PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN
	FROM gd_esquema.Maestra
	WHERE PROMOCION_DESCRIPCION IS NOT NULL
	--44
DECLARE @promociones NVARCHAR(255)
SET @promociones = (SELECT COUNT(*) FROM [EL_UNICO].promocion)
PRINT('Se agregaron ' + @promociones + ' promociones')

---------
INSERT INTO [EL_UNICO].promocion_x_regla (promocion_id,regla_id)
	SELECT distinct promocion_id, regla_id
	FROM gd_esquema.Maestra M JOIN [EL_UNICO].promocion p ON M.PROMOCION_DESCRIPCION = p.promocion_descripcion AND M.PROMOCION_FECHA_INICIO = p.promocion_fecha_inicio AND M.PROMOCION_FECHA_FIN = p.promocion_fecha_fin
							  JOIN [EL_UNICO].regla r ON M.REGLA_DESCRIPCION = r.regla_descripcion AND M.REGLA_DESCUENTO_APLICABLE_PROD = r.regla_descuento_aplicable_prod AND M.REGLA_CANT_APLICABLE_REGLA = r.regla_cant_aplicable_regla AND M.REGLA_CANT_APLICA_DESCUENTO = r.regla_cant_aplica_descuento AND M.REGLA_CANT_MAX_PROD = r.regla_cant_max_prod AND M.REGLA_APLICA_MISMA_MARCA = r.regla_aplica_misma_marca AND M.REGLA_APLICA_MISMO_PROD = r.regla_aplica_mismo_prod

/*SELECT distinct PROMOCION_DESCRIPCION, PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN, REGLA_DESCRIPCION, REGLA_APLICA_MISMA_MARCA, REGLA_APLICA_MISMO_PROD
FROM gd_esquema.Maestra
where PROMOCION_DESCRIPCION is not null
--132

---como se observa con esto todos las promociones tienen 3 reglas 
SELECT t.PROMOCION_DESCRIPCION, t.PROMOCION_FECHA_INICIO, t.PROMOCION_FECHA_FIN, count(t.REGLA_DESCRIPCION)
FROM (SELECT distinct PROMOCION_DESCRIPCION, PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN, REGLA_DESCRIPCION
	FROM gd_esquema.Maestra
	where PROMOCION_DESCRIPCION is not null) as t
GROUP BY t.PROMOCION_DESCRIPCION, t.PROMOCION_FECHA_INICIO, t.PROMOCION_FECHA_FIN
*/
DECLARE @promocion_X_regla NVARCHAR(255)
SET @promocion_X_regla = (SELECT COUNT(*) FROM [EL_UNICO].promocion_x_regla)
PRINT('Se agregaron: ' + @promocion_X_regla + ' promocion_x_regla' + ' hay 44 promociones y 3 reglas, lo que significa que cada promocion tiene todas las reglas')

--------
INSERT INTO [EL_UNICO].promocion_x_producto (producto_id, promocion_id)
	SELECT distinct producto_id, promocion_id
	FROM gd_esquema.Maestra M JOIN [EL_UNICO].categoria ON M.PRODUCTO_CATEGORIA = categoria_detalle
							  JOIN [EL_UNICO].subcategoria ON M.PRODUCTO_SUB_CATEGORIA = subcategoria_detalle AND subcategoria_categoria_id = categoria_id
							  JOIN [EL_UNICO].marca ON m.PRODUCTO_MARCA = marca_detalle
							  JOIN [EL_UNICO].producto prod ON M.PRODUCTO_NOMBRE = prod.producto_nombre AND M.PRODUCTO_DESCRIPCION = prod.producto_descripcion AND  M.PRODUCTO_PRECIO = prod.producto_precio AND prod.producto_marca_id = marca_id AND prod.producto_subcategoria_id = subcategoria_id
							  JOIN [EL_UNICO].promocion p ON M.PROMOCION_DESCRIPCION = p.promocion_descripcion AND M.PROMOCION_FECHA_INICIO = p.promocion_fecha_inicio AND M.PROMOCION_FECHA_FIN = P.promocion_fecha_fin
/*
SELECT distinct PROMOCION_DESCRIPCION, PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN, PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_MARCA, PRODUCTO_SUB_CATEGORIA,PRODUCTO_CATEGORIA
FROM gd_esquema.Maestra
where PROMOCION_DESCRIPCION is not null
--57458

--------- ejemplo de que un producto puede tener varias promociones aplicadas
SELECT distinct PROMOCION_DESCRIPCION, PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN, PRODUCTO_NOMBRE, PRODUCTO_DESCRIPCION, PRODUCTO_MARCA, PRODUCTO_SUB_CATEGORIA,PRODUCTO_CATEGORIA
FROM gd_esquema.Maestra
where PROMOCION_DESCRIPCION is not null AND PRODUCTO_NOMBRE = 'Codigo:0131231312' AND PRODUCTO_DESCRIPCION = 'Descripcion del Producto N°:0131231312' AND PRODUCTO_MARCA = 'Marca N°1213414124' AND PRODUCTO_SUB_CATEGORIA = 'SubCategoria N°1019132' AND PRODUCTO_CATEGORIA = 'Categoria N°1241412'
------- verificacion en nuestra nueva tabla
SELECT *
FROM [EL_UNICO].promocion_x_producto
WHERE producto_id = 7
*/
DECLARE @promocion_x_producto NVARCHAR(255)
SET @promocion_x_producto = (SELECT COUNT(*) FROM [EL_UNICO].promocion_x_producto)
PRINT('Se agregaron ' + @promocion_x_producto + ' promocion_x_producto' + ' hay 3742 productos y 44 promociones, lo que significa que un producto No tiene todas las promociones')

/*
---------
SELECT T.TICKET_NUMERO ,T.TICKET_DET_CANTIDAD, T.TICKET_DET_PRECIO, T.TICKET_DET_TOTAL, count(T.PROMO_CODIGO)
FROM(
SELECT distinct TICKET_NUMERO, TICKET_DET_CANTIDAD, TICKET_DET_PRECIO, TICKET_DET_TOTAL, PROMO_CODIGO
FROM gd_esquema.Maestra
WHERE TICKET_DET_CANTIDAD IS NOT NULL) AS T
GROUP BY T.TICKET_NUMERO, T.TICKET_DET_CANTIDAD, T.TICKET_DET_PRECIO, T.TICKET_DET_TOTAL
---37375


--- todos los ticket datalles
SELECT distinct TICKET_NUMERO,PRODUCTO_NOMBRE ,TICKET_DET_CANTIDAD, TICKET_DET_PRECIO, TICKET_DET_TOTAL, PROMO_CODIGO, PROMO_APLICADA_DESCUENTO
FROM gd_esquema.Maestra
WHERE TICKET_DET_CANTIDAD IS NOT NULL
ORDER BY 1, PROMO_CODIGO desc
--273177
*/

--- 
/*
SELECT  t.ticket_numero, count(t.PRODUCTO_NOMBRE), count(t.promo_codigo)
FROM 
(SELECT distinct TICKET_NUMERO,PRODUCTO_NOMBRE ,TICKET_DET_CANTIDAD, TICKET_DET_PRECIO, TICKET_DET_TOTAL, PROMO_CODIGO, PROMO_APLICADA_DESCUENTO
FROM gd_esquema.Maestra
WHERE TICKET_DET_CANTIDAD IS NOT NULL
) as t
group by t.ticket_numero
order by 3 desc
--hay dos casos para ver con ticket_numero = 1351344648 ó 1352226127
-- el tercer caso tiene...
SELECT distinct TICKET_NUMERO, PRODUCTO_NOMBRE, PRODUCTO_MARCA,PRODUCTO_SUB_CATEGORIA,PROMOCION_DESCRIPCION,PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN,TICKET_DET_PRECIO, TICKET_DET_CANTIDAD, TICKET_DET_TOTAL, PROMO_CODIGO, PROMO_APLICADA_DESCUENTO
FROM gd_esquema.Maestra
WHERE TICKET_NUMERO = '1351344648' OR TICKET_NUMERO = '1352226127' OR TICKET_NUMERO = '1354176996'
order by TICKET_NUMERO, PROMO_CODIGO
*/
/*
--- hablamos de un ticket especifico de un producto especifico cuantos codigos tiene
SELECT TICKET_NUMERO, PRODUCTO_NOMBRE, PRODUCTO_MARCA, PRODUCTO_SUB_CATEGORIA, count(PROMO_CODIGO)
FROM (SELECT distinct TICKET_NUMERO, PRODUCTO_NOMBRE, PRODUCTO_MARCA, PRODUCTO_SUB_CATEGORIA,PROMOCION_DESCRIPCION,PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN,TICKET_DET_PRECIO, TICKET_DET_CANTIDAD, TICKET_DET_TOTAL, PROMO_CODIGO, PROMO_APLICADA_DESCUENTO
FROM gd_esquema.Maestra
) as T
GRoup by TICKET_NUMERO, PRODUCTO_NOMBRE, PRODUCTO_MARCA, PRODUCTO_SUB_CATEGORIA
order by count(PROMO_CODIGO) desc

--- Revisar este ticket
SELECT distinct TICKET_NUMERO, PRODUCTO_NOMBRE, PRODUCTO_MARCA, PRODUCTO_SUB_CATEGORIA,PROMOCION_DESCRIPCION,PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN,TICKET_DET_PRECIO, TICKET_DET_CANTIDAD, TICKET_DET_TOTAL, PROMO_CODIGO, PROMO_APLICADA_DESCUENTO
SELECT *
FROM gd_esquema.Maestra
WHERE TICKET_NUMERO = '1354176996' AND PRODUCTO_NOMBRE ='Codigo:6131231312'

SELECT *
FROM gd_esquema.Maestra
WHERE TICKET_NUMERO = '1354176996' 
*/

-----------
INSERT INTO [EL_UNICO].promo (promo_codigo, promo_aplica_descuento)
	SELECT distinct PROMO_CODIGO, PROMO_APLICADA_DESCUENTO
	FROM gd_esquema.Maestra
	WHERE PROMO_CODIGO IS NOT NULL
	order by 1

	/*
	antes -- 132
	ahora -- 94341
	*/

DECLARE @promo_codigo NVARCHAR(255)
SET @promo_codigo = (SELECT COUNT(*) FROM [EL_UNICO].promo)
PRINT('Se agregaron ' + @promo_codigo + ' promo_codigo')


-----------
INSERT INTO [EL_UNICO].tipo_medio_pago 
	SELECT distinct PAGO_TIPO_MEDIO_PAGO
	FROM gd_esquema.Maestra
	WHERE PAGO_TIPO_MEDIO_PAGO IS NOT NULL

DECLARE @tipos_de_medio_de_pago NVARCHAR(255)
SET @tipos_de_medio_de_pago = (SELECT COUNT(*) FROM [EL_UNICO].tipo_medio_pago)
PRINT('Se agregaron ' + @tipos_de_medio_de_pago + ' tipos de medio de pago')

-----------
INSERT INTO [EL_UNICO].medio_de_pago(medio_pago_detalle, medio_pago_tipo_id)
	SELECT distinct PAGO_MEDIO_PAGO, tipo_medio_pago_id
	FROM gd_esquema.Maestra JOIN [EL_UNICO].tipo_medio_pago ON PAGO_TIPO_MEDIO_PAGO = tipo_medio_pago_detalle
	WHERE PAGO_MEDIO_PAGO is not null 
/*
SELECT distinct PAGO_MEDIO_PAGO, PAGO_TIPO_MEDIO_PAGO
FROM gd_esquema.Maestra
WHERE PAGO_MEDIO_PAGO is not null
--7
*/
DECLARE @medios_de_pago NVARCHAR(255)
SET @medios_de_pago = (SELECT COUNT(*) FROM [EL_UNICO].medio_de_pago)
PRINT('Se agregaron ' + @medios_de_pago + ' medios de pago')

/*
---- un descuento codigo se utiliza en varios medios de pago
SELECT T.DESCUENTO_CODIGO, COUNT(T.DESCUENTO_CODIGO)
FROM (
SELECT distinct PAGO_MEDIO_PAGO, PAGO_TIPO_MEDIO_PAGO, DESCUENTO_DESCRIPCION, DESCUENTO_CODIGO
FROM gd_esquema.Maestra
WHERE PAGO_MEDIO_PAGO is not null) as T
GROUP BY DESCUENTO_CODIGO
Order by COUNT(T.DESCUENTO_CODIGO) desc
--todos 1 ok

-- ejempplo de que un ticket, relamente deberian ser dos tickets
SELECT PAGO_MEDIO_PAGO, PAGO_TIPO_MEDIO_PAGO, DESCUENTO_DESCRIPCION, DESCUENTO_CODIGO, PAGO_DESCUENTO_APLICADO, TICKET_TOTAL_ENVIO,TICKET_TOTAL_DESCUENTO_APLICADO_MP, TICKET_TOTAL_TICKET
FROM gd_esquema.Maestra
WHERE TICKET_NUMERO = '1351465859'

SELECT PAGO_TARJETA_NRO, count(PAGO_TARJETA_NRO)
FROM(
SELECT distinct PAGO_MEDIO_PAGO, PAGO_TARJETA_NRO
FROM gd_esquema.Maestra) as t
GROUP BY PAGO_TARJETA_NRO
order by 2 desc
-----------------
demostracion que con una tarjeta solo se hizo un pago
SELECT TICKET_NUMERO, count(ticket_numero)
FROM(
SELECT distinct TICKET_NUMERO, PAGO_IMPORTE, TICKET_TOTAL_TICKET,PAGO_TARJETA_NRO 
FROM gd_esquema.Maestra
WHERE TICKET_NUMERO IS NOT NULL AND PAGO_IMPORTE IS NOT NULL  AND PAGO_TARJETA_NRO IS NOT NULL ) as t
GROUP BY TICKET_NUMERO
order by TICKET_NUMERO desc
*/
/*
------------para ver que hay ticket numeros que se pagaron en varias formas de pago
SELECT z.ticket_numero, z.TICKET_TOTAL_ENVIO ,count(z.TICKET_NUMERO)
FROM (
SELECT distinct TICKET_NUMERO, PAGO_MEDIO_PAGO, PAGO_TIPO_MEDIO_PAGO, TICKET_TOTAL_ENVIO
FROM gd_esquema.Maestra 
WHERE PAGO_MEDIO_PAGO IS NOT NULL AND PAGO_TIPO_MEDIO_PAGO IS NOT NULL) as z
GROUP BY z.TICKET_NUMERO, z.TICKET_TOTAL_ENVIO
Order by 3 desc, 1

-- un ticket fue pagado con tarjeta de credito y debito
SELECT distinct TICKET_NUMERO, PAGO_MEDIO_PAGO, PAGO_TIPO_MEDIO_PAGO
FROM gd_esquema.Maestra 
WHERE TICKET_NUMERO = '1351465859'

-- un ticket fue pagado con tarjeta de debito y billera virtual
SELECT distinct TICKET_NUMERO, PAGO_MEDIO_PAGO, PAGO_TIPO_MEDIO_PAGO
FROM gd_esquema.Maestra 
WHERE TICKET_NUMERO = '1351540937'
*/

------------
INSERT INTO [EL_UNICO].descuento(descuento_codigo, descuento_Descripcion, descuento_fecha_inicio, descuento_fecha_fin, descuento_porcentaje_desc, descuento_tope)
	SELECT distinct DESCUENTO_CODIGO, DESCUENTO_DESCRIPCION,  DESCUENTO_FECHA_INICIO, DESCUENTO_FECHA_FIN, DESCUENTO_PORCENTAJE_DESC, DESCUENTO_TOPE
	FROM gd_esquema.Maestra
	WHERE DESCUENTO_CODIGO  IS NOT NULL
	--308 descuento_codigo y con todo distinto siguen siendo 308
	order by 1

DECLARE @descuentos NVARCHAR(255)
SET @descuentos = (SELECT COUNT(*) FROM [EL_UNICO].descuento)
PRINT('Se agregaron ' + @descuentos + ' descuentos')

------------
INSERT INTO [EL_UNICO].descuento_x_medio_de_pago(descuento_codigo, medio_de_pago_id)
	SELECT distinct DESCUENTO_CODIGO, medio_pago_id
	FROM gd_esquema.Maestra JOIN [EL_UNICO].tipo_medio_pago ON PAGO_TIPO_MEDIO_PAGO = tipo_medio_pago_detalle 
							JOIN [EL_UNICO].medio_de_pago ON PAGO_MEDIO_PAGO = medio_pago_detalle AND medio_pago_tipo_id = tipo_medio_pago_id
/*
	SELECT distinct DESCUENTO_CODIGO, PAGO_MEDIO_PAGO 
	FROM gd_esquema.Maestra
	WHERE DESCUENTO_CODIGO IS NOT NULL
	order by 1
	--308  sin el distinct 17068 
*/

DECLARE @descuentos_x_medio_de_pago NVARCHAR(255)
SET @descuentos_x_medio_de_pago = (SELECT COUNT(*) FROM [EL_UNICO].descuento_x_medio_de_pago)
PRINT('Se agregaron ' + @descuentos_x_medio_de_pago + ' descuentos_x_medio_de_pago, significa que un descuento esta aplicada en un solo medio de pago, segun la base de datos antigua')

------------
/*
INSERT INTO [EL_UNICO].tarjeta(pago_tarjeta_nro, pago_tarjetas_cuotas, pago_tarjetas_fecha_venc)
	SELECT distinct PAGO_TARJETA_NRO, PAGO_TARJETA_CUOTAS, PAGO_TARJETA_FECHA_VENC
	FROM gd_esquema.Maestra
	WHERE PAGO_TARJETA_NRO IS NOT NULL
	--14553

DECLARE @tarjetas NVARCHAR(255)
SET @tarjetas = (SELECT COUNT(*) FROM [EL_UNICO].tarjeta)
PRINT('Se agregaron ' + @tarjetas + ' tarjetas')
*/
----------

INSERT INTO [EL_UNICO].ticket(ticket_numero, ticket_fecha_hora, ticket_tipo_comprobante_id, ticket_caja_id, ticket_empleado_id, ticket_sucursal_id, ticket_subtotal_productos, ticket_total_envio, ticket_total_descuento_aplicado, ticket_total_descuento_aplicado_mp,ticket_total_ticket)
	SELECT distinct TICKET_NUMERO, TICKET_FECHA_HORA, tipo_compr_id, caja_id, empleado_id, sucursal_id,  TICKET_SUBTOTAL_PRODUCTOS, TICKET_TOTAL_ENVIO, TICKET_TOTAL_DESCUENTO_APLICADO, TICKET_TOTAL_DESCUENTO_APLICADO_MP, TICKET_TOTAL_TICKET
	FROM gd_esquema.Maestra M JOIN [EL_UNICO].sucursal s ON M.SUCURSAL_NOMBRE = s.sucursal_nombre 
							  JOIN [EL_UNICO].empleado e ON M.EMPLEADO_NOMBRE = e.empleado_nombre AND M.EMPLEADO_APELLIDO = e.empleado_apellido AND M.EMPLEADO_DNI = e.empleado_dni
							  JOIN [EL_UNICO].tipo_caja ON CAJA_TIPO = tipo_caja_detalle
							  JOIN [EL_UNICO].caja c ON M.CAJA_NUMERO = c.caja_numero AND caja_tipo_caja_id = tipo_caja_id
							  JOIN [EL_UNICO].tipo_comprobante ON TICKET_TIPO_COMPROBANTE = tipo_compr_detalle
	WHERE TICKET_NUMERO IS NOT NULL
	
/*
--- select completo
SELECT distinct TICKET_NUMERO, TICKET_FECHA_HORA, TICKET_TIPO_COMPROBANTE, NULL as caja_id, NULL as empleado, NULL as sucursal,  TICKET_SUBTOTAL_PRODUCTOS, TICKET_TOTAL_ENVIO, TICKET_TOTAL_DESCUENTO_APLICADO, TICKET_TOTAL_DESCUENTO_APLICADO_MP, TICKET_TOTAL_TICKET, NULL as envio_id
FROM gd_esquema.Maestra
WHERE TICKET_NUMERO IS NOT NULL
--17068 con todas las restricciones conocidas nos da 

--verificacion
	SELECT *
	FROM gd_esquema.Maestra	
	WHERE TICKET_NUMERO IS NOT NULL AND TICKET_NUMERO = '1354621475'
--
*/

DECLARE @tickets NVARCHAR(255)
SET @tickets = (SELECT COUNT(*) FROM [EL_UNICO].ticket)
PRINT('Se agregaron ' + @tickets + ' tickets')

----------
	/*


	--priemra iteracion
	SELECT distinct TICKET_NUMERO	
	FROM gd_esquema.Maestra
	WHERE TICKET_NUMERO IS NOT NULL
	--17025 ticket_numero distintos

	SELECT distinct TICKET_NUMERO, TICKET_TOTAL_ENVIO
	FROM gd_esquema.Maestra
	WHERE TICKET_NUMERO IS NOT NULL
	--con la restriccion del envio hay 17051

	SELECT distinct TICKET_NUMERO, TICKET_TOTAL_ENVIO, TICKET_TIPO_COMPROBANTE
	FROM gd_esquema.Maestra
	WHERE TICKET_NUMERO IS NOT NULL
	--con la restriccion del envio y el tipo de comprobante hay 17060

	SELECT distinct TICKET_NUMERO, TICKET_TOTAL_ENVIO, TICKET_TIPO_COMPROBANTE, ticket_fecha_hora
	FROM gd_esquema.Maestra
	WHERE TICKET_NUMERO IS NOT NULL
	--con la restriccion del envio y el tipo de comprobante y la fecha hay 17068

	-------------- otra forma mas rapida de llegar
	SELECT distinct TICKET_NUMERO, TICKET_FECHA_HORA
	FROM gd_esquema.Maestra
	WHERE TICKET_NUMERO IS NOT NULL
	order by 1
	--con la restriccion de la fecha hay 17068
	
	
	SELECT EMPLEADO_APELLIDO, EMPLEADO_DNI, CLIENTE_APELLIDO, CLIENTE_DNI
	FROM gd_esquema.Maestra	
	WHERE TICKET_NUMERO IS NOT NULL AND TICKET_NUMERO = '1354621475'

	*/

----------
	INSERT INTO [EL_UNICO].envio (envio_fecha_programada, envio_hora_inicio, envio_hora_fin, envio_cliente_id, envio_ticket_id, envio_costo, envio_envio_estado_id, envio_fecha_entrega)
	SELECT distinct ENVIO_FECHA_PROGRAMADA, ENVIO_HORA_INICIO, ENVIO_HORA_FIN, cliente_id, ticket_id, ENVIO_COSTO, envio_estado_id, ENVIO_FECHA_ENTREGA
	FROM gd_esquema.Maestra M JOIN [EL_UNICO].cliente c ON M.CLIENTE_APELLIDO = c.cliente_apellido AND M.CLIENTE_NOMBRE = c.cliente_nombre AND M.CLIENTE_DNI = c.cliente_dni
							  JOIN [EL_UNICO].ticket t ON M.TICKET_NUMERO = t.ticket_numero AND M.ticket_fecha_hora = t.ticket_fecha_hora
							  JOIN [EL_unico].envio_estado ON ENVIO_ESTADO = envio_estado_detalle

/*
	SELECT distinct ENVIO_FECHA_PROGRAMADA, ENVIO_HORA_INICIO, ENVIO_HORA_FIN, CLIENTE_DNI, ENVIO_COSTO, ENVIO_ESTADO, ENVIO_FECHA_ENTREGA
	FROM gd_esquema.Maestra 
	WHERE ENVIO_FECHA_PROGRAMADA IS NOT NULL 	
	order by 1
	---- 6862 ojo hay ticket_numero con dos envios 

SELECT t.TICKET_NUMERO, count(t.TICKET_NUMERO)
FROM (SELECT distinct TICKET_NUMERO,ENVIO_FECHA_PROGRAMADA, ENVIO_HORA_INICIO, ENVIO_HORA_FIN, null as cliente, ENVIO_COSTO, ENVIO_ESTADO, ENVIO_FECHA_ENTREGA
	FROM gd_esquema.Maestra 
	WHERE ENVIO_FECHA_PROGRAMADA IS NOT NULL 	
	---6862
	) AS T
group by t.TICKET_NUMERO
order by 2 desc
 revisar estos casos de ticket_numero:

1352902143
1353200657-- unico que no tiene dos medios de pago
1353794555
1353722924
1354396504

por lo que el ticket numero No va hacer lo mismo que ticket_id
*/
DECLARE @cantEnvios NVARCHAR(255)
SET @cantEnvios = (SELECT COUNT(*) FROM [EL_UNICO].envio)
PRINT('Se agregaron ' + @cantEnvios + ' envios')

-------------
INSERT INTO [EL_UNICO].pago(pago_ticket_id, pago_fecha, pago_medio_pago_id, pago_descuento_aplicado, pago_importe, pago_tarjeta_nro, pago_tarjetas_cuotas, pago_tarjetas_fecha_venc)
	SELECT ticket_id, PAGO_FECHA, medio_pago_id, PAGO_DESCUENTO_APLICADO, PAGO_IMPORTE, PAGO_TARJETA_NRO, PAGO_TARJETA_CUOTAS,PAGO_TARJETA_FECHA_VENC
	FROM gd_esquema.Maestra M JOIN [EL_UNICO].ticket t ON M.TICKET_NUMERO = t.ticket_numero AND M.ticket_fecha_hora = t.ticket_fecha_hora
							  JOIN [EL_UNICO].medio_de_pago ON PAGO_MEDIO_PAGO = medio_pago_detalle --verificar si es necesario expandir
							  --LEFT JOIN [EL_UNICO].tarjeta ta ON M.PAGO_TARJETA_NRO = ta.pago_tarjeta_nro

/*
SELECT distinct PAGO_FECHA, PAGO_IMPORTE, PAGO_MEDIO_PAGO, PAGO_TIPO_MEDIO_PAGO, PAGO_TARJETA_NRO, PAGO_DESCUENTO_APLICADO, PAGO_TARJETA_CUOTAS, PAGO_TARJETA_FECHA_VENC
FROM gd_esquema.Maestra
WHERE PAGO_FECHA is not null
--17068
*/

DECLARE @pagos NVARCHAR(255)
SET @pagos = (SELECT COUNT(*) FROM [EL_UNICO].pago)
PRINT('Se agregaron ' + @pagos + ' pagos')

-------------
INSERT INTO [EL_UNICO].ticket_detalle(ticket_id, prodcuto_id, ticket_det_cantidad, ticket_det_precio, ticket_det_total, ticket_det_promo_id)
	SELECT distinct ticket_id, producto_id, TICKET_DET_CANTIDAD, TICKET_DET_PRECIO, TICKET_DET_TOTAL, pr.promo_id 
	FROM gd_esquema.Maestra M LEFT JOIN [EL_UNICO].ticket t ON M.TICKET_NUMERO = t.ticket_numero AND M.ticket_fecha_hora = t.ticket_fecha_hora
							  JOIN [EL_UNICO].marca ON M.PRODUCTO_MARCA = marca_detalle
							  JOIN [EL_UNICO].categoria ON M.PRODUCTO_CATEGORIA = categoria_detalle
							  JOIN [EL_UNICO].subcategoria ON M.PRODUCTO_SUB_CATEGORIA = subcategoria_detalle AND subcategoria_categoria_id = categoria_id
							  JOIN [EL_UNICO].producto p ON M.PRODUCTO_NOMBRE = p.producto_nombre AND M.PRODUCTO_DESCRIPCION = p.producto_descripcion AND p.producto_marca_id = marca_id AND  p.producto_subcategoria_id = subcategoria_id 
							  LEFT JOIN [EL_UNICO].promo pr ON M.PROMO_CODIGO = pr.promo_codigo AND M.PROMO_APLICADA_DESCUENTO = pr.promo_aplica_descuento

/*							  
-- cantidad total de detalles ticket hay
SELECT distinct TICKET_NUMERO, TICKET_FECHA_HORA, TICKET_DET_CANTIDAD, TICKET_DET_PRECIO, TICKET_DET_TOTAL, PROMO_CODIGO, PROMO_APLICADA_DESCUENTO
FROM gd_esquema.Maestra
WHERE TICKET_DET_CANTIDAD is not null AND TICKET_DET_PRECIO is not null AND TICKET_DET_TOTAL is not null
--273177

---------------------------------
SELECT t.ticket_numero, t.ticket_fecha_hora, td.ticket_det_cantidad, td.ticket_det_precio, td.ticket_det_total, promo_codigo, promo_aplica_descuento
FROM [EL_UNICO].ticket_detalle td JOIN [EL_UNICO].ticket t ON td.ticket_id = t.ticket_id
								  LEFT JOIN [EL_UNICO].promo ON td.ticket_det_promo_id = promo_id
								  -- recordatorio usar left join
--273177


--273177
--encontre los repetidos don 12 elementos por ejemplo el ticket_numero:
		ticket_numero = 1352626547 
		ticket_fecha_hora = 2024-04-29 09:00:00.000 
		ticket_det_cantidad = 7 
		ticket_det_precio = 2767.28 
		ticket_det_total = 19370.96 

--informacion de ese ticket
SELECt *
FROM [EL_UNICO].ticket
WHERE ticket_numero = '1352626547'
-- 
SELECT *
FROM [EL_UNICO].ticket_detalle
WHERE ticket_id = 2362


*/



DECLARE @ticket_detalles NVARCHAR(255)
SET @ticket_detalles = (SELECT COUNT(*) FROM [EL_UNICO].ticket_detalle)
PRINT('Se agregaron ' + @ticket_detalles + ' ticket_detalles')



-------------
PRINT('')
PRINT('SE LLENARON LAS TABLAS :)')
GO
--/llenado de tablas

/*
SELECT t.TICKET_NUMERO, count(t.TICKET_NUMERO)
FROM (	SELECT distinct TICKET_NUMERO, CAJA_TIPO, CAJA_NUMERO, SUCURSAL_NOMBRE
	FROM gd_esquema.Maestra
	WHERE CAJA_TIPO IS NOT NULL
	--17067
	)as T
group by t.TICKET_NUMERO
order by 2 desc


	SELECT distinct TICKET_NUMERO, CAJA_TIPO, CAJA_NUMERO, SUCURSAL_NOMBRE, EMPLEADO_DNI, EMPLEADO_NOMBRE, PAGO_MEDIO_PAGO
	FROM gd_esquema.Maestra
	WHERE CAJA_TIPO IS NOT NULL AND TICKET_NUMERO = '1353200657'

SELECT t.TICKET_NUMERO, count(t.TICKET_NUMERO)
FROM
	(SELECT distinct TICKET_NUMERO, PAGO_MEDIO_PAGO
	FROM gd_esquema.Maestra
	--WHERE TICKET_NUMERO  IS NOT NULL AND PAGO_MEDIO_PAGO IS NOT NULL
	WHERE TICKET_NUMERO='1353722924'
	) as T
group by t.TICKET_NUMERO
order by 2 desc, 1 asc
---17025
1351388438
1351465859
1351540937
1351619543
1351697358
1351774386
1351846017
1351922262
1351996182
1352070102
1352147917
1352305130
1352375255
1352454258
1352525134
1352828607
1352902143
1352979564
1353057379  
1353127504
1353278472
1353350482
1353500738
1353571991
1353647069
1353722924
1353794555
1353870800
1353943190
1354018656
1354097262
1354250946
1354322199
1354396504
1354474714
1354551350
*/

/*
--CUANDO REVISES UN TICKET NUMERO ESPECIFICO REVISAR ESTO
SELECT *
FROM gd_esquema.Maestra
WHERE TICKET_NUMERO = '1354176996'
-- difieree en: ticket_det_cantidad,..det..,empleado_nombre, pago_fecha, pago...,
*/

/*
ver este caso tambien:
la tabla antigua te trae dos datos iguales
SELECT *
FROM gd_esquema.Maestra
WHERE ticket_numero = 1352626547 AND ticket_fecha_hora = '2024-04-29 09:00:00.000' AND ticket_det_cantidad = 7 AND ticket_det_precio = 2767.28 AND ticket_det_total = 19370.96 

para encontrarlo use con la tabla ticket detalle sin distinct en su creacion
SELECT z.ticket_numero, z.ticket_fecha_hora, z.ticket_det_cantidad, z.ticket_det_precio, z.ticket_det_total, count(z.ticket_numero)
FROM (
SELECT t.ticket_numero, t.ticket_fecha_hora, td.ticket_det_cantidad, td.ticket_det_precio, td.ticket_det_total--, promo_codigo, promo_aplica_descuento
FROM [EL_UNICO].ticket_detalle td JOIN [EL_UNICO].ticket t ON td.ticket_id = t.ticket_id
								  --JOIN [EL_UNICO].promo ON td.ticket_det_promo_id = promo_id
--273189
--EXCEPT
)as z
GROUP by z.ticket_numero, z.ticket_fecha_hora, z.ticket_det_cantidad, z.ticket_det_precio, z.ticket_det_total
order by count(z.ticket_numero) desc

*/