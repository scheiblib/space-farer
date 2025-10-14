using GalacticService as service from '../../srv/galactic-service';

////////////////////////////////////////////////////////////////////////////
//
//  List Report - Galactic spacefarers
//  Displays all spacefarers with stardust collection and spacesuit color
//  Supports sorting, filtering, and pagination
//
////////////////////////////////////////////////////////////////////////////

/**
 * Selection Fields - Filters for the List Report
 */
annotate service.spacefarers with @(
    UI.SelectionFields: [
        name,
        email,
        originPlanet,
        spacesuitColor,
        stardustCollection,
        wormholeNavigationSkill,
        department_ID,
        position_ID
    ]
);

annotate service.spacefarers with {
    name @(
        title: 'Spacefarer Name',
        Common.FieldControl: {
            $value: #Mandatory,
            ![@UI.Hidden]: {
                $edmJson: {
                    $Ne: [{$Path: 'IsActiveEntity'}, true]
                }
            }
        },
        Core.Immutable: true,
        Common.Label: 'Name'
    );
    
    email @(
        title: 'Email',
        Common.FieldControl: {
            $value: #Mandatory,
            ![@UI.Hidden]: {
                $edmJson: {
                    $Ne: [{$Path: 'IsActiveEntity'}, true]
                }
            }
        },
        Core.Immutable: true,
        Common.Label: 'Email'
    );
    
    originPlanet @(
        title: 'Origin Planet',
        Common.FieldControl: #ReadOnly
    );
    
    wormholeNavigationSkill @(
        title: 'Wormhole Navigation Skill',
        Common.FieldControl: #ReadOnly,
        Common.Label: 'Skill Level'
    );
    
    createdAt @(
        title: 'Joined Date',
        Common.FieldControl: #ReadOnly
    );
    
    department @(
        Common.FieldControl: #ReadOnly
    );
    
    position @(
        Common.FieldControl: #ReadOnly
    );
    
    // EDITABLE FIELDS (can edit) ✏️
    stardustCollection @(
        title: 'Stardust Collection',
        Common.FieldControl: #Mandatory,  // Editable & Required
        Common.Label: 'Stardust Particles'
    );
    
    spacesuitColor @(
        title: 'Spacesuit Color',
        Common.FieldControl: #Optional,  // Editable but Optional
        Common.Label: 'Suit Color'
    );
}

annotate service.spacefarers with @(
    UI.Facets: [
        {
            $Type: 'UI.ReferenceFacet',
            Label: 'Spacefarer Details',
            Target: '@UI.FieldGroup#GeneratedGroup'
        }
    ]
);

annotate service.spacefarers with @(
    UI.HeaderInfo: {
        TypeName: 'Spacefarer',
        TypeNamePlural: 'spacefarers',
        Title: { Value: name },
        Description: { Value: email }
    }
);

annotate service.spacefarers with {
    spacesuitColor @UI.FieldControl : #Editable;
    stardustCollection @UI.FieldControl : #Editable;
};

annotate service.spacefarers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Label : 'Name', Value : name },
            { $Type : 'UI.DataField', Label : 'E-mail', Value : email },
            { $Type : 'UI.DataField', Label : 'Spacesuit Color', Value : spacesuitColor },
            { $Type : 'UI.DataField', Label : 'Stardust Collection', Value : stardustCollection }
        ]
    }
);

//Line Item - Table columns in List Report
//Shows stardust collection status and spacesuit color

