namespace galactic.space;

entity Spacefarers {
  key ID : Integer;
  name : String;
  originPlanet : String;
  stardustCollection : Integer;
  wormholeNavigationSkill : Integer;
  spacesuitColor : String;

  @cds.on.insert : $now
  createdAt : Timestamp;
}