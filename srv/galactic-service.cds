using galactic.space as space from '../db/schema';

service GalacticService {
  @odata.draft.enabled
  entity Spacefarers as projection on space.Spacefarers;
  entity Positions   as projection on space.Positions;
  entity Departments as projection on space.Departments;
}
