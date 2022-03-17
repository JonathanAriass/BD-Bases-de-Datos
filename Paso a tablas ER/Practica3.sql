create table estacion (
    enombre varchar(20),
    transformadores decimal(3,0),
    constraint pk_estacion primary key (enombre),
);

create table red_distribucion (
    numred decimal(3,0),
    longitudmaxima decimal(10,2),
    enombre varchar(20),
    constraint pk_red_distribucion primary key (numred),
    constraint fk_red_distribucion_estacion foreign key (enombre) references estacion(enombre)
);

create table envia_energia (
    numred_envia decimal(3,0),
    numred_recibe decimal(3,0),
    volumen decimal(6,0) not null,
    constraint pk_envia_energia primary key (numred_envia, numred_recibe),
    constraint fk_envia_energia_envia foreign key (numred_envia) references red_distribucion(numred_envia),
    constraint fk_envia_energia_recibe foreign key (numred_recibe) references red_distribucion(numred_recibe),
    constraint ck_envia_energia_volumen check (volumen >= 0)    
);

create table pertenece (
    numred decimal(3,0),
    cnombre varchar(20),
    numacciones decimal(3,0),
    constraint pk_pertenece primary key (numred, cnombre),
    constraint fk_pertenece_red_distribucion foreign key (numred) references red_distribucion(numred),
    constraint fk_pertenece_compañia foreign key (cnombre) references compañia(cnombre)

);

create table compañia (
    cnombre varchar(20),
    capitalsocial varchar(20),
    constraint pk_compañia primary key (cnombre)
);

create table linea (
    numred decimal(3,0),
    nlinea decimal(2,0),
    longitud decimal(10,2) not null,
    constraint pk_linea primary key (numred, nlinea),
    constraint fk_linea_red_distribucion foreign key (numred) references red_distribucion(numred),
    constraint ck_linea_longitud check (longitud >= 0)
);

create table subestacion (
    nsubestacion decimal(2,0),
    capacidad decimal(6,2),
    nlinea decimal(2,0) not null,
    numred decimal(3,0) not null,
    constraint pk_subestacion primary key (nsubestacion),
    constraint fk_subestacion_nlinea foreign key (nlinea) references linea(nlinea),
    constraint fk_subestacion_red_distribucion foreign key (numred) references red_distribucion(numred),
    constraint ck_subestacion_capacidad check (capacidad >= 0)
);

create table distribuye (
    cantidad decimal (6,0) not null,
    fecha date not null,
    nsubestacion decimal(2,0),
    zcodigo varchar(6),
    constraint pk_distribuye primary key (nsubestacion, zcodigo),
    constraint fk_distribuye_subestacion foreign key (nsubestacion) references subestacion(nsubestacion),
    constraint fk_distribuye_zona foreign key (zcodigo) references zona(zcodigo),
    constraint ck_distribuye_cantidad check (cantidad >= 0)
);

create table zona (
    zcodigo varchar(6),
    consumomedio decimal(9,2) not null,
    consInstituciones decimal(9,2) not null,
    consParticulares decimal(9,2) not null,
    consEmpresas decimal(9,2) not null,
    pcodigo varchar(5) not null,
    constraint pk_zona primary key (zcodigo),
    constraint fk_zona_provincia foreign key (pcodigo) references provincia(pcodigo)
    constraint ck_zona_consumomedio check (consumomedio >= 0),
    constraint ck_zona_consInstituciones check (consInstituciones >= 0),
    constraint ck_zona_consParticulares check (consParticulares >= 0),
    constraint ck_zona_consEmpresas check (consEmpresas >= 0),
);

create table provincia (
    pcodigo varchar(5),
    nombre varchar(40) not null,
    constraint pk_provincia primary key (pcodigo)
);



