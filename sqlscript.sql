REM   Script: Movie Database
REM   Movie Database for practice on w3resource.com

CREATE TABLE actor 
( 
    act_id int not null, 
    act_fname varchar(20) not null, 
    act_lname varchar(20) not null, 
    act_gender varchar(1) not null, 
    PRIMARY KEY(act_id) 
);

INSERT ALL 
   into actor values(101,'James','Stewart','M') 
   into actor values(102,'Deborah','Kerr','F') 
   into actor values(103,'Peter','OToole','M') 
   into actor values(104,'Robert','De Niro','M') 
   into actor values(105,'F. Murray','Abraham','M') 
   into actor values(106,'Harrison','Ford','M') 
   into actor values(107,'Nicole','Kidman','F') 
   into actor values(108,'Stephen','Baldwin','M') 
   into actor values(109,'Jack','Nicholson','M') 
   into actor values(110,'Mark','Wahlberg','M') 
   into actor values(111,'Woody','Allen','M') 
   into actor values(112,'Claire','Danes','F') 
   into actor values(113,'Tim','Robbins','M') 
   into actor values(114,'Kevin','Spacey','M') 
   into actor values(115,'Kate','Winslet','F') 
   into actor values(116,'Robin','Williams','M') 
   into actor values(117,'Jon','Voight','M') 
   into actor values(118,'Ewan','McGregor','M') 
   into actor values(119,'Christian','Bale','M') 
   into actor values(120,'Maggie','Gyllenhaal','F') 
   into actor values(121,'Dev','Patel','M') 
   into actor values(122,'Sigourney','Weaver','F') 
   into actor values(123,'David','Aston','M') 
   into actor values(124,'Ali','Astin','F') 
    
   select * from dual;

select * from actor;

CREATE TABLE genres  
( 
    gen_id int not null PRIMARY KEY, 
    gen_title varchar(20) not null 
);

INSERT ALL  
    into genres values(1001,'Action') 
    into genres values(1002,'Adventure') 
    into genres values(1003,'Animation') 
    into genres values(1004,'Biography') 
    into genres values(1005,'Comedy') 
    into genres values(1006,'Crime') 
    into genres values(1007,'Drama') 
    into genres values(1008,'Horror') 
    into genres values(1009,'Music') 
    into genres values(1010,'Mystery') 
    into genres values(1011,'Romance') 
    into genres values(1012,'Thriller') 
    into genres values(1013,'War') 
     
    select * from dual;

CREATE TABLE director 
( 
    dir_id int not null PRIMARY KEY, 
    dir_fname varchar(20) not null, 
    dir_lname varchar(20) not null 
);

INSERT ALL 
    into director values(201,'Alfred','Hitchcock') 
    into director values(202,'Jack','Clayton') 
    into director values(203,'David','Lean') 
    into director values(204,'Michael','Cimino') 
    into director values(205,'Milos','Forman') 
    into director values(206,'Ridley','Scott') 
    into director values(207,'Stanley','Kubrick') 
    into director values(208,'Bryan','Singer') 
    into director values(209,'Roman','Polanski') 
    into director values(210,'Paul','Thomas Anderson') 
    into director values(211,'Woody','Allen') 
    into director values(212,'Hayao','Miyazaki') 
    into director values(213,'Frank','Darabont') 
    into director values(214,'Sam','Mendes') 
    into director values(215,'James','Cameron') 
    into director values(216,'Gus','Van Sant') 
    into director values(217,'John','Boorman') 
    into director values(218,'Danny','Boyle') 
    into director values(219,'Christopher','Nolan') 
    into director values(220,'Richard','Kelly') 
    into director values(221,'Kevin','Spacey') 
    into director values(222,'Andrei','Tarkovsky') 
    into director values(223,'Peter','Jackson') 
     
    select * from dual;

CREATE TABLE movie 
( 
    mov_id int not null PRIMARY KEY, 
    mov_title varchar(50) not null, 
    mov_year int not null, 
    mov_time int not null, 
    mov_lang varchar(50) not null, 
    mov_dt_rel date not null, 
    mov_rel_country varchar(5) 
);

