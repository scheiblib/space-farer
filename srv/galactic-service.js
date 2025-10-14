require("dotenv").config();
const cds = require("@sap/cds");
const nodemailer = require("nodemailer");

module.exports = cds.service.impl(srv => {
  
  // Handle before CREATE
  srv.before("CREATE", "spacefarers", async req => {
    const body = req.data;
    
    // Validate required fields
    if (!body.name || !body.email) {
      req.error(400, "Spacefarer must have a name and email");
    }

    // Skip planet validation for Admin
    if (!req.user.is('Admin')) {
      // Validate user has access to the planet
      if (!req.user.attr.planet.includes(body.originPlanet)) {
        req.reject(403, `You don't have access to create spacefarers for planet ${body.originPlanet}`);
      }
    }

    // Check email uniqueness
    const existing = await SELECT.one.from("spacefarers").where({ email: body.email });
    if (existing) {
      req.reject(409, `Email '${body.email}' is already registered!`);
    }

    // Set defaults
    body.stardustCollection ||= 10;
    body.wormholeNavigationSkill ||= 1;
    body.originPlanet ||= req.user.attr.planet[0];
  });

  // Handle createSpacefarer action
  srv.on('createSpacefarer', async (req) => {
    // Only admins can use this action (handled by @restrict annotation)
    const { spacefarer } = req.data;
    
    if (!spacefarer.name || !spacefarer.email) {
      req.reject(400, 'Name and email are required');
    }

    const newSpacefarer = {
      ID: cds.utils.uuid(),
      ...spacefarer,
      originPlanet: spacefarer.originPlanet || req.user.attr.planet[0],
      stardustCollection: spacefarer.stardustCollection || 10,
      wormholeNavigationSkill: spacefarer.wormholeNavigationSkill || 1
    };

    try {
      const result = await INSERT.into("spacefarers").entries(newSpacefarer);
      
      // Send welcome email
      const transporter = nodemailer.createTransport({
        host: "smtp.gmail.com",
        port: 465,
        auth: {
          user: process.env.GMAIL_USER,
          pass: process.env.GMAIL_PASS
        }
      });

      const mailOptions = {
        from: '"Galactic HQ" <your-email@gmail.com>',
        to: newSpacefarer.email,
        subject: "Welcome to the Stars, Spacefarer!",
        text: `Congratulations ${newSpacefarer.name}! Your cosmic journey has officially begun.`,
        html: `<h1>Congratulations ${newSpacefarer.name}!</h1><p>Your cosmic journey has officially begun.</p>`
      };

      await transporter.sendMail(mailOptions);
      
      return result;

    } catch (error) {
      req.reject(500, `Error creating spacefarer: ${error.message}`);
    }
  });
});