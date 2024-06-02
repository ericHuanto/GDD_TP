USE GD1C2024
GO

--eliminacion de tablas ------------ se borran primero las que estan en centro y por ultimo los extremos
IF OBJECT_ID('EL_UNICO.empleado', 'U') IS NOT NULL DROP TABLE EL_UNICO.empleado
IF OBJECT_ID('EL_UNICO.sucursal', 'U') IS NOT NULL DROP TABLE EL_UNICO.sucursal
IF OBJECT_ID('EL_UNICO.super', 'U') IS NOT NULL DROP TABLE EL_UNICO.super
IF OBJECT_ID('EL_UNICO.condicion_fiscal', 'U') IS NOT NULL DROP TABLE EL_UNICO.condicion_fiscal
IF OBJECT_ID('EL_UNICO.cliente', 'U') IS NOT NULL DROP TABLE EL_UNICO.cliente
IF OBJECT_ID('EL_UNICO.direccion', 'U') IS NOT NULL DROP TABLE EL_UNICO.direccion
IF OBJECT_ID('EL_UNICO.localidad', 'U') IS NOT NULL DROP TABLE EL_UNICO.localidad
IF OBJECT_ID('EL_UNICO.provincia', 'U') IS NOT NULL DROP TABLE EL_UNICO.provincia
IF OBJECT_ID('EL_UNICO.envio', 'U') IS NOT NULL DROP TABLE EL_UNICO.envio
IF OBJECT_ID('EL_UNICO.envio_estado', 'U') IS NOT NULL DROP TABLE EL_UNICO.envio_estado
IF OBJECT_ID('EL_UNICO.caja', 'U') IS NOT NULL DROP TABLE EL_UNICO.caja
IF OBJECT_ID('EL_UNICO.tipo_caja', 'U') IS NOT NULL DROP TABLE EL_UNICO.tipo_caja


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
CREATE SCHEMA EL_UNICO;
GO
PRINT('SE CREO EL SCHEMA');
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

CREATE TABLE [EL_UNICO].envio (
  envio_id decimal(18,0) IDENTiTY(1,1), /*PK*/
  envio_fecha_programada datetime NOT NULL,
  envio_hora_inicio decimal(18,0),
  envio_hora_fin decimal(18,0),
  envio_cliente_id decimal(18,0) NULL, /*FK*/
  envio_costo decimal(18,2) NOT NULL,
  envio_envio_estado_id decimal(18,0), /*FK*/
  envio_fecha_entrega datetime NOT NULL,
  envio_tarjeta_id decimal(18,0), /*FK*/
  CHECK(envio_hora_inicio < envio_hora_fin)
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
  caja_numero decimal(18,0) NOT NULL, /*PK*/
  caja_tipo_caja_id decimal(18,0) NOT NULL, /*FK*/
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
ALTER TABLE [EL_UNICO].tipo_caja ADD CONSTRAINT PK_tipo_caja PRIMARY KEY(tipo_caja_id)
ALTER TABLE [EL_UNICO].caja ADD CONSTRAINT PK_caja PRIMARY KEY(caja_numero, caja_tipo_caja_id)
GO

--agregado de FK-------------
ALTER TABLE [EL_UNICO].localidad ADD CONSTRAINT FK_loc_provincia FOREIGN KEY(localidad_provincia_id) REFERENCES [EL_UNICO].provincia(provincia_id);
ALTER TABLE [EL_UNICO].direccion ADD CONSTRAINT FK_dir_localidad FOREIGN KEY(direccion_localidad_id) REFERENCES [EL_UNICO].localidad(localidad_id);
ALTER TABLE [EL_UNICO].super ADD CONSTRAINT FK_super_direccion FOREIGN KEY(super_direccion_id) REFERENCES [EL_UNICO].direccion(direccion_id);
ALTER TABLE [EL_UNICO].super ADD CONSTRAINT FK_super_condicion_fiscal FOREIGN KEY(super_condicion_fiscal_id) REFERENCES [EL_UNICO].condicion_fiscal(condicion_fiscal_id);
ALTER TABLE [EL_UNICO].cliente ADD CONSTRAINT FK_clie_direccion FOREIGN KEY(cliente_direccion_id) REFERENCES [EL_unico].direccion(direccion_id);
ALTER TABLE [EL_UNICO].envio ADD CONSTRAINT FK_env_envio_estado FOREIGN KEY(envio_envio_estado_id) REFERENCES [EL_UNICO].envio_estado(envio_estado_id);
--ALTER TABLE [EL_UNICO].envio ADD CONSTRAINT FK_env_ticket FOREIGN KEY(envio_ticket_id) REFERENCES [EL_UNICO].ticket(ticket_id);
ALTER TABLE [EL_UNICO].sucursal ADD CONSTRAINT FK_suc_direccion FOREIGN KEY(sucursal_direccion_id) REFERENCES [EL_UNICO].direccion(direccion_id);
ALTER TABLE [EL_UNICO].sucursal ADD CONSTRAINT FK_suc_super FOREIGN KEY(sucursal_super_id) REFERENCES [EL_UNICO].super(super_id);
ALTER TABLE [EL_UNICO].empleado ADD CONSTRAINT FK_empl_sucursal FOREIGN KEY(empleado_sucursal_id) REFERENCES [EL_UNICO].sucursal(sucursal_id)
ALTER TABLE [EL_UNICO].caja ADD CONSTRAINT FK_caja FOREIGN KEY(caja_tipo_caja_id) REFERENCES [EL_UNICO].tipo_caja(tipo_caja_id)
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

----------
	INSERT INTO [EL_UNICO].envio (envio_fecha_programada, envio_hora_inicio, envio_hora_fin, envio_cliente_id, envio_costo, envio_envio_estado_id, envio_fecha_entrega)
	SELECT distinct ENVIO_FECHA_PROGRAMADA, ENVIO_HORA_INICIO, ENVIO_HORA_FIN, cliente_id, ENVIO_COSTO, envio_estado_id, ENVIO_FECHA_ENTREGA
	FROM gd_esquema.Maestra M JOIN [EL_UNICO].cliente c ON M.CLIENTE_APELLIDO = c.cliente_apellido AND M.CLIENTE_NOMBRE = c.cliente_nombre AND M.CLIENTE_DNI = c.cliente_dni
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

DECLARE @cantCajas NVARCHAR(255)
SET @cantCajas = (SELECT COUNT(*) FROM [EL_UNICO].caja)
PRINT('Se agregaron ' + @cantCajas + ' cajas')

SELECT * FROM [EL_UNICO].caja


PRINT('SE LLENARON LAS TABLAS')
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


