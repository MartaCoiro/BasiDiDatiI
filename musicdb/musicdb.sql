DROP database IF EXISTS musicdb;
CREATE database musicdb;

/*DROP USER [IF EXISTS] 'airuser'@'localhost' ; */
CREATE USER 'airuser'@'localhost' IDENTIFIED BY 'airuser';
GRANT ALL ON musicdb. * TO 'airuser'@'localhost';

USE musicdb;


CREATE TABLE AccountUtente  (
  Nickname varchar(50) not null,
  NumeroFollower int not null,
  primary key (Nickname)
);

load data local infile 'accountutente.sql'
into table AccountUtente(Nickname, NumeroFollower);

CREATE TABLE Playlist (
	CodicePlaylist int not null,
    Nome varchar(20) not null,
    RadiodellaPlaylist varchar(20),
    NumeroBrani int not null,
    primary key(CodicePlaylist)
    );
    
load data local infile 'playlist.sql'
into table Playlist(CodicePlaylist,Nome,RadiodellaPlaylist,NumeroBrani);

CREATE TABLE Creare (
	Nickname varchar(50),
    CodicePlaylist int not null,
    primary key(Nickname,CodicePlaylist),
    foreign key(Nickname) references AccountUtente (Nickname),
    foreign key(CodicePlaylist) references Playlist (CodicePlaylist)
);

load data local infile 'creare.sql'
into table Creare(Nickname,CodicePlaylist);
    
CREATE TABLE Pubblica (
	NumeroFollowerPlaylist int not null,
    CodicePlaylist int not null,
    primary key(CodicePlaylist),
    foreign key(CodicePlaylist) references Playlist (CodicePlaylist)
    );
    
load data local infile 'pubblica.sql'
into table Pubblica(NumeroFollowerPlaylist,CodicePlaylist);

CREATE TABLE Album (
	CodiceAlbum int not null,
    NomeAlbum varchar(30) not null,
    DatadiPubblicazione date not null,
    primary key(CodiceAlbum)
    );
    
load data local infile 'album.sql'
into table Album(CodiceAlbum,NomeAlbum,DatadiPubblicazione);

CREATE TABLE Brano (
	Codice int not null,
    Titolo varchar(50) not null,
    Durata float,
    CodiceAlbum int not null,
    primary key(Codice),
    foreign key(CodiceAlbum) references Album(CodiceAlbum)
    );
    
load data local infile 'brano.sql'
into table Brano(Codice,Titolo,Durata,CodiceAlbum);
    
CREATE TABLE Costituire (
	CodicePlaylist int not null,
    CodiceBrano int not null,
    primary key(CodicePlaylist,CodiceBrano),
    foreign key(CodicePlaylist) references Playlist(CodicePlaylist),
    foreign key(CodiceBrano) references Brano(Codice)
    );
    
load data local infile 'costituire.sql'
into table Costituire(CodicePlaylist,CodiceBrano);
    
    CREATE TABLE Artista (
	NomeArtista varchar(20) not null,
    Descrizione varchar(100),
    Offerta char(10),
    Collaborazioni char(30),
    NumeroAscoltatori int not null,
    primary key(NomeArtista)
    );
    
load data local infile 'artista.sql'
into table Artista(NomeArtista,Descrizione,Offerta,Collaborazioni,NumeroAscoltatori);
    
CREATE TABLE Scrivere (
	CodiceBrano int not null,
    NomeArtista varchar(20) not null,
    primary key(NomeArtista,CodiceBrano),
    foreign key(NomeArtista) references Artista(NomeArtista),
    foreign key(CodiceBrano) references Brano(Codice)
    );
    
load data local infile 'scrivere.sql'
into table Scrivere(CodiceBrano,NomeArtista);

CREATE TABLE Seguire (
	NomeArtista varchar(20) not null,
    Nickname varchar(50) not null,
    primary key(NomeArtista,Nickname),
    foreign key(NomeArtista) references Artista(NomeArtista),
    foreign key(Nickname) references AccountUtente(Nickname)
    );
    
load data local infile 'seguire.sql'
into table Seguire(NomeArtista,Nickname);
    
CREATE TABLE Produce (
	NomeArtista varchar(20) not null,
    CodiceAlbum int not null,
    primary key(NomeArtista,CodiceAlbum),
    foreign key(NomeArtista) references Artista(NomeArtista),
    foreign key(CodiceAlbum) references Album(CodiceAlbum)
    );
    
load data local infile 'produce.sql'
into table Produce(NomeArtista,CodiceAlbum);

CREATE TABLE GenereMusicale (
	IDGenere int not null,
    Categoria char(20) not null,
    primary key(IDGenere)
    );
    
load data local infile 'generemusicale.sql'
into table GenereMusicale(IDGenere,Categoria);

    
CREATE TABLE Suona (
	NomeArtista varchar(20) not null,
    IDGenere int not null,
    primary key(NomeArtista,IDGenere),
    foreign key(NomeArtista) references Artista(NomeArtista),
    foreign key(IDGenere) references GenereMusicale(IDGenere)
    );
    
load data local infile 'suona.sql'
into table Suona(NomeArtista,IDGenere);

CREATE TABLE StazioneRadio (
	Frequenza float not null,
    NomeRadio varchar(20) not null,
    Nickname varchar(50) not null,
    primary key(Frequenza),
    foreign key(Nickname) references AccountUtente(Nickname)
    );
    
load data local infile 'stazioneradio.sql'
into table StazioneRadio(Frequenza,NomeRadio,Nickname);
    
    
CREATE TABLE Contiene (
	CodiceBrano int not null,
    FrequenzaRadio float not null,
    primary key(CodiceBrano,FrequenzaRadio),
    foreign key(CodiceBrano) references Brano(Codice),
    foreign key(FrequenzaRadio) references StazioneRadio(Frequenza)
    );
    
load data local infile 'contiene.sql'
into table Contiene(CodiceBrano,FrequenzaRadio);

CREATE TABLE Podcast (
	NomePodcast varchar(30) not null,
    Ideatore char(20) not null,
    Descrizione varchar(100),
    Durata float not null,
    NumeroEpisodi int not null,
    DataEp date not null,
    primary key(NomePodcast)
    );
    
load data local infile 'podcast.sql'
into table Podcast(NomePodcast,Ideatore,Descrizione,Durata,NumeroEpisodi,DataEp);
    

CREATE TABLE Ascolta (
	Nickname varchar(50) not null,
    NomePodcast varchar(30) not null,
    primary key(Nickname,NomePodcast),
    foreign key(Nickname) references AccountUtente(Nickname),
    foreign key(NomePodcast) references Podcast(NomePodcast)
    );
    
load data local infile 'ascolta.sql'
into table Ascolta(Nickname,NomePodcast);
    
