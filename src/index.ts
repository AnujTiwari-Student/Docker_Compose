import { PrismaClient } from "@prisma/client";
import express from "express"

const app = express();
const prisma = new PrismaClient();

app.get('/', async (req, res) => {
    const user = await prisma.user.findMany();
    return res.json(user)
})

app.post('/',async (req, res) => {
    await prisma.user.create({
        data: {
            name: Math.random().toString(),
            email: Math.random().toString() + "@example.com",
            password: "password"
        }
    })
})

app.listen(3000, () => {
    console.log("Server is running on port 3000")
})