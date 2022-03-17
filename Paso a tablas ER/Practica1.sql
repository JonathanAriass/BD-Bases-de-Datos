create table alumno (
    dnia varchar(9),
    noma varchar(50),
    apella varchar(50),
    domicilioa varchar(50),
    f_nacimiento date,
    f_ingreso date,
    constraint pk_alumno primary key (dnia)
);


create table carrera (
    codcarr varchar(9),
    nombrec varchar(30),
    duracion decimal(1,0),
    constraint pk_carrera primary key (codcarr)
);

create table asignatura (
    codasig varchar(8),
    nomasig varchar(20),
    curso decimal(1,0),
    creditos decimal(1,0),
    tipo varchar(20),
    codcarr varchar(9) not null,
    constraint pk_asignatura primary key (codasig),
    constraint fk_asignatura_carrera foreign key (codcarr) references carrera(codcarr),
    constraint uq_asignatura_nomasig unique (nomasig),
    constraint ck_asignatura_tipo check (tipo in ('obligatoria', 'optativa', 'libre configuracion'))
);

create table imparte (
    codasig varchar(8),
    dnip varchar(9),
    constraint pk_imparte primary key (codasig, dnip),
    constraint fk_imparte_asignatura foreign key (codasig) references asignatura(codasig),
    constraint fk_imparte_profesor foreign key (dnip) references profesor(dnip)
);

create table profesor (
    dnip varchar(9),
    nombrep varchar(30),
    apellidop varchar(30),
    domicilioa varchar(50),
    constraint pk_profesor primary key (dnip),

);

create table califica (
    nota decimal(2,0),
    fecha_calificacion date,
    dnip varchar(9) not null,
    dnia varchar(9),
    codasig varchar(8),
    constraint pk_califica primary key (dnia, codasig),
    constraint fk_califica_alumno foreign key (dnia) references alumno(dnia),
    constraint fk_califica_profesor foreign key (dnip) references profesor(dnip),
    constraint fK_califica_asignatura foreign key (codasig) references asignatura(codasig)
);

create table califica2 (
    nota decimal(2,0)
    fecha_calificacion date,
    dnia varchar(9),
    dnip varchar(9),
    codasig varchar(8),
    constraint pk_califica2 primary key (dnia, dnip, codasig),
    constraint fk_califica2_alumno foreign key (dnia) references alumno(dnia),
    constraint fk_califica2_imparte foreign key (dnip,codasig) references imparte(dnip,codasig),
    constraint uq_califica2_alumno_asignatura unique (dnia,codasig)
);

