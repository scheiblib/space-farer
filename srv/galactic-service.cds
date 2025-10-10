using galactic.space as space from '../db/schema';

service GalacticService {
  entity Spacefarers as projection on space.Spacefarers;
}