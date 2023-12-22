create table info (

info_idx int auto_increment,
info_title varchar(90) not null,
info_content text not null,
info_date datetime not null, 
user_idx int,
info_tag varchar(15),
info_count int,

 primary key(info_idx),
 FOREIGN KEY (user_idx) REFERENCES User (user_idx)
 )

 Drop table info;