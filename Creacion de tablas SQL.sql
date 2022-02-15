create table stage.importacionvehiculos
(
   [aduana de ingreso] varchar(30)
  ,[fecha de la poliza] varchar(10)
  ,[partida arancelaria] bigint
  ,[modelo del vehiculo] smallint
  ,[marca] varchar(35)
  ,[linea] varchar(35)
  ,[centimetros cubicos] int
  ,[distintivo] varchar(15)
  ,[tipo de vehiculo] varchar(25)
  ,[tipo de importador] varchar(20)
  ,[tipo combustible] varchar(15)
  ,[asientos] smallint
  ,[puertas] smallint
  ,[tonelaje] real
  ,[valor cif] real
  ,[impuesto] real
  ,[pais de provinencia] varchar(50)
)


insert into [Importacion_vehiculos].[stage].[importacionvehiculos]
select * from [galileo_2022_dwh].[stage].[importacionvehiculos]


select * from [stage].[importacionvehiculos]





select [aduana de ingreso] 
,count(*)
from [stage].[importacionvehiculos]
group by [aduana de ingreso]
order by count(*) desc

--CREACION DE TABLAS DIMENSION DE ADUANAS

create table dim.aduanas
(
  [aduana_sk] int identity(1,1) primary key
, [aduana] varchar(100)  not null 
)

insert into [dim].[aduanas] (aduana)
select distinct [aduana de ingreso] from [stage].[importacionvehiculos]

set identity_insert dim.aduanas on
insert into dim.aduanas (aduana_sk, aduana) values (-1, 'Desconocido'), (-2,'No Aplica')
set identity_insert dim.aduanas off


select * from [dim].[aduanas]

--CREACION DE TABLA DIMENSION PAISES
create table [dim].[paises]
(
[pais_sk] int identity(1,1) primary key
, [pais] varchar(100)  not null 
)

set identity_insert dim.paises on
insert into [dim].[paises] (pais_sk, pais) values (-1, 'Desconocido'), (-2,'No Aplica')
set identity_insert dim.paises off

insert into [dim].[paises] (pais)
select distinct [pais de proveniencia] from [stage].[importacionvehiculos]

select * from dim.paises


--CREACION DE TABLA DIMENSION TIPOS DE IMPORTADOR
create table [dim].[tipos_de_importador]
(
[tipo_importador_sk] int identity(1,1) primary key
, [tipo_importador] varchar(100)  not null 
)

set identity_insert [dim].[tipos_de_importador] on
insert into [dim].[tipos_de_importador] (tipo_importador_sk, tipo_importador) values (-1, 'Desconocido'), (-2,'No Aplica')
set identity_insert [dim].[tipos_de_importador] off

insert into [dim].[tipos_de_importador] (tipo_importador)
select distinct [tipo de importador] from [stage].[importacionvehiculos]

select * from [dim].[tipos_de_importador]


--CREACION DE TABLA DIMENSION PARTIDA ARANCELARIA
create table [dim].[partida_arancelaria]
(
   [partida_arancelaria_sk] int identity(1,1) primary key
 , [partida_arancelaria] varchar(100)  not null 
)

set identity_insert  [dim].[partida_arancelaria] on
insert into [dim].[partida_arancelaria] (partida_arancelaria_sk, partida_arancelaria) values (-1, 'Desconocido'), (-2,'No Aplica')
set identity_insert [dim].[partida_arancelaria] off

insert into [dim].[partida_arancelaria] (partida_arancelaria)
select distinct [partida arancelaria] from [stage].[importacionvehiculos]

select * from [dim].[partida_arancelaria]
