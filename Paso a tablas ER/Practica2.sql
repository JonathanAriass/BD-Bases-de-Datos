create table entrada (
    codentrada varchar(8),
    precio decimal(2,0),
    sesion varchar(8) not null,
    fecha date not null,
    codsala varchar(8) not null,
    codpelicula varchar(8) not null,
    constraint pk_entrada primary key (codentrada),
    constraint fk_entrada_proyecta foreign key (sesion, fecha, codsala, codpelicula) references proyecta(sesion, fecha, codsala, codpelicula)
);

create table sala (
    codsala varchar(8),
    aforo decimal(2,0),
    constraint pk_sala primary key (codsala)
);

create table cine(
    codcine varchar(8),
    localidad varchar(30),
    constraint pk_cine primary key (codcine)
);

create table cine3d (
    codcine varchar(8),
    numsalas decimal(1,0),
    constraint pk_cine3d primary key (codsala),
    constraint fk_cine3d_cine foreign key (codcine) references cine(codcine)
);

create table pelicula(
    codpelicula varchar(8),
    titulo varchar(20),
    duracion decimal(2,0),
    tipo varchar(20),
    codpelicula_original varchar(8),
    constraint pk_pelicula primary key (codpelicula),
    constraint fk_pelicula_pelicula_original foreign key (codpelicula_original) references pelicula(codpelicula),
    constraint ck_pelicula_tipo check (tipo in ('ficción', 'aventuras', 'terror')),
    constraint uq_pelicula_titulo unique (titulo)
);

create table proyecta(
    sesion varchar(8),
    fecha date,
    entradas_vendidas decimal(2,0),
    codsala varchar(8),
    codpelicula varchar(8),
    constraint pk_proyecta primary key (sesion, fecha, codsala, codpelicula),
    constraint fk_proyecta_sala foreign key (codsala) references sala(codsala),
    constraint fk_poyecta_pelicula foreign key (codpelicula) references pelicula(codpelicula),
    constraint ck_proyecta_sesion check (sesion in ('5', '7', '10'))
);