create table entrega (
    cantidad decimal(6,0) not null,
    fecha date not null,
    enombre varchar(20),
    pnombre varchar(20),
    constraint pk_entrega primary key (enombre, pnombre),
    constraint fk_entrega_estacion foreign key (enombre) references estacion(enombre),
    constraint fk_entrega_productor foreign key (pnombre) references productor(pnombre),
    constraint ck_entrega_cantidad check (cantidad >= 0),
);



create table productor (
    pnombre varchar(20),
    prodmedia decimal(9,2) not null,
    prodmaxima decimal(9,2) not null,
    fecha date not null,
    constraint pk_productor primary key (pnombre),
    constraint ck_productor_prodmedia check (prodmedia >= 0),
    constraint ck_productor_prodmaxima check (prodmaxima >= 0)
);

create table hidroelectrica (
    ocupacion decimal(9,2) not null,
    capmaxima decimal(9,2) not null,
    numturbinas decimal(2,0) not null,
    pnombre varchar(20),
    constraint pk_hidroelectrica primary key (pnombre),
    constraint fk_hidroelectrica_productor foreign key (pnombre) references productor(pnombre),
    constraint ck_hidroelectrica_ocupacion check (ocupacion >= 0),
    constraint ck_hidroelectrica_capmaxima check (capmaxima >= 0),
    constraint ck_hidroelectrica_numturbinas check (numturbinas >=0)
);

create table solar (
    paneles decimal(6,0) not null,
    horassol decimal(8,2) not null,
    tipo char(1) not null,
    pnombre varchar(20),
    constraint pk_solar primary key (pnombre),
    constraint fk_solar_productor foreign key (pnombre) references productor(pnombre),
    constraint ck_solar_paneles check (paneles >= 0),
    constraint ck_solar_horassol check (horassol >= 0),
    constraint ck_solar_tipo check (tipo in ('fotovoltaica', 'termodinámica')),
);

create table termica (
    hornos decimal(2,0) not null,
    carbon decimal(6,0) not null,
    gases decimal(6,0) not null,
    pnombre varchar(20),
    constraint pk_termica primary key (pnombre),
    constraint fk_termica_productor foreign key (pnombre) references productor(pnombre),
    constraint ck_termica_hornos check (hornos >= 0),
    constraint ck_termica_carbon check (carbon >= 0),
    constraint ck_termica_gases check (gases >= 0)
);

create table nuclear(
    numreactores decimal() not null,
    plutonio decimal() not null,
    residuos decimal() not null,
    pnombre varchar(20),
    constraint pk_nuclear primary key (pnombre),
    constraint fk_nuclear_productor foreign key (pnombre) references productor(pnombre),
    constraint ck_nuclear_numreactores check (numreactores >= 0),
    constraint ck_nuclear_plutonio check (plutonio >= 0),
    constraint ck_nuclear_residuos check (residuos >= 0)
);

create table compra(
    cantidad decimal(9,2) not null,
    pnombre varchar(20),
    tnombre varchar(20),
    matricula varchar(8),
    snombre varchar(20),
    pais varchar(20),
    constraint pk_compra primary key (pnombre, tnombre, matricula, snombre, pais),
    constraint fk_compra_transportisa foreign key (tnombre, matricula) references transportista(tnombre, matricula),
    constraint fk_compra_suminstrador foreign key (snombre, pais) references suministrador(snombre, pais),
    constraint fk_compra_nuclear foreign key (pnombre) references nuclear(pnombre),
    constraint ck_compra_cantidad check (cantidad >= 0)
);

create table transportista(
    tnombre varchar(20),
    matricula varchar(8),
    horasconducidas decimal(10,0),
    constraint pk_transportista primary key (tnombre, matricula),
    constraint ck_transportista_horasconducidas check (horasconducidas >= 0)
);

creat table suministrador(
    snombre varchar(20),
    pais varchar(20),
    stock decimal(10,0),
    constraint pk_suministrador primary key (snombre, pais),
    constraint ck_suministrador check (stock >= 0)
);