namespace galactic.space;
entity Spacefarers {
  key ID : UUID;
  name : String @mandatory;
  email: String(255) @mandatory @assert.unique;
  originPlanet : String default('Earth');
  stardustCollection : Integer;
  wormholeNavigationSkill : Integer;
  spacesuitColor : String;
  department : Association to Departments;
  position   : Association to Positions;
  @cds.on.insert : $now
  createdAt : Timestamp;
}

entity Departments {
  key ID : UUID;
  name : String(100);
  galaxy : String(80);
  established : Integer;
}

type PositionLevel : Integer enum {
  Cadet       = 1;
  Lieutenant  = 2;
  Commander   = 3;
  Captain     = 4;
  Admiral     = 5;
}

entity Positions {
  key ID : UUID;
  title : String(80);
  level : PositionLevel default(1);
  description : String;
}