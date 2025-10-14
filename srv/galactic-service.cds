using galactic.space as space from '../db/schema';

service GalacticService {
  @odata.draft.enabled
  @requires: 'authenticated-user'
  @(
    restrict: [
      { grant: 'READ', to: ['Viewer', 'Editor', 'Admin'] },
      { grant: ['CREATE', 'UPDATE'], to: ['Editor'], where: 'originPlanet in $user.attributes.planet' },
      { grant: ['CREATE', 'UPDATE'], to: ['Admin'] },  // Admin can access all planets
      { grant: ['DELETE'], to: ['Admin'] }
    ]
  )
  entity spacefarers as projection on space.spacefarers;
  entity Positions   as projection on space.Positions;
  entity Departments as projection on space.Departments;

  type SpacefarerInput {
    name: String;
    email: String;
    originPlanet: String;
    stardustCollection: Integer;
    wormholeNavigationSkill: Integer;
    spacesuitColor: String;
  }

  @(restrict: [{ grant: ['*'], to: ['Admin'] }])
  action createSpacefarer(spacefarer: SpacefarerInput)
}

