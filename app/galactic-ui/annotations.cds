using GalacticService as service from '../../srv/galactic-service';
annotate service.Spacefarers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'ID',
                Value : ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'name',
                Value : name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'originPlanet',
                Value : originPlanet,
            },
            {
                $Type : 'UI.DataField',
                Label : 'stardustCollection',
                Value : stardustCollection,
            },
            {
                $Type : 'UI.DataField',
                Label : 'wormholeNavigationSkill',
                Value : wormholeNavigationSkill,
            },
            {
                $Type : 'UI.DataField',
                Label : 'spacesuitColor',
                Value : spacesuitColor,
            },
            {
                $Type : 'UI.DataField',
                Label : 'createdAt',
                Value : createdAt,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'ID',
            Value : ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Origin planet',
            Value : originPlanet,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Stardust collection',
            Value : stardustCollection,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Wormhole navigation skill',
            Value : wormholeNavigationSkill,
        },
    ],
);