insert all  
    into movie values(901,'Vertigo',1958,128,'English',DATE '1958-08-24','UK') 
    into movie values(902,'The Innocents',1961,100,'English',DATE '1962-02-19','SW') 
    into movie values(903,'Lawrence of Arabia',1962,216,'English',DATE '1962-12-11','UK') 
    into movie values(904,'The Deer Hunter',1978,183,'English',DATE '1979-03-08','UK') 
    into movie values(905,'Amadeus',1984,160,'English',DATE '1985-01-07','UK') 
    into movie values(906,'Blade Runner',1982,117,'English',DATE '1982-09-09','UK') 
    into movie values(907,'Eyes Wide Shut',1999,159,'English',DATE '1999-09-03','UK') 
    into movie values(908,'The Usual Suspects',1995,106,'English',DATE '1995-08-25','UK') 
    into movie values(909,'Chinatown',1974,130,'English',DATE '1974-08-09','UK') 
    into movie values(910,'Boogie Nights',1997,155,'English',DATE '1998-02-16','UK') 
    into movie values(911,'Annie Hall',1977,93,'English',DATE '1977-04-20','USA') 
    into movie values(912,'Princess Mononoke',1997,134,'Japanese',DATE'2001-10-19','UK') 
    into movie values(913,'The Shawshank Redemption',1994,142,'English',DATE '1995-02-17','UK') 
    into movie values(914,'American Beauty',1999,122,'English',DATE '2000-02-18','UK') 
    into movie values(915,'Titanic',1997,194,'English',DATE '1998-01-23','UK') 
    into movie values(916,'Good Will Hunting',1997,126,'English',DATE '1998-06-03','UK') 
    into movie values(917,'Deliverance',1972,109,'English',DATE '1982-10-05','UK') 
    into movie values(918,'Trainspotting',1996,94,'English',DATE '1996-02-23','UK') 
    into movie values(919,'The Prestige',2006,130,'English',DATE '2006-11-10','UK') 
    into movie values(920,'Donnie Darko',2001,113,'English',DATE'2001-01-19','UK') 
    into movie values(921,'Slumdog Millionaire',2008,120,'English',DATE '2009-01-09','UK') 
    into movie values(922,'Aliens',1986,137,'English',DATE '1986-08-29','UK') 
    into movie values(923,'Beyond the Sea',2004,118,'English',DATE '2004-11-26','UK') 
    into movie values(924,'Avatar',2009,162,'English',DATE '2009-12-17','UK') 
    into movie values(925,'Braveheart',1995,178,'English',DATE '1995-09-08','UK') 
    into movie values(926,'Seven Samurai',1954,207,'Japanese',DATE '1954-04-26','JP') 
    into movie values(927,'Spirited Away',2001,125,'Japanese',DATE '2003-09-12','UK') 
    into movie values(928,'Back to the Future',1985,116,'English',DATE '1985-12-04','UK') 
 
     
    select * from dual;

SELECT * FROM MOVIE;

CREATE TABLE movie_genres 
( 
    mov_id int not null PRIMARY KEY, 
    gen_id int not null, 
    CONSTRAINT FK_Movie FOREIGN KEY(mov_id) REFERENCES movie(mov_id) ON DELETE CASCADE, 
    CONSTRAINT FK_Genres FOREIGN KEY(gen_id) REFERENCES genres(gen_id) ON DELETE CASCADE 
);

INSERT ALL  
    into movie_genres values(922,1001) 
    into movie_genres values(917,1002) 
    into movie_genres values(903,1002) 
    into movie_genres values(912,1003) 
    into movie_genres values(911,1005) 
    into movie_genres values(908,1006) 
    into movie_genres values(913,1006) 
    into movie_genres values(926,1007) 
    into movie_genres values(928,1007) 
    into movie_genres values(918,1007) 
    into movie_genres values(921,1007) 
    into movie_genres values(902,1008) 
    into movie_genres values(923,1009) 
    into movie_genres values(907,1010) 
    into movie_genres values(927,1010) 
    into movie_genres values(901,1010) 
    into movie_genres values(914,1011) 
    into movie_genres values(906,1012) 
    into movie_genres values(904,1013) 
     
    select * from dual;

select * from movie_genres;

CREATE TABLE movie_direction 
( 
    dir_id int not null, 
    mov_id int not null, 
    FOREIGN KEY(dir_id) references director, 
    FOREIGN KEY(mov_id) references movie 
);

INSERT ALL  
    into movie_direction values(201,901) 
    into movie_direction values(202,902) 
    into movie_direction values(203,903) 
    into movie_direction values(204,904) 
    into movie_direction values(205,905) 
    into movie_direction values(206,906) 
    into movie_direction values(207,907) 
    into movie_direction values(208,908) 
    into movie_direction values(209,909) 
    into movie_direction values(210,910) 
    into movie_direction values(221,911) 
    into movie_direction values(212,912) 
    into movie_direction values(213,913) 
    into movie_direction values(214,914) 
    into movie_direction values(215,915) 
    into movie_direction values(216,916) 
    into movie_direction values(217,917) 
    into movie_direction values(218,918) 
    into movie_direction values(219,919) 
    into movie_direction values(220,920) 
    into movie_direction values(218,921) 
    into movie_direction values(215,922) 
    into movie_direction values(221,923) 
     
    select * from dual;