annotate service.spacefarers with @(
    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: 'Spacefarer Name',
            ![@UI.Importance]: #High
        },
        {
            $Type: 'UI.DataField',
            Value: email,
            Label: 'Email',
            ![@UI.Importance]: #High
        },
        {
            $Type: 'UI.DataField',
            Value: originPlanet,
            Label: 'Origin Planet',
            ![@UI.Importance]: #Medium
        },
        {
            $Type: 'UI.DataField',
            Value: stardustCollection,
            Label: 'Stardust Collection',
            ![@UI.Importance]: #High,
            CriticalityRepresentation: #WithIcon
        },
        {
            $Type: 'UI.DataField',
            Value: wormholeNavigationSkill,
            Label: 'Navigation Skill',
            ![@UI.Importance]: #Medium
        },
        {
            $Type: 'UI.DataField',
            Value: spacesuitColor,
            Label: 'Spacesuit Color',
            ![@UI.Importance]: #High
        },
        {
            $Type: 'UI.DataField',
            Value: department.name,
            Label: 'Department',
            ![@UI.Importance]: #Medium
        },
        {
            $Type: 'UI.DataField',
            Value: position.title,
            Label: 'Position',
            ![@UI.Importance]: #Medium
        }
    ],
    
    // Enable presentation variants for different views
    UI.PresentationVariant: {
        $Type: 'UI.PresentationVariantType',
        SortOrder: [
            {
                Property: stardustCollection,
                Descending: true
            },
            {
                Property: name,
                Descending: false
            }
        ],
        Visualizations: ['@UI.LineItem']
    }
);

//Value Help for Department filtering

annotate service.spacefarers with {
    department @(
        Common.Label: 'Department',
        Common.ValueList: {
            Label: 'Intergalactic Departments',
            CollectionPath: 'Departments',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: department_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'galaxy'
                }
            ]
        },
        Common.Text: department.name,
        Common.TextArrangement: #TextOnly
    );
}


//Value Help for Position filtering

annotate service.spacefarers with {
    position @(
        Common.Label: 'Position',
        Common.ValueList: {
            Label: 'Galactic Positions',
            CollectionPath: 'Positions',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: position_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'title'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'level'
                }
            ]
        },
        Common.Text: position.title,
        Common.TextArrangement: #TextOnly
    );
}


//Selection Variant - Predefined filter for high performers

annotate service.spacefarers with @(
    UI.SelectionVariant#HighPerformers: {
        $Type: 'UI.SelectionVariantType',
        Text: 'High Performers',
        SelectOptions: [
            {
                PropertyName: stardustCollection,
                Ranges: [{
                    Sign: #I,
                    Option: #GE,
                    Low: 500
                }]
            },
            {
                PropertyName: wormholeNavigationSkill,
                Ranges: [{
                    Sign: #I,
                    Option: #GE,
                    Low: 70
                }]
            }
        ]
    },
    
    UI.SelectionVariant#Beginners: {
        $Type: 'UI.SelectionVariantType',
        Text: 'Beginners',
        SelectOptions: [
            {
                PropertyName: wormholeNavigationSkill,
                Ranges: [{
                    Sign: #I,
                    Option: #LE,
                    Low: 30
                }]
            }
        ]
    }
);

////////////////////////////////////////////////////////////////////////////
//
//  Department Entity Annotations
//
////////////////////////////////////////////////////////////////////////////

annotate service.Departments with @(
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: name
        }
    ],
    
    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: galaxy,
            Label: 'Code'
        },
        {
            $Type: 'UI.DataField',
            Value: name,
            Label: 'Department Name'
        },
        {
            $Type: 'UI.DataField',
            Value: established,
            Label: 'Established'
        }
    ]
);

annotate service.Departments with {
    name @title: 'Department Name';
    galaxy @title: 'Department galaxy';
    established @title: 'Department established';
}

////////////////////////////////////////////////////////////////////////////
//
//  Position Entity Annotations
//
////////////////////////////////////////////////////////////////////////////

annotate service.Positions with @(
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: title
        }
    ],
    
    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: level,
            Label: 'Level'
        },
        {
            $Type: 'UI.DataField',
            Value: title,
            Label: 'Position Title'
        },
        {
            $Type: 'UI.DataField',
            Value: description,
            Label: 'Description'
        }
    ]
);

annotate service.Positions with {
    title @title: 'Title';
    level @title: 'Level';
    description @title: 'Position description';
}