create database if not exists eligibility;

use eligibility;

create table if not exists household (
  id int(10) not null auto_increment,
  c4_account_id varchar(40) not null,
  date_created timestamp null default null,
  date_modified timestamp not null default current_timestamp
                on update current_timestamp,
  primary key(id)
);

drop trigger if exists household_bi;
create trigger household_bi before insert on household
for each row set new.date_created = current_timestamp;

create table if not exists address (
  id int(10) not null auto_increment,
  address_line1 varchar(128) not null,
  address_line2 varchar(128) default null,
  po_box varchar(15) default null,
  city varchar(50) not null,
  state varchar(2) not null,
  zip varchar(10) not null,
  county varchar(50) not null,
  date_created timestamp null default null,
  date_modified timestamp not null default current_timestamp
                on update current_timestamp,
  primary key (id)
);

drop trigger if exists address_bi;
create trigger address_bi before insert on address
for each row set new.date_created = current_timestamp;

create table if not exists member (
  id int(10) not null auto_increment,
  household_id int(10) not null,
  first_name varchar(40) not null,
  last_name varchar(40) not null,
  middle_name varchar(40) default null,
  date_of_birth date not null,
  gender enum('m', 'f') not null,
  married enum('1', '0') not null default '0',
  household_contact_indicator enum('1', '0') not null default '0',
  applying_for_coverage_indicator enum('1', '0') not null default '0',
  plan_to_file_ftr_indicator enum('1', '0') not null default '0',
  tax_filer  enum('1', '0') not null default '0',
  tax_filer_dependent enum('1', '0') not null default '0',
  residence_address_id int(10) not null,
  relationship_to_household_contact enum('self', 'spouse', 'child'),
  date_created timestamp null default null,
  date_modified timestamp not null default current_timestamp
                on update current_timestamp,
  primary key (id),
  foreign key (household_id) references household(id),
  foreign key (residence_address_id) references address(id)
);

drop trigger if exists member_bi;
create trigger member_bi before insert on member
for each row set new.date_created = current_timestamp;

create table if not exists household_contact (
  id int(10) not null auto_increment,
  member_id int(10) not null,
  home_phone varchar(15) default null,
  cell_phone varchar(15) default null,
  work_phone varchar(15) default null,
  email varchar(128) default null,
  mailing_address_id int(10) not null,
  date_created timestamp null default null,
  date_modified timestamp not null default current_timestamp
                on update current_timestamp,
  primary key (id),
  foreign key (member_id) references member(id),
  foreign key (mailing_address_id) references address(id)
);

drop trigger if exists household_contact_bi;
create trigger household_contact_bi before insert on member
for each row set new.date_created = current_timestamp;