CREATE TABLE reviewer 
( 
    rev_id int not null PRIMARY KEY, 
    rev_name varchar(30) 
) 
;

INSERT ALL  
    into reviewer values(9001	,'Righty Sock') 
    into reviewer values(9002,'Jack Malvern') 
    into reviewer values(9003,'Flagrant Baronessa') 
    into reviewer values(9004,'Alec Shaw') 
    into reviewer values(9005,null) 
    into reviewer values(9006,'Victor Woeltjen') 
    into reviewer values(9007,'Simon Wright') 
    into reviewer values(9008,'Neal Wruck') 
    into reviewer values(9009,'Paul Monks') 
    into reviewer values(9010,'Mike Salvati') 
    into reviewer values(9011,null) 
    into reviewer values(9012,'Wesley S. Walker') 
    into reviewer values(9013,'Sasha Goldshtein') 
    into reviewer values(9014,'Josh Cates') 
    into reviewer values(9015,'Krug Stillo') 
    into reviewer values(9016,'Scott LeBrun') 
    into reviewer values(9017,'Hannah Steele') 
    into reviewer values(9018,'Vincent Cadena') 
    into reviewer values(9019,'Brandt Sponseller') 
    into reviewer values(9020,'Richard Adams') 
     
    select * from dual;

select * from reviewer;

CREATE TABLE rating 
( 
    mov_id int not null, 
    rev_id int not null, 
    rev_stars int, 
    num_o_rating int, 
    FOREIGN KEY(mov_id) references movie, 
    FOREIGN KEY(rev_id) references reviewer 
) 
;

insert all  
    into rating values(901,9001,	8.40,	263575) 
    into rating values(902,	9002,	7.90,	20207) 
    into rating values(903,	9003,	8.30,	202778) 
    into rating values(906,	9005,	8.20,	484746) 
    into rating values(924,	9006,	7.30 ,null) 
    into rating values(908,	9007,	8.60,	779489) 
    into rating values(909,	9008,	null,	227235) 
    into rating values(910,	9009,	3.00,	195961) 
    into rating values(911,	9010,	8.10,	203875) 
    into rating values(912,	9011,	8.40, null ) 
    into rating values(914,	9013,	7.00,	862618) 
    into rating values(915,	9001,	7.70,	830095) 
    into rating values(916,	9014,	4.00,	642132) 
    into rating values(925,	9015,	7.70,	81328) 
    into rating values(918,	9016, null	,	580301) 
    into rating values(920,	9017,	8.10,	609451) 
    into rating values(921,	9018,	8.00,	667758) 
    into rating values(922,	9019,	8.40,	511613) 
    into rating values(923,	9020,	6.70,	13091) 
     
    select * from dual;

CREATE TABLE movie_cast 
( 
    act_id int not null, 
    mov_id int not null, 
    role varchar(30) not null, 
    FOREIGN KEY(mov_id) referencing movie, 
    FOREIGN KEY(act_id) referencing actor 
);

INSERT ALL  
    into movie_cast values(101,901,'John Scottie Ferguson') 
    into movie_cast values(102,902,'Miss Giddens') 
    into movie_cast values(103,903,'T.E. Lawrence') 
    into movie_cast values(104,904,'Michael') 
    into movie_cast values(105,905,'Antonio Salieri') 
    into movie_cast values(106,906,'Rick Deckard') 
    into movie_cast values(107,907,'Alice Harford') 
    into movie_cast values(108,908,'McManus') 
    into movie_cast values(110,910,'Eddie Adams') 
    into movie_cast values(111,911,'Alvy Singer') 
    into movie_cast values(112,912,'San') 
    into movie_cast values(113,913,'Andy Dufresne') 
    into movie_cast values(114,914,'Lester Burnham') 
    into movie_cast values(115,915,'Rose DeWitt Bukater') 
    into movie_cast values(116,916,'Sean Maguire') 
    into movie_cast values(117,917,'Ed') 
    into movie_cast values(118,918,'Renton') 
    into movie_cast values(120,920,'Elizabeth Darko') 
    into movie_cast values(121,921,'Older Jamal') 
    into movie_cast values(122,922,'Ripley') 
    into movie_cast values(114,923,'Bobby Darin') 
    into movie_cast values(109,909,'J.J. Gittes') 
    into movie_cast values(119,919,'Alfred Borden') 
     
    select * from dual;

