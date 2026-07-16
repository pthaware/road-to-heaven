require("dotenv").config();

const express = require("express");
const morgan = require("morgan");
const os = require("os");

const app = express();
const APP_PORT = process.env.APP_PORT || 3000;
const APP_NAME = process.env.APP_NAME || "default";
const APP_VERSION= process.env.APP_VERSION || "v0.0.0";

// Middleware
app.use(express.json());
app.use(morgan("dev"));

// Root endpoint
app.get("/", (req, res) => {
  res.json({
    message: "Node.js Server is running",
    port: APP_PORT,
    appName: APP_NAME,
    appVersion: APP_VERSION
  });
});

// Host information endpoint
app.get("/hostname", (req, res) => {
  res.json({
    hostname: os.hostname(),
    platform: os.platform(),
    architecture: os.arch(),
    cpus: os.cpus().length,
    totalMemoryGB: (os.totalmem() / 1024 / 1024 / 1024).toFixed(2),
    freeMemoryGB: (os.freemem() / 1024 / 1024 / 1024).toFixed(2),
    uptimeSeconds: os.uptime(),
    nodeVersion: process.version,
    pid: process.pid,
  });
});

app.listen(APP_PORT, () => {
  console.log(`App-[${APP_NAME}] running on http://localhost:${APP_PORT}`);
});