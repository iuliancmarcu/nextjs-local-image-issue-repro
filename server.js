const { createServer } = require("https");
const { parse } = require("url");
const next = require("next");
const fs = require("fs");
const path = require("path");

const dev = process.env.NODE_ENV !== "production";
const hostname = "local.mycorp.app";
const port = 3000;

const app = next({ dev, hostname, port });

const cert = path.join(process.cwd(), "local.mycorp.app.pem");
const key = path.join(process.cwd(), "local.mycorp.app-key.pem");

const httpsOptions = {
  key: fs.readFileSync(key, "utf8"),
  cert: fs.readFileSync(cert, "utf8"),
};

app.prepare().then(() => {
  const handle = app.getRequestHandler();
  createServer(httpsOptions, (req, res) => {
    let parsedUrl = parse(req.url, true);
    handle(req, res, parsedUrl);
  }).listen(port, (err) => {
    if (err) throw err;
    console.log(`> Server started on https://${hostname}:${port}`);
  });
});
