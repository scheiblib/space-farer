const cds = require("@sap/cds");
module.exports = cds.service.impl(srv => {
  srv.before("CREATE", "Spacefarers", req => {
    req.data.stardustCollection ||= 10;
    req.data.wormholeNavigationSkill ||= 1;
  });
});