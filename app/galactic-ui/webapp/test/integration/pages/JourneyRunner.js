sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"galacticui/test/integration/pages/spacefarersList",
	"galacticui/test/integration/pages/spacefarersObjectPage"
], function (JourneyRunner, spacefarersList, spacefarersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('galacticui') + '/test/flp.html#app-preview',
        pages: {
			onThespacefarersList: spacefarersList,
			onThespacefarersObjectPage: spacefarersObjectPage
        },
        async: true
    });

    return runner;
});

