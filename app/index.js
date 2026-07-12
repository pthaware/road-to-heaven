const express = require("express");
const morgan = require("morgan");
const cors = require("cors");

const app = express();
const PORT = process.env.PORT || 3000;
const DOCKER_IMAGE = process.env.DOCKER_IMAGE || "v1";

// Middlewares
app.use(cors());
app.use(morgan("dev"));
app.use(express.json());

// Routes
app.get("/", (req, res) => {
    res.json({
        message: "Hello from Docker!",
        image: DOCKER_IMAGE,
        status: "Server is running 🚀"
    });
});

app.get("/health", (req, res) => {
    res.status(200).json({
        status: "OK"
    });
});

app.get("/users", (req, res) => {
    res.json([
        { id: 1, name: "Piyush" },
        { id: 2, name: "John" }
    ]);
});

app.listen(PORT, () => {
    console.log(
        `Server (${DOCKER_IMAGE}) running on http://localhost:${PORT}`
    );
});