require("dotenv").config();
const cds = require("@sap/cds");
const nodemailer = require("nodemailer");
module.exports = cds.service.impl(srv => {
  
  srv.before("CREATE", "Spacefarers", async req => {
    const body = req.data;
    console.log(JSON.stringify(body));
    if (!body.name || !body.email) {
      req.error(400, "Spacefarer must have a name and email");
    }
    const { email } = req.data;

    if (email) {
      const existing = await SELECT.one.from("Spacefarers")
        .where({ email: email });

      if (existing) {
        req.reject(409, `Email '${email}' is already registered!`);
      }
    }
    body.stardustCollection ||= 10;        // default stardust
    body.wormholeNavigationSkill ||= 1;   // default wormhole skill
  });

  srv.before('UPDATE', 'Spacefarers', async (req) => {
    const { email } = req.data;

    // RESTRICT: Block email modification on UPDATE
    if (email !== undefined) {
      req.reject(400, `Email cannot be modified once set! Contact galactic administrator for changes.`);
    }
  });

  srv.after("CREATE", "Spacefarers", async (data, req) => {
    const spacefarerName = data.name;
    const recipientEmail = data.email;

    if (!recipientEmail) return;

    const transporter = nodemailer.createTransport({
      host: "smtp.gmail.com",
      port: 465,
      auth: {
        user: process.env.GMAIL_USER,
        pass: process.env.GMAIL_PASS
      }
    });
    //console.log(JSON.stringify(transporter));
    const mailOptions = {
      from: '"Galactic HQ" <your-email@gmail.com>',
      to: recipientEmail,
      subject: "Welcome to the Stars, Spacefarer!",
      text: `Congratulations ${spacefarerName}! Your cosmic journey has officially begun.`,
      html: `<h1>Congratulations ${spacefarerName}!</h1><p>Your cosmic journey has officially begun.</p>`
    };

    try {
      await transporter.sendMail(mailOptions);
      console.log(`Email sent to ${spacefarerName} (${recipientEmail})`);
    } catch (err) {
      console.error("Error sending email:", err);
    }
  });

});